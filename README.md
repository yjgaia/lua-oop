# lua-oop
객체지향 프로그래밍을 돕는 Lua 라이브러리입니다.

## class
클래스를 선언합니다. 이렇게 선언된 클래스는 상속이 가능하고, private 및 public, protected 변수를 지정할 수 있습니다. 또한 파라미터를 객체가 생성되기 이전에 변경할 수도 있으며 static 함수를 지정할 수도 있습니다. [예제보기](class-example.lua)
```lua
require 'oop'

-- Some class
local SomeClass = class({
	init = function(inner, self, params, func)
		local name = params.name
		local age = params.age

		func();

		local hello = function()
			print(name..' is '..age..' years old.')
		end

		-- public
		self.hello = hello
	end
})

-- some object
local someObject = SomeClass.new({
	name = 'YJ Sim',
	age = 28
}, function()
	print('object initialized.')
end)

-- YJ Sim is 28 years old.
someObject.hello()
```

아래 코드는 클래스 선언 시 적용할 수 있는 설정들을 설명합니다.
```lua
-- Some class
local SomeClass = CLASS({

	-- 기본 파라미터를 지정합니다.
	-- 파라미터가 넘어오지 않더라도, 기본 파라미터를 이용해 객체를 생성할 수 있습니다.
	params = function()
		return {...}
	end,

	-- 파라미터를 수정하거나, 부모 클래스를 상속합니다.
	preset = function(params, funcs)
		...
		return ParentClass
	end,

	-- 객체를 초기화합니다.
	init = function(inner, self, params, funcs)
	    local a -- 여기서만 사용할 수 있습니다.
		...
		inner.b -- 상속된 자식 객체에서도 사용할 수 있습니다.
		self.c -- 외부에서 사용할 수 있습니다.
	end,

	-- 초기화 이후에 실행됩니다.
	afterInit = function(inner, self, params, funcs)
		...
	end
})
```

또한 static 함수를 지정할 수 있습니다.

```lua
-- some class
local SomeClass = class(function(cls)

    -- get string. this is static function.
    local getString = function()
        return 'Static!'
    end

	-- static
	cls.getString = getString

	return {
		init = function(inner, self, params, funcs)
			...
		end
	}
end);

-- run static function.
SomeClass.getString()
```

## object
클래스를 만들지 않고 객체를 바로 선언합니다. 설정 및 내용은 `class`와 동일하지만, 만들어진 결과는 클래스가 아니라 객체입니다. [예제보기](object.js)

```lua
-- sample object
local sampleObject = object({

	init = function(inner, self)

	    -- hello.
	    local hello = function()
			print('Hi there?')
		end

		-- public
		self.hello = hello
	end
});

-- Hi there?
sampleObject.hello()
```

## 라이센스
[MIT](LICENSE)

## 작성자
[Young Jae Sim](https://github.com/Hanul)
