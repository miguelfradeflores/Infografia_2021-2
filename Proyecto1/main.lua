-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local widget=require("widget")


local cw=display.contentWidth
local ch=display.contentHeight

local paddingX=cw/16
local paddingY=ch/30

local segment1, segment2,segment3
local garra
local abierto=false
local textAS1, textAS2, textAS3

-- Your code here


function actualizeAngleTexts()
	textAS1.text="Angulo del segmento 1: "..math.round(math.abs(segment1.rotation)).."°"
	textAS2.text="Angulo del segmento 2: "..math.round(math.abs(segment2.rotation)).."°"
	textAS3.text="Angulo del segmento 3: "..math.round(math.abs(segment3.rotation)).."°"
end

function garraAction(event)
	abierto=not(abierto)
	if abierto then 
		garra:setSequence("abrir")
	else
		garra:setSequence("cerrar")
	end
	garra:play()
end
function moveGarra()
	garra.x=segment3.x+segment3.contentWidth-25
	garra.y=segment3.y-segment3.contentHeight*checkSegment(segment3.rotation)
	garra.rotation=segment3.rotation
	actualizeAngleTexts()
	return true
end

function checkSegment(rotation )

	local rotationUnit1=math.abs(rotation)
	if rotation==0 then 
		return 0
	end
	local rotationUnit2=rotation/rotationUnit1
	print(rotationUnit2)
	

	if math.abs(rotation)<5 then
		return 0.20 * rotationUnit2 * (-1)
	elseif math.abs(rotation)<20 then
		return 0.45 * rotationUnit2 * (-1)
	elseif math.abs(rotation)<30 then 
		return 0.5 * rotationUnit2 *(-1)
	elseif math.abs(rotation)<45 then
		return 0.75 * rotationUnit2 *(-1)
	else 
		return 0.80 * rotationUnit2 * (-1)
	end
end

function moveSegments2()
	transition.to(segment2,{x=segment1.contentWidth-10,y=segment1.y-segment1.contentHeight*checkSegment(segment1.rotation),time=100,onComplete=moveSegments3})
end

function moveSegments3()
	transition.to(segment3,{x=segment2.x+segment2.contentWidth-25,y=segment2.y-segment2.contentHeight*checkSegment(segment2.rotation),time=100, onComplete=moveGarra})
end

function moveItLeft(event)
	if segment1.rotation>-90 then
		transition.to(segment1,{rotation=segment1.rotation-1,time=100,onComplete=moveSegments2})
	end
end

function moveItLeft2(event)
	if segment2.rotation>-45  then
		transition.to(segment2,{rotation=segment2.rotation-1,time=100, onComplete=moveSegments3})
	end
end


function moveItLeft3(event)
	if segment3.rotation>-45   then
		transition.to(segment3,{rotation=segment3.rotation-1,time=100,onComplete=moveGarra})
	end
	return true
end

function moveItRight(event)
	if segment1.rotation<0 then
		transition.to(segment1,{rotation=segment1.rotation+1,time=100,onComplete=moveSegments2})
	end
end

function moveItRight2(event)
	if segment2.rotation<45 and segment1.rotation<0  then
		transition.to(segment2,{rotation=segment2.rotation+1,time=100,onComplete=moveSegments3})
	end
end

function moveItRight3(event)
	if segment3.rotation<45 and   segment2.rotation<0 then
		transition.to(segment3,{rotation=segment3.rotation+1,time=100,onComplete=moveGarra})
	end
	return true
end

segment1=display.newImage("robotSegment.png",paddingX*1,paddingY*18)
segment1.xScale=0.15;segment1.yScale=0.1
segment1.anchorX=0
segment1.rotation=0


segment2=display.newImage("robotSegment.png",segment1.contentWidth,paddingY*18)
segment2.xScale=0.125;segment2.yScale=0.1
segment2.anchorX=0
segment2.rotation=0


segment3=display.newImage("robotSegment.png",segment1.contentWidth+segment2.contentWidth,paddingY*18)
segment3.xScale=0.1;segment3.yScale=0.1
segment3.anchorX=0
segment3.rotation=0


local configuracionDeSheet={
	width = 800,
    height = 800,
    numFrames = 8
}

local garraIm= graphics.newImageSheet( "GarraAnimacionT.png", configuracionDeSheet )


local secuenciaGarra = {
    -- first sequence (consecutive frames)
    {
        name = "abrir",
        start = 1,
        count = 4,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"

    },
    -- next sequence (non-consecutive frames)
    {
        name = "cerrar",
        start = 5,
        count = 4,
        time = 500,
        loopCount = 1,
        loopDirection = "forward"
    },
}

garra=display.newSprite(garraIm,secuenciaGarra)
garra.xScale=0.1; garra.yScale=0.1
garra.x=segment1.contentWidth+segment2.contentWidth+segment3.contentWidth
garra.y=segment3.y
garra.anchorX=0

segment2:toFront()
segment1:toFront()
garra:toFront()


local button1L= widget.newButton({
		x=0,
		y=ch,
        width = 104,
        height = 20,
        defaultFile = "button1SL.png",
        onPress= moveItLeft
    })

button1L.anchorX=0
button1L.anchorY=1


local button1R= widget.newButton({
		x=cw,
		y=ch,
        width = 104,
        height = 20,
        defaultFile = "button1SR.png",
        onPress= moveItRight
    })

button1R.anchorX=1
button1R.anchorY=1

local button2L= widget.newButton({
		x=0,
		y=button1L.y-paddingY*2,
        width = 104,
        height = 20,
        defaultFile = "button2SL.png",
        onPress= moveItLeft2
    })

button2L.anchorX=0
button2L.anchorY=1


local button2R= widget.newButton({
		x=cw,
		y=button1R.y-paddingY*2,
        width = 104,
        height = 20,
        defaultFile = "button2SR.png",
        onPress= moveItRight2
    })

button2R.anchorX=1
button2R.anchorY=1

local button3L= widget.newButton({
		x=0,
		y=button2L.y-paddingY*2,
        width = 104,
        height = 20,
        defaultFile = "button3SL.png",
        onPress= moveItLeft3
    })

button3L.anchorX=0
button3L.anchorY=1


local button3R= widget.newButton({
		x=cw,
		y=button2R.y-paddingY*2,
        width = 104,
        height = 20,
        defaultFile = "button3SR.png",
        onPress= moveItRight3
    })

button3R.anchorX=1
button3R.anchorY=1

local buttonGarra= widget.newButton({
		x=cw/2,
		y=ch,
        width = 104,
        height = 20,
        defaultFile = "buttonGarra.png",
        onPress= garraAction
    })

buttonGarra.anchorY=1

textAS1=display.newText("Angulo del segmento 1: "..segment1.rotation.."°",cw/2,paddingY*20)
textAS2=display.newText("Angulo del segmento 2: "..segment2.rotation.."°",cw/2,paddingY*21)
textAS3=display.newText("Angulo del segmento 3: "..segment3.rotation.."°",cw/2,paddingY*22)

