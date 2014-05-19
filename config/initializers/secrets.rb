"#{Rails.application.class.parent.name}::Application".constantize.config.secret_key_base = Token.secure_token
