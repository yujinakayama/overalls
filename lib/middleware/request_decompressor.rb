module Middleware
  class RequestDecompressor
    def initialize(app)
      @app = app
    end

    def call(env)
      decompress(env) if gzip_content_encoding?(env)
      @app.call(env)
    end

    private

    def gzip_content_encoding?(env)
      env['HTTP_CONTENT_ENCODING'.freeze] == 'gzip'.freeze
    end

    def decompress(env)
      input = env['rack.input']
      decompressed_data = Zlib::GzipReader.new(input).read
      env['rack.input'] = StringIO.new(decompressed_data)
      env['CONTENT_LENGTH'] = decompressed_data.bytesize
      env.delete('HTTP_CONTENT_ENCODING')
    end
  end
end
