require 'colorize'
require 'capistrano'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "incompatible version of capistrano"
end

module Capistrano
  class Configuration
    module Actions
      module Inspect
        def stream_with_color(command, options={})
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
              lines.each {|line| puts colorize_host(hostname) + ": " + line }
            end
            warn "[err :: #{ch[:server]}] #{out}" if stream == :err
          end
        end
        alias_method :stream_without_color, :stream
        alias_method :stream, :stream_with_color

        private

        def colorize_host(host)
          @colors ||= {}
          @colors[host] ||= String.colors[str2acsii(host) % String.colors.size]
          host.colorize(@colors[host])
        end

        def str2acsii(str="")
          str.each_byte.inject(0) {|sum, byte| sum + byte }
        end
      end
    end
  end
end
