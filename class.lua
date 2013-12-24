-- class.lua
-- lifted from http://lua-users.org/wiki/SimpleLuaClasses
-- Compatible with Lua 5.1 (not 5.0).

-- TODO make the class name available through a 'ctype' member
-- TODO possible/helpful to hide private functions in a metatable?

function class(base)
  local struct = { }

  -- "extend" (shallow copy) the base class
  if type(base) == 'table' then
    for member,value in pairs(base) do
      struct[member] = value
    end
    struct.__parent = base
  end

  -- "constructor" for the new class
  struct.__call = function(ctable, ...)
    local self = { }
    setmetatable(self, struct)
    if ctable and ctable.__init then
      ctable.__init(self, ...)
    elseif base and base.__init then
      base.__init(self, ...)
    end
    return self
  end

  -- utility function for testing an object's inheritance
  struct.is_a = function(self, ctype)
    local mt = getmetatable(self)
    while mt do
      if mt == ctype then
        return true
      end
      mt = mt.__parent
    end
    return false
  end

  struct.__index = struct
  setmetatable(struct, struct)

  return struct
end

-- usage example (animal.lua):
--
-- require 'class'
--
-- Animal = class()
-- function Animal:__init(name)
--   self.name = name
-- end
-- function Animal:__tostring()
--   return self.name
-- end
--
-- Dog = class(Animal)
-- function Dog:speak()
--   return 'bark'
-- end
--
-- Cat = class(Animal)
-- function Cat:__init(name, breed)
--   Animal.__init(self, name)
--   self.breed = breed
-- end
-- function Cat:speak()
--   return 'meow'
-- end
--
-- Lion = class(Cat)
-- function Lion:speak()
--   return 'roar'
-- end
--
-- fido = Dog('Fido')
-- felix = Cat('Felix', 'Tabby')
-- leo = Lion('Leo', 'African')
--
-- print(leo:is_a(Animal)) -- true
-- print(leo:is_a(Dog)) -- false
-- print(leo:is_a(Cat)) -- true
--
-- print(fido:speak())
-- print(felix:speak())
-- print(leo:speak())
