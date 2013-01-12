require 'colorize'
require 'capistrano'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "incompatible version of capistrano"
end

module Capistrano
  class Configuration
    module Actions
      module Inspect
        def stream_with_colorized(command, options={})
          trap("INT") { puts 'Interupted'; exit 0; }

          previous_last_line = Hash.new("")
          invoke_command(command, options) do |ch, stream, out|
            if stream == :out
              hostname = ch[:host]
              # split to lines and take care of the previous last line which was not outputted
              lines = out.split(/\r?\n/m, -1)
              lines[0] = previous_last_line[hostname] + lines[0]
              previous_last_line[hostname] = lines.pop

              # puts with colorized hostname
              lines.each {|line| puts colorized(hostname) + line }
            end
            warn "[err :: #{ch[:server]}] #{out}" if stream == :err
          end
        end
        alias_method :stream_without_colorized, :stream
        alias_method :stream, :stream_with_colorized

        private

        def colorized(hostname)
          if @colorized.nil?
            @colorized = {}
            servers = find_servers_for_task(current_task).map(&:to_s)
            len = servers.map(&:length).max
            servers.each_with_index {|host, i| @colorized[host] = (host.ljust(len) + ' | ').colorize(colors[i]) }
          end
          @colorized[hostname]
        end

        def colors
          %w( cyan yellow green magenta red blue light_cyan light_yellow
          light_green light_magenta light_red, light_blue ).map(&:to_sym)
        end
      end
    end
  end
end
