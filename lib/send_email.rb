require 'xmandrill'

module MySite
	class SendEmail
		def initialize(app)
			@app = app
		end

		def call(env)
			request = Rack::Request.new(env)
			if request.post? && request.path == "/contact"
				begin
					send_email(request.params)
					[200, {}, ["Email has been sent successfully."]]
				rescue Exception => e
					[200, {}, [e.message]]
				end				
			else
				@app.call(env)
			end
		end

		private
		
		def send_email(params)
			@xm = ::Xmandrill::API.new(ENV['MANDRILL_APIKEY'])
			@xm.messages(:send, {
				message: {
					text: params["message"], 
					subject: params["subject"] || "New Enquiry", 
					from_email: params["email"], 
					from_name: "#{params['first_name']} #{params['last_name']}", 
					to: [
						{
							email: params["email"], # Change this to your email address
							name: "#{params['first_name']} #{params['last_name']}" # Change this to your name
						}
					]
				}
			})
		end
	end
end