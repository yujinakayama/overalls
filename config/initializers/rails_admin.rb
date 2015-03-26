RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  if ENV['ADMIN_USERNAME'] && ENV['ADMIN_PASSWORD']
    credential = { ENV['ADMIN_USERNAME'] => ENV['ADMIN_PASSWORD'] }

    config.authorize_with do
      authenticate_or_request_with_http_digest do |username|
        credential[username]
      end
    end
  elsif !Rails.env.development? && !Rails.env.test?
    fail 'You must set environment variables ADMIN_USERNAME and ADMIN_PASSWORD.'
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'Repository' do
    weight 10
  end

  config.model 'Build' do
    weight 20
  end

  config.model 'TestReport' do
    weight 30

    show do
      include_all_fields

      field :json do
        pretty_value do
          pretty_json = JSON.pretty_generate(JSON.parse(value))
          bindings[:view].content_tag(:pre, pretty_json)
        end
      end
    end
  end
end
