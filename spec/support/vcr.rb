def spec_token
  ENV['SPEC_TOKEN'] || '1187056.72d343c.7f272c75b4974ff7936679fdf0802dc7'
end

def spec_fake_client
  @spec_fake_client ||= Instagram.client(access_token: spec_token)
end
