#!/usr/bin/env ruby

require "json"

ip = JSON.parse(`terraform output -json ip`)

File.open("ansible/hosts", "w+") do |file|
  file.puts("[servers]")
  ip["value"].each do |name, (public, private)|
    next unless /redmine/.match?(name)
    file.puts("#{name} ansible_host=#{public} public_ip=#{public} private_ip=#{private}")
  end

  fluentd_host_public, fluentd_host_private = ip.dig["value"]["fluentd"]
  file.puts
  file.puts("[log]")
  file.puts("#{name} ansible_host=#{fluentd_host_public} public_ip=#{fluentd_host_public} private_ip=#{fluentd_host_private}")

  file.puts
  file.puts("[all:vars]")
  file.puts("fluentd_host=fluentd")
end
