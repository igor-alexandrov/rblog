# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rblog_session',
  :secret      => 'fa28e2fdbfbdc3aa819bfec189596d1bc95e4737db2252b5899333a30335175cf41bef92a570e7237c18d84d49171fffc18fdf3933a3ca2eca3ef342aa043cf8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
