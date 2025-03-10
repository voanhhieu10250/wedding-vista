# Using the same db store for caching to manage sessions (same cache appliance as standard rails caching)
# If you're using redis for caching, you can use that redis store for sessions as well.
# IMPORTANT: "expire_after" should match "timeout_in" config in: config/initializers/devise.rb
unless Rails.application.config.cache_store == :null_store
  Rails.application.config.session_store ActionDispatch::Session::CacheStore,
                                         key: "_wedding_vista_session",
                                         expire_after: 2.weeks
end
