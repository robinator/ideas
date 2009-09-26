# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_duncan_session',
  :secret      => 'bb26ab450e7b67b17ed3be52aa806725d1ca5afd40636eec842227d46c1920c4f2d7fd136ab586d7064c8a62aadef846ee8cebe8c29bd63140b7c138f8509b98'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
