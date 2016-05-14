function CLASS(define)

	return {
		new = function()
			
			local object = {}
			
			define.init(object)
			
			return object
		end
	}
end

SampleClass = CLASS({

	init = function(self)
		
		local messsage
		
		local setMessage = function(_message)
			message = _message
		end
		
		local showMessage = function()
			print(message)
		end
		
		self.setMessage = setMessage
		self.showMessage = showMessage
		
	end
})

SampleClass.test = 1

local sampleObject = SampleClass.new()
sampleObject.setMessage('test')
sampleObject.showMessage()
