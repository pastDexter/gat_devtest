require 'rspec/expectations'

module RequestHelpers
  def json_body
    JSON.parse(response.body)
  end

  def request_with_token(method, url, token, opts = {})
    opts[:headers] = { HTTP_AUTHORIZATION: token.key }.merge(opts[:headers].to_h)
    send(method, url, opts)
  end

  %i[get post].each do |method|
    define_method("#{method}_with_token") do |url, token, opts = {}|
      request_with_token(method, url, token, opts)
    end
  end
end

RSpec::Matchers.define :have_errors do |expected_message|
  match do |actual|
    actual['errors'] == expected_message
  end
end
