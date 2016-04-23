Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '348916042618-nr5mhrth6oag4ltdet8ogtnq7mih5gnh.apps.googleusercontent.com', 'RGoLmcBHSIopBzuNIezbU2Xp',
           {
               :name => "google"
           }
end