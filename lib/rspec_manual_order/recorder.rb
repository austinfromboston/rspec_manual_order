require 'logger'
require 'fileutils'
class RspecManualOrder
  class Recorder
    DEFAULT_PATH = "log/rspec_manual_order.txt"
    def initialize(file_path = DEFAULT_PATH)
      FileUtils.rm_f(file_path)
      @log = Logger.new(file_path)
      @log.formatter = proc { |_severity, _datetime, ___progname, msg| "#{msg}\n" }
    end

    def puts(message)
      @log.info(message)
    end
  end
end
