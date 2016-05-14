require 'oop'

local Animal = class(function(cls)

	local staticText = 'Creature'

	local getStaticText = function()
		return staticText
	end

	-- static
	cls.getStaticText = getStaticText

	return {
		init = function(inner, self, params)
			--REQUIRED: params
			--REQUIRED: params.name
			--REQUIRED: params.color

			local name = params.name
			local color = params.color

			local move = function(meters)
				print(name..' moved '..meters..'m.')
			end

			local eat = function()
				print('delicious.')
			end

			-- protected
			inner.eat = eat

			-- public
			self.move = move
		end,

		afterInit = function(inner)
			inner.eat()
		end
	}
end)

local Snake = class({
	preset = function()
		return Animal
	end,

	init = function(inner, self, params)
		--REQUIRED: params
		--REQUIRED: params.name
		--REQUIRED: params.color

		local name = params.name
		local color = params.color

		local move
		override(self.move, function(origin)
			move = function(meters)
				print('Slithering...')
				origin(5)
			end
		end)

		-- run protected method.
		inner.eat()

		-- public
		self.move = move
	end
})

local Horse = class({
	preset = function(params)

		-- preset parameters.
		params.color = 'brown'

		return Animal
	end,

	init = function(inner, self, params)
		--REQUIRED: params
		--REQUIRED: params.name
		--REQUIRED: params.color

		local name = params.name
		local color = params.color

		local move
		override(self.move, function(origin)
			move = function(meters)
				print('Galloping...')
				origin(45)
			end
		end)

		-- private method
		local run = function()
			print('CLOP! CLOP!')
		end

		-- public
		self.move = move
	end
})

local sam = Snake.new({
	name = 'Sammy the Python',
	color = 'red'
})

local tom = Horse.new({
	name = 'Tommy the Palomino'
})

sam.move()
tom.move()

-- protected method, private method -> nil, nil
print(sam.eat)
print(tom.run)

-- static text
print(Animal.getStaticText())
print(Horse.mom.getStaticText())

-- check is instance of
if sam.type == Snake then
	print('ok!')
end
if sam.type ~= Animal then
	print('ok!')
end
if sam.checkIsInstanceOf(Snake) == true then
	print('ok!')
end
if sam.checkIsInstanceOf(Animal) == true then
	print('ok!')
end

-- singleton class
local Singleton = class(function(cls)
	local singleton

	local getInstance = function()
		if singleton == nil then
			singleton = cls.new()
		end
		return singleton
	end

	-- static
	cls.getInstance = getInstance

	return {
		init = function(inner, self)
			local num = 0

			local getNum = function()
				num = num + 1
				return num
			end

			-- public
			self.getNum = getNum
		end
	}
end)

print(Singleton.getInstance().getNum())
print(Singleton.getInstance().getNum())
print(Singleton.getInstance().getNum())
