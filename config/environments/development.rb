Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { host: 'audit.loc' }
      ActionMailer::Base.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => "gmail.com",
      :user_name => "noreply.fixnix@gmail.com",
      :password => "I'malreadylive!",
      :authentication => "plain",
      :enable_starttls_auto => true
}
  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  config.after_initialize do

  Rails.configuration.stripe[:secret_key] = "sk_live_tdPigj2uo34NxLF1sdfo2ffK"
  Rails.configuration.stripe[:publishable_key] = "pk_live_VE8qW42PVGRyuzHlhlHue66s"

  ActiveMerchant::Billing::Base.mode = :test
    ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    :login => "bharan_1337931714_biz_api1.gmail.com",
    :password => "1337931754",
    :signature => "ABtl2XslRuLEdZCnzDl1vba40WOvAcrxKrWV2yaKqzLx0zRitPeQN3pl "
     )
end

end
