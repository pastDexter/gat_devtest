module RequestHelpers
  def json_body
    JSON.parse(response.body)
  end

  def get_with_token(url, token, opts = {})
    opts[:headers] = { HTTP_AUTHORIZATION: token.key }.merge(opts[:headers].to_h)
    get url, opts
  end
end