#!/usr/bin/env ruby

require "json"

ip = JSON.parse(`terraform output -json ip`)

File.open("ansible/hosts", "w+") do |file|
  file.puts("[servers]")
  ip["value"].each do |name, (public, private)|
    next unless /redmine/.match?(name)
    file.puts("#{name} ansible_host=#{public} public_ip=#{public} private_ip=#{private}")
  end
end
