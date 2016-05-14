require 'oop'

local obj = object({
	init = function(inner, self)
		print('this is singleton object.')
	end
})

local childObj = object({
	preset = function()
		return obj
	end,
	init = function(inner, self)
		print('this is child object.')
	end
})
