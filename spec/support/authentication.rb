def authenticate_with_spec_token!
  session[:token] = spec_token
end
