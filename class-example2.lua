require 'oop'

SampleClass = class({

	init = function(inner, self)

		local messsage

		local setMessage = function(_message)
			message = _message
		end

		local showMessage = function()
			print(message)
		end

		-- public
		self.setMessage = setMessage
		self.showMessage = showMessage
	end
})

SampleClass.test = 1

local sampleObject = SampleClass.new()
sampleObject.setMessage('test')
sampleObject.showMessage()
