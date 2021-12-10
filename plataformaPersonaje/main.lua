local physics = require "physics"
local personaje, piso;

local cw= display.actualContentWidth
local ch = display.actualContentHeight

local fondo = display.newImageRect("fondo.jpg",cw,ch)
fondo.x=cw/2;fondo.y=ch/2


local grupo = display.newGroup()


function sensorCollide(self, event) 
    print("Collide")
    if ( event.other.objType == "piso" ) then 
        if ( event.phase == "began" ) then
            self.sensorOverlaps = self.sensorOverlaps + 1
        elseif ( event.phase == "ended" ) then
            self.sensorOverlaps = self.sensorOverlaps - 1
        end
    end
end

function moverDerecha(e)

    if e.phase == "began" then
        personaje:setSequence( "walk" )
        personaje:play( )
        personaje.xScale=0.1;
        timer.performWithDelay(100, function()
                personaje:applyLinearImpulse ( 5, 0,personaje.x, personaje.y)
            end, -1, "movimiento")
    elseif e.phase == "moved" then 
    
    elseif e.phase == "ended" then
        personaje:setSequence( "idle" )
        personaje:play()
        timer.cancel("movimiento")
    end
    return true
end

function moverArriba(e)
    if e.phase == "began" then
        personaje:setSequence( "jump" )
        personaje:play( )
        personaje.jumped=personaje.jumped+1;
        transition.to(personaje, {y=personaje.y-80, time=300} )
        transition.to(personaje, {y=personaje.y, delay=300, time=300} )
    elseif e.phase == "ended" then
        personaje:pause()
        personaje:setFrame( 3 )
        timer.performWithDelay( 1100, personaje:pause(), -1,"movimiento" )
        personaje:setSequence( "idle" )
        personaje:play()
        timer.cancel("movimiento")
    end
    return true
end

function moverIzquierda(e)
    if e.phase == "began" then
        personaje:setSequence( "walk" )
        personaje:play( )
        personaje.xScale=-0.1;
        timer.performWithDelay(100, function()
                personaje.x = personaje.x - 5
            end, -1, "movimiento")
    elseif e.phase == "moved" then 
    
    elseif e.phase == "ended" then
        personaje:setSequence( "idle" )
        personaje:play()
        timer.cancel("movimiento")
    end
    return true
end

physics.setDrawMode( "hybrid" )
physics.start()


local piso = display.newImageRect( "piso.png",cw+100, 100)
piso.x = cw/2; piso.y = ch*0.9
piso:setFillColor( 1, 1, 0)
piso.name = "piso"

physics.addBody(piso, "static", {bounce=0, friction=0.3})


local plataforma = display.newImageRect( "piso.png",cw/2-130, 40)
plataforma.x = cw/2+30; plataforma.y = ch*0.6
plataforma:setFillColor( 1, 1, 0)
plataforma.name = "piso"

local piedra= display.newImageRect( "piso.png",cw/2, 150)
piedra.x = cw; piedra.y = ch*0.8
piedra.anchorY=1
piedra:setFillColor( 1, 1, 0)
piedra.name = "piso"



physics.addBody(plataforma, "static", {bounce=0, friction=0.3})
physics.addBody(piedra, "static", {bounce=0, friction=0.3})

local idle= {
    width = 810,
    height = 723,
    numFrames = 3
}
local walk= {
    width = 810,
    height = 810,
    numFrames = 4
}
local jump= {
    width = 810,
    height = 810,
    numFrames = 3
}

local personaje_spritesheet = graphics.newImageSheet( "spriteSheetIdle.png",  idle )
local personaje_spritesheet2 = graphics.newImageSheet( "spriteSheet.png",  walk )
local personaje_spritesheet3 = graphics.newImageSheet( "spriteSheetJump.png",  jump )

local sequence = {
    {
        name="idle",
        frames = {1,2,3,2},
        loopCount = 0,
        time = 500, 
        sheet = personaje_spritesheet
    } ,
    {
        name="walk",
        frames = {1,2,3,2,4,2},
        loopCount = 0,
        time = 500, 
        sheet = personaje_spritesheet2
    } ,
    {
        name="jump",
        frames = {1,2,3},
        loopCount = 1,
        time = 500, 
        sheet = personaje_spritesheet3
    } 

}


personaje = display.newSprite(  grupo,personaje_spritesheet, sequence )
personaje.x = cw/4; personaje.y = ch/4
personaje.xScale = 0.1; personaje.yScale = 0.1
personaje.name="personaje"
personaje.isFixedRotation=true;
personaje.jumped=0;
personaje.collision=sensorCollide
personaje:addEventListener( "collision")
personaje:setSequence( "idle" )
personaje:play()

local derecha = display.newImageRect( "flecha.png", 100,100)
derecha.x = cw-60; derecha.y = ch -60
derecha.name="derecha"
derecha:addEventListener( "touch", moverDerecha)

local izquierda = display.newImageRect( "flecha.png", 100,100)
izquierda.x = 60; izquierda.y = ch -60
izquierda.xScale=-1;
izquierda.name="izquierda"
izquierda:addEventListener( "touch", moverIzquierda)

local arriba = display.newImageRect( "flecha.png", 100,100)
arriba.x = cw/2; arriba.y = ch -60
arriba.rotation=-90;
arriba.name="arriba"
arriba:addEventListener( "touch", moverArriba)

physics.addBody( personaje, "dynamic",{radius=38, density=5, friction=1, bounce=0.0})
personaje.saltoOverlap=0


