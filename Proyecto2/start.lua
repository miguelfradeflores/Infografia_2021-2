local composer = require( 'composer' )

local scene = composer.newScene()

local cw = display.contentWidth
local ch = display.contentHeight

function goGame( e )
	composer.gotoScene( 'game' )
end

function scene:create( event )
	local sceneGroup = self.view
	local play = display.newText( 'PLAY' , cw / 2 , ch / 2 , 'arial' , 40 )
	play:addEventListener( 'touch' , goGame )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then
		
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	if ( phase == "will" ) then
		
	elseif ( phase == "did" ) then
		
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene