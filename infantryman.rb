#!/usr/bin/env ruby
#
#

require_relative "bin/collector"

info_set = {}

info_set["cpu_usage"] = Collector.get_cpu_usage

info_set["cpu_top"] = Collector.get_cpu_top

info_set["meminfo"] = Collector.get_meminfo

info_set["mem_usage"] = Collector.get_mem_usage

info_set["mem_top"] = Collector.get_mem_top

info_set["disk_info"] = Collector.get_disk

info_set["uptime"] = Collector.get_uptime

info_set["kernel_version"] = Collector.get_kernel_version

info_set["distro"] = Collector.get_distro

info_set["load_avg"] = Collector.load_avg

puts info_set
