-- Schema for Redmin performance log

create table if not exists action_controller_log (
  id serial primary key,
  hostname varchar(255),
  duration real,
  controller varchar(255),
  "action" varchar(255),
  query text,
  params text,
  headers text,
  format varchar(255),
  "method" varchar(255),
  "path" varchar(255),
  status int,
  view_runtime real,
  db_runtime real
);

create table if not exists active_record_log (
  id serial primary key,
  hostname varchar(255),
  duration real,
  "sql" text,
  "name" varchar(255),
  connection_id varchar(255),
  binds text
);

create index action_controller_log_hostname on action_controller_log using btree (hostname);
create index action_controller_log_controller on action_controller_log using btree (controller);
create index action_controller_log_query on action_controller_log using btree (query);
create index active_record_log_hostname on active_record_log using btree (hostname);
create index active_record_log_sql on active_record_log using btree ("sql");

alter table action_controller_log owner to fluentd;
alter table active_record_log owner to fluentd;
