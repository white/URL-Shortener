# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_urlshort_session',
  :secret      => '81f75bb13ed013288df5802a1108cfa7490da9e6a104c8c6974ab7759a2298acca10e0a5b43dd4dcebd92212afd3357c21628a5ab69efb5cad3c435b69fa26f2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
