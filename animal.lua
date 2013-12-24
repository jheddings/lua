-- animal.lua

require 'class'
require 'table'

--------------------------------------------------------------------------------
Animal = class()

function Animal:__init(name)
  self.name = name
end

function Animal:__tostring()
  return (self.name .. ': "' .. self:speak() .. '"')
end

--table.dump(Animal, 'Animal')

--------------------------------------------------------------------------------
Dog = class(Animal)

function Dog:speak()
  return 'bark'
end

--table.dump(Dog, 'Dog')

--------------------------------------------------------------------------------
Cat = class(Animal)

function Cat:__init(name, breed)
  Animal.__init(self, name)
  self.breed = breed
end

function Cat:speak()
  return 'meow'
end

--table.dump(Cat, 'Cat')

--------------------------------------------------------------------------------
Lion = class(Cat)

function Lion:speak()
  return 'roar'
end

--table.dump(Lion, 'Lion')

--------------------------------------------------------------------------------

felix = Cat('Felix', 'Tabby')
print(felix)

leo = Lion('Leo', 'African')
print(leo)

fido = Dog('Fido')
print(fido)
