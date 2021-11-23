-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local cw = display.contentWidth
local ch = display.contentHeight

local fondoBase = display.newImageRect ("Fotos/123.jpg", cw, ch )

fondoBase.anchorX= 0; fondoBase.anchorY = 0

local brazo1 = display.newImageRect("Fotos/brazo.png",cw,ch)

function moverBrazo1( event )
    if event.phase == "began" then
    elseif event.phase=="moved"then
    elseif event.phase=="ended"then 
    end 
end

fondoBase:addEventListener( "touch", moverBrazo1 )