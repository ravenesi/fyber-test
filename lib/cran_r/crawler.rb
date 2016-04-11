require 'dcf'

module CranR
  class Crawler
    include ActAsCrowable

    def initialize(worker:)
      @source_url = ENV.fetch('CRAN_PACKAGE_LIST') do
        raise ArgumentError.new('Missing CRAN_PACKAGE_LIST, set in .env file')
      end
      @worker = worker
      setup_options
    end

    def index
      fetch_data
      parse_data
      @success
    end

    private
    attr_reader :packages

    def setup_options
      @packages = []
      @data_array = []
      setup_default_options
    end

    def parse_data
      return unless @success
      @data.rewind

      package_delimiters.each do |group|
        @worker.perform_later(
          group.first.upto(group.last).each_with_object([]) do |line_number, buffer|
             buffer << @data_array[line_number]
          end.join.strip
        )
      end
    end

    def package_delimiters
      @data.each.with_index.with_object([]) do |(line, index), separators|
        @data_array << line
        separators << index if line.strip.blank?
      end.unshift(0).in_groups_of(2, false)
    end
  end
end