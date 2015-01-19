# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Routes::Application.config.secret_key_base = 'dbd8a78af7ab8c7676acf8af7f9ee5c5908369ab791260aa47e85f9d3fd161c41d69d11fca164bb8f4af47a16434c0dc6316a0be2480a73840997760c730f14a'
