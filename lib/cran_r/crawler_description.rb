require 'rubygems/package'
require 'dcf'

module CranR
  class CrawlerDescription
    include ActAsCrowable

    def initialize(source_url:)
      @source_url = source_url
      setup_options
    end

    def fetch
      fetch_data
      parse_data
    end

    private
    attr_reader :informations

    def setup_options
      setup_default_options
    end

    def parse_data
      return unless @success
      @data.rewind

      extract
      decorate
      informations
    end

    def decorate
      if @informations
        %w(Author Maintainer).each do |field_name|
          @informations[field_name] = string_to_emails_and_names(
            @informations[field_name]
          )
        end
      else
        @success = false
        false
      end
    end

    def string_to_emails_and_names(data)
      data.split(",").map do |user_string|
        if user_string.include? '<'
          user_string =~ /^([^<]*)<([^>]*)>$/
          { name: $1.to_s.strip, email: $2 }
        else
          { name: user_string, email: '' }
        end
      end
    end

    def extract
      Zlib::GzipReader.wrap(@data) do |gz|
        Gem::Package::TarReader.new(gz) do |tar|
          tar.each do |entry|
            if entry.full_name.include? ('/DESCRIPTION')
              @informations = Dcf.parse(entry.read.force_encoding('iso-8859-1').encode('utf-8')).first
              break
            end
          end
        end
      end
    end
  end
end