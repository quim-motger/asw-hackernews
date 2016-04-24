Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '348916042618-fkrhqnqpc429qa56jt14mtb111hgi0oc.apps.googleusercontent.com', 'rJS1uuc6gvVN--4FPVqz4u9N',
           {
               :name => "google"
           }
end