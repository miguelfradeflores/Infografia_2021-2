
-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
display.setStatusBar(display.HiddenStatusBar)
display.setDefault( "anchorX", 0.5)
display.setDefault( "anchorY", 0.5)
math.randomseed( os.time() ) 
local gameData = require( "gamedata" )
gameData.invaderNum = 1 
gameData.maxLevels = 3 
gameData.rowsOfInvaders = 6 
local composer = require ("composer")
composer.gotoScene( "start" )