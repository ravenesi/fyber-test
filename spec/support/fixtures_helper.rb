module Support
  module FixturesHelper
    # @param [String] file_name
    # @param [Symbol] type
    def load_fixture(file_name, type: nil)
      relative_path = '../../fixtures/'
      relative_path += type.to_s + '/' if type
      relative_path += file_name

      path = File.expand_path(relative_path, __FILE__)
      File.open(path).read
    end
  end
end

RSpec.configure do |config|
  config.include Support::FixturesHelper
end