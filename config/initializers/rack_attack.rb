class Rack::Attack
  # Limiter les hits sur le lien token
  throttle("token-respond", limit: 60, period: 1.minute) do |req|
    req.ip if req.path.start_with?("/r/")
  end
end
