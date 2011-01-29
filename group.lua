
Group = class('Group')

function Group:initialize()
	self.items = {}
	self.size = 0
	self.activeCount = 0
end
	
function Group:add(item)
	self.size = self.size + 1
	self.items[self.size] = item

	if item.active and item.active == true then 
		self.activeCount = self.activeCount + 1
	end		
end

function Group:call(func, ...)

	for k,item in ipairs(self.items) do

		local callback = item[func]	
		
		if(type(callback)=='function') then 
			callback(item, ...) 
		end
	end

end

function Group:update(dt)
	self.activeCount = 0
	
	for k,item in ipairs(self.items) do
		item:update(dt)
		
		if item.active and item.active == true then 
			self.activeCount = self.activeCount + 1
		end		
	end
end

function Group:draw()
	self:call('draw')
end