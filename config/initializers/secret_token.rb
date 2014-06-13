# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.

require 'securerandom'

class SecretToken

  def self.secrets_yml
    @secrets_yml ||= YAML.load_file 'config/secrets.yml'
  end  
  
  def self.token_dir
    app_name = Rails.application.class.parent.name
    self.secrets_yml['token_dir'] + app_name.downcase
  end

  def self.token_name
    self.secrets_yml['token_name']
  end

  def self.token_filename
    "#{self.token_dir}/#{self.token_name}"
  end

  def self.read_token
    token_file = SecretToken.token_filename
    if File.exist? token_file
      return File.read(token_file).chomp
    end
    return nil
  end

  def self.secure_token(secret = nil)
    token_file = SecretToken.token_filename
    return secret if secret and File.write token_file, secret
    if File.exist? token_file
      File.read(token_file).chomp
    else
      token = SecureRandom.hex self.secrets_yml['token_length']/2
      File.write token_file, token
      token
    end
  end
end
