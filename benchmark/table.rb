require "active_record"
require "pg"
require "erb"

class PerformanceLog < ActiveRecord::Base
  self.table_name = :action_controller_log
end

class Entry
  attr_reader :query

  def initialize(query, records)
    @query = query
    @records = records
  end

  %w[
    redmine-mariadb
    redmine-mroonga0
    redmine-mroonga
    redmine-postgresql
    redmine-pgroonga0
    redmine-pgroonga
  ].each do |hostname|
    db = hostname.gsub(/\Aredmine-/, "")
    define_method(db) do
      @records.select do |record|
        record.hostname == hostname
      end
    end
  end

  def format_mariadb(column)
    elements = []
    elements.concat(mariadb.map(&column))
    elements.concat(mroonga0.map(&column))
    elements.concat(mroonga.map(&column))
    elements.join(" | ")
  end

  def format_postgresql(column)
    elements = []
    elements.concat(postgresql.map(&column))
    elements.concat(pgroonga0.map(&column))
    elements.concat(pgroonga.map(&column))
    elements.join(" | ")
  end

end

ActiveRecord::Base.establish_connection(adapter: "postgresql", database: "redmine_performance_log")

entries = PerformanceLog.order(:query, :hostname, :id).all.group_by(&:query).map do |query, records|
  Entry.new(query, records)
end

puts ERB.new(DATA.read, nil, "-").result

__END__

MariaDB

|          | | Redmine |     | v0.4.0 |     | v0.6.2 |     |
|----------|-|---------|-----|--------|-----|--------|-----|
| query    | | 1st     | 2nd | 1st    | 2nd | 1st    | 2nd |
<%- entries.each do |entry| -%>
| <%= entry.query %> | duration | <%= entry.format_mariadb(:duration) %> |
| | view_runtime | <%= entry.format_mariadb(:view_runtime) %> |
| | db_runtime | <%= entry.format_mariadb(:db_runtime) %> |
<%- end -%>

PostgreSQL

|          | | Redmine |     | v0.4.0 |     | v0.6.2 |     |
|----------|-|---------|-----|--------|-----|--------|-----|
| query    | | 1st     | 2nd | 1st    | 2nd | 1st    | 2nd |
<%- entries.each do |entry| -%>
| <%= entry.query %> | duration | <%= entry.format_postgresql(:duration) %> |
| | view_runtime | <%= entry.format_postgresql(:view_runtime) %> |
| | db_runtime | <%= entry.format_postgresql(:db_runtime) %> |
<%- end -%>


