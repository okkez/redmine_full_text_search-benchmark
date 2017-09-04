#!/usr/bin/env ruby

require "mechanize"
require "nokogiri"

require "cgi/escape"
require "optparse"
require "pathname"

def main(argv)
  host = nil
  path = nil
  username = nil
  password = nil
  parser = OptionParser.new
  parser.on("--host=HOST", String, "Hostname or IP Address") do |value|
    host = value
  end
  parser.on("--queries=PATH", String, "Specify PATH to file includes queries per line") do |value|
    path = Pathname(value)
  end
  parser.on("--username=USERNAME", String, "Redmine username") do |value|
    username = value
  end
  parser.on("--password=PASSWORD", String, "Redmine password") do |value|
    password = value
  end

  begin
    parser.parse!
  rescue OptionParser::ParseError => ex
    puts ex.message
    puts parser.help
    exit(false)
  end

  unless path
    puts "--queries is required"
    puts parser.help
    exit(false)
  end

  agent = Mechanize.new
  agent.user_agent_alias = "Linux Firefox"
  agent.get(login_url(host)) do |page|
    # username, password
    form = page.forms.first
    form.username = username
    form.password = password
    form.submit

    path.readlines.each do |line|
      next if /\A#/.match?(line)
      next if line.strip.empty?
      query = line.chomp
      _search_result = agent.get(search_url(host, query))
      sleep(0.5)
      _search_result = agent.get(search_url(host, query))
    end
  end
end

def login_url(host)
  "http://#{host}/login"
end

def search_url(host, query)
  escaped = CGI.escape(query)
  "http://#{host}/search?q=#{escaped}"
end

main(ARGV)
