Rails.application.config
  .middleware.insert_before ActionDispatch::ParamsParser, Middleware::RequestDecompressor
