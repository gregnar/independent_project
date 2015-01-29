module Helpers

  def log_in
    visit root_path
    OmniAuth.config.mock_auth[:goodreads] = OmniAuth::AuthHash.new(auth_hash)
    click_link_or_button "login"
  end

  def auth_hash
    {
      "provider" => "goodreads",
      "uid" => "444",
      "info" => { "name" => "Trevor" },
      "extra" => {"access_token" => access_token}
    }
  end

  def access_token
    OpenStruct.new({"token" => "123", "secret" => "456"})
  end

end
