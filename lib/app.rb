require './lib/not_found'
require './lib/send_email'

module MySite
	class Application
		def initialize(root = 'public')
      @app = Rack::Builder.new do
        use Rack::Static, urls: Dir.glob("#{root}/*").map { |fn| fn.gsub("#{root}", '')}, root: root, index: 'index.html'
      	use SendEmail
        run NotFound.new
      end
    end

		def call(env)
			@app.call(env)
		end
	end
end