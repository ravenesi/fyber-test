module ActAsCrowable
  attr_reader :success, :error

  def fetch_data
    @curl = Curl::Easy.new(source_url)
    @curl.on_body do |response_body|
      @data.write response_body
      response_body.length
    end
    @curl.on_missing do |curl, code|
      @success = false
      @error = "Recieved HTTP: #{code} from server"
    end
    @curl.on_failure do |curl, code|
      @success = false
      @error = "Recieved HTTP: #{code} from server"
    end
    @curl.perform
  end

  def source_url
    raise NotImplementedError
  end

  private
  attr_reader :source_url

  def setup_default_options
    @success = true
    @data = StringIO.new
  end
end