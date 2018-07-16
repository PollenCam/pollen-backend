class ApiDocumentationFormatter
  RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished, :example_passed

  attr_accessor :output

  REQUEST_WHITELIST = %w{
    REQUEST_METHOD
    CONTENT_TYPE
    QUERY_STRING
    RAW_POST_DATA
  }

  REQUEST_BLACKLIST = %w{
    PATH_INFO
    HTTP_HOST
  }

  def initialize(output)
    @output = File.new('./API_DOCUMENTATION.md', 'w+')
    @example_group = nil
    @group_level = 1
  end

  def example_group_started(notification)
    output.puts "#{'#' * @group_level} #{notification.group.description.strip}"

    @group_level += 1
  end

  def example_group_finished(_notification)
    @group_level -= 1 if @group_level > 0
  end

  def example_passed(passed)
    request, response = passed.example.metadata.values_at(:request, :response)

    output.puts "#{'#' * @group_level} #{passed.example.description.strip}"
    output.puts <<~REQUEST
      Request to: `#{request.path}`

      Request parameters:
      ```
      #{
        request.headers['RAW_POST_DATA'].yield_self {|data| data.present? ? JSON.pretty_generate(JSON.parse(data)) : 'NONE'}
      }
      ```

      Request headers:

      ```
      #{
        request.headers
               .select {|k,v| k.start_with?('HTTP_') || REQUEST_WHITELIST.include?(k) }
               .reject {|k,v| v.blank? || REQUEST_BLACKLIST.include?(k)}
               .map {|k, v| "#{k}: #{v}"}
               .sort
               .reverse
               .join("\n")
      }
      ```
    REQUEST

    output.puts "_______"

    output.puts <<~RESPONSE
      Response status: `#{response.status} #{response.status_message}`

      Response body:

      ```
      #{response.body.present? ? JSON.pretty_generate(JSON.parse(response.body)) : 'NONE'}
      ```
    RESPONSE
  end
end
