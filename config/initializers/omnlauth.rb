Rails.application.config.middleware.use OmniAuth::Builder do 
    if Rails.env.development? || Rails.env.test?
        provider :github, "9ddad3c261314676a7d4", "6b72638e995d8443ed1dfbf0d70a0df367c8c66d"
    else
        provider :github,
            Rails.application.credentials.github[:client_id],
            Rails.application.credentials.github[:client_secret] 
    end 
end