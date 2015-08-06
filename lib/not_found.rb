module MySite
	class NotFound
	  def call(env)
	  	request = Rack::Request.new(env)
	    content = File.exist?(request.path) ? File.read(request.path) : 'Not Found'
	    length = content.length.to_s
	    
	    [404, {'Content-Type' => 'text/html', 'Content-Length' => length}, [content]]
	  end
	end
end