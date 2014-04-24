class RspecManualOrder
  class Recorder
    DEFAULT_PATH = "log/rspec_manual_order.txt"
    def initialize(file_path = DEFAULT_PATH)
      @logfile = File.new(Rails.root.join(file_path), 'w')
    end

    def puts(message)
      @logfile.puts(message)
    end
  end
end
