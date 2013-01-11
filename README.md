# Capistrano Colorized Stream

testing ruby: 1.9.3; Capistrano: > 2.0

## About capistrano-colorized-stream 

capistrano-colorized-stream adds a feature to append colorized hostnames to the head of each line for capistrano stream method. 

Capistrano is a utility and framework for executing commands in parallel on multiple remote machines, via SSH.

## USAGE

For example, to stream log files located on multiple hosts, use the extended `stream` method at config/deploy.rb as

```ruby
require 'capistrano/colorized_stream'

task :syslog do
  stream "tail -f /var/log/syslog"
end
```

## Acknowledgement

Special thanks to [@niku4i](http://orihubon.com/blog/2012/02/09/streaming-log-with-capistrano/).
