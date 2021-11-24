
local pairs = pairs
local ipairs = ipairs

local M = {}

function M.physicsData(scale)
	local physics = { data =
	{ 
		
		["ship"] = {
                    

                    {
                    pe_fixture_id = "ship", density = 0, friction = 0, bounce = 0, isSensor=true, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -47, -22  ,  -36.5, -24.5  ,  -30, -16  ,  -20, 17  ,  -47, 10  }
                    }
                     ,
                    {
                    pe_fixture_id = "ship", density = 0, friction = 0, bounce = 0, isSensor=true, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   16.5, 15.5  ,  -20, 17  ,  26.5, -14.5  ,  45, -10  ,  44, 10  }
                    }
                     ,
                    {
                    pe_fixture_id = "ship", density = 0, friction = 0, bounce = 0, isSensor=true, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   40.5, -25.5  ,  45, -10  ,  26.5, -14.5  ,  32.5, -25.5  }
                    }
                     ,
                    {
                    pe_fixture_id = "ship", density = 0, friction = 0, bounce = 0, isSensor=true, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -8, 57  ,  -20, 33  ,  -20, 17  ,  16.5, 15.5  ,  10, 47  ,  -0.5, 59.5  }
                    }
                     ,
                    {
                    pe_fixture_id = "ship", density = 0, friction = 0, bounce = 0, isSensor=true, 
                    filter = { categoryBits = 1, maskBits = 65535, groupIndex = 0 },
                    shape = {   -20, 17  ,  -30, -16  ,  -8.5, -60.5  ,  4.5, -60.5  ,  26.5, -14.5  }
                    }
                    
                    
                    
		}
		
	} }
    
        local s = scale or 1.0
        for bi,body in pairs(physics.data) do
                for fi,fixture in ipairs(body) do
                    if(fixture.shape) then
                        for ci,coordinate in ipairs(fixture.shape) do
                            fixture.shape[ci] = s * coordinate
                        end
                    else
                        fixture.radius = s * fixture.radius
                    end
                end
        end
	
	function physics:get(name)
		return unpack(self.data[name])
	end

	function physics:getFixtureId(name, index)
                return self.data[name][index].pe_fixture_id
	end
	
	return physics;
end

return M

