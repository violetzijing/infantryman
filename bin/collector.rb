#!/usr/bin/env ruby
#
# This file is for collecting infos on the slaves.
#

module Collector
  def self.get_cpu_usage
    return "/proc/stat doesn't exist." unless File.exist? "/proc/stat"

    cpu_usage = {}
    output = `cat /proc/stat | grep cpu`.split("\n")
    output.each do |item|
      item = item.split(" ").map.with_index {|x, i| i == 0 ? x : x.to_f }
      idle = item[4] + item[5]
      total = item[1..-1].reduce(:+)
      used_percentage = (total - idle) / total
      cpu_usage[item[0]] = used_percentage
    end

    cpu_usage
  end

  def self.get_cpu_top
    top10 = `ps aux | awk '{print $11, $3}' | sort -k2nr | head -n 10`.split("\n")
    top10 = top10.map {|x| x.split(" ").first }
  end

  def self.get_meminfo
    return "/proc/meminfo doesn't existed" unless File.exists? "/proc/meminfo"

    meminfo = `cat /proc/meminfo`.split("\n")
    memset = {}
    meminfo.each do |info|
      info = info.split(" ")
      info[1] += info[-1]
      memset[info.first[0...-1]] = info[1]
    end

    memset
  end

  def self.get_mem_usage
    return "/proc/meminfo doesn't existed" unless File.exists? "/proc/meminfo"
    meminfo = get_meminfo
    mem_usage = meminfo["MemFree"][0...-2].to_f / meminfo["MemTotal"][0...-2].to_f

    mem_usage
  end

  def self.get_mem_top
    top10 = `ps aux | awk '{print $11, $4}' | sort -k2nr | head -n 10`.split("\n")
    top10 = top10.map {|x| x.split(" ").first }
  end

  def self.get_disk
    disk_info = `df --total`.split("\n")
    disk_info.shift
    disk_info
  end

  def self.get_uptime
    uptime = `uptime`.split(" ")[2][0...-1]
  end

  def self.get_kernel_version
    kernel_version = `uname -r`
  end

  def self.get_distro
    return "/etc/issue doesn't exist." unless File.exists? "/etc/issue"

    distro = `cat /etc/issue`.delete("\n")
  end

  def self.load_avg
    return "/proc/loadavg doesn't exist." unless File.exists? "/proc/loadavg"

    load_avg = `cat /proc/loadavg`
  end
end
