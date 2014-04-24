# use this class to run all the specs in a precise order
# use from your rspec config like so
# => SpacManualOrder.new("documentation_file").order(config)
# the file should contain the output of the run you want to mimic, in documentation format
# this is helpful for doing binary search when facing random failures due to test pollution
require 'rspec_manual_order/recorder'

class RspecManualOrder
  attr_reader :ordering
  ORDER_LAST = 9999999

  def self.record(example)
    @recorder ||= Recorder.new
    @recorder.puts(example.example_group.metadata[:example_group][:full_description])
    @recorder.puts(example.full_description)
  end

  def initialize(filename)
    @rawnames = File.read(filename).split("\n")
    @ordering = load_order
  end

  def order(config)
    config.order_examples do |examples|
      examples.sort_by do |example|
        @ordering.index(example.full_description) || ORDER_LAST
      end
    end

    config.order_groups do |groups|
      groups.sort_by do |group|
        description = compute_description(group.parent_groups.reverse.map(&:description))
        @ordering.index(description) || ORDER_LAST
      end
    end
  end

  private

  def load_order
    current_scope = []
    current_indent = 0
    last_line = ''
    @rawnames.map do |nameline|
      next unless new_indent = nameline =~ /\S/

      if new_indent == 0
        current_scope = []
      elsif new_indent > current_indent
        current_scope << last_line.strip
      elsif new_indent < current_indent
        ((current_indent - new_indent) / 2).times do
          current_scope.pop
        end
      end
      last_line = nameline
      current_indent = new_indent
      compute_description(current_scope + [nameline.strip])
    end
  end

  # who know comparing to rspec's internal description was so complicated?
  def compute_description(scopes)
    scopes.reduce do |desc, element|
      desc = if element =~ /^(#|\.|:)/ && desc.split(" ").length == 1
               desc+element
             else
               "#{desc} #{element}"
             end
    end
  end
end
