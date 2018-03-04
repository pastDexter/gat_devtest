class Rack::Attack

  # Throttle all requests by IP (60rpm)
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip
  end

  # Throttle POST authorization requests by IP address
  throttle('aurhorization/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/v1/private/authorization' && req.post?
      req.ip
    end
  end
  
end