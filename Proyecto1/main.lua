-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-- Variables y funciones de apoyo
local cw = display.contentWidth
local ch = display.contentHeight

local cw4 = cw / 4
local ch8 = ch / 8

local op = {}
local res = '0'
local resultado

function splitBy(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch('(.-)'..delimiter) do
        table.insert(result, match)
    end
    return result
end

function replaceBy(s, replacer)
    result = s:gsub('%.', replacer)
    return result
end

function joinToNumber(from, to)
	result = {}
    for i = from, to, 1 do
        table.insert(result, op[i])
    end
    return tonumber(table.concat(result, ''))
end

function joinToString(from, to)
	result = {}
    for i = from, to, 1 do
        table.insert(result, op[i])
    end
    return table.concat(result, '')
end

-- Fondo
local fondo = display.newRect(cw / 2, ch / 2, cw, ch)
fondo:setFillColor(1, 1, 1)

-- Lineas separatorias
for i = 2, 7, 1 do
	local lineaHorizontal = display.newLine(0, ch8 * i, cw, ch8 * i)
	lineaHorizontal.strokeWidth = 3
	lineaHorizontal:setStrokeColor(0)
end

for i = 1, 3, 1 do
	local lineaVertical = display.newLine(cw4 * i, ch8 * 2, cw4 * i, ch8 * 8)
	lineaVertical.strokeWidth = 3
	lineaVertical:setStrokeColor(0)
end

-- Numeros y operaciones
local cero = display.newText('0', cw4 * 2.5, ch8 * 7.5, 'arial', 25)
cero:setFillColor(0, 0, 0)

local uno = display.newText('1', cw4 * 1.5, ch8 * 6.5, 'arial', 25)
uno:setFillColor(0, 0, 0)

local dos = display.newText('2', cw4 * 2.5, ch8 * 6.5, 'arial', 25)
dos:setFillColor(0, 0, 0)

local tres = display.newText('3', cw4 * 3.5, ch8 * 6.5, 'arial', 25)
tres:setFillColor(0, 0, 0)

local cuatro = display.newText('4', cw4 * 1.5, ch8 * 5.5, 'arial', 25)
cuatro:setFillColor(0, 0, 0)

local cinco = display.newText('5', cw4 * 2.5, ch8 * 5.5, 'arial', 25)
cinco:setFillColor(0, 0, 0)

local seis = display.newText('6', cw4 * 3.5, ch8 * 5.5, 'arial', 25)
seis:setFillColor(0, 0, 0)

local siete = display.newText('7', cw4 * 1.5, ch8 * 4.5, 'arial', 25)
siete:setFillColor(0, 0, 0)

local ocho = display.newText('8', cw4 * 2.5, ch8 * 4.5, 'arial', 25)
ocho:setFillColor(0, 0, 0)

local nueve = display.newText('9', cw4 * 3.5, ch8 * 4.5, 'arial', 25)
nueve:setFillColor(0, 0, 0)

local punto = display.newText('.', cw4 * 3.5, ch8 * 7.5, 'arial', 25)
punto:setFillColor(0, 0, 0)

local igual = display.newText('=', cw4 * 1.5, ch8 * 7.5, 'arial', 25)
igual:setFillColor(0, 0, 0)

local del = display.newText('DEL', cw4 * 3.5, ch8 * 3.5, 'arial', 25)
del:setFillColor(0, 0, 0)

local mas = display.newText('+', cw4 * 2.5, ch8 * 2.5, 'arial', 25)
mas:setFillColor(0, 0, 0)

local menos = display.newText('-', cw4 * 2.5, ch8 * 3.5, 'arial', 25)
menos:setFillColor(0, 0, 0)

local mul = display.newText('*', cw4 * 1.5, ch8 * 2.5, 'arial', 25)
mul:setFillColor(0, 0, 0)

local div = display.newText('/', cw4 * 1.5, ch8 * 3.5, 'arial', 25)
div:setFillColor(0, 0, 0)

local signo = display.newText('INV', cw4 * 3.5, ch8 * 2.5, 'arial', 25)
signo:setFillColor(0, 0, 0)

local mod = display.newText('%', cw4 * 0.5, ch8 * 2.5, 'arial', 25)
mod:setFillColor(0, 0, 0)

local logd = display.newText('log10', cw4 * 0.5, ch8 * 3.5, 'arial', 25)
logd:setFillColor(0, 0, 0)

local raiz = display.newText('^1/2', cw4 * 0.5, ch8 * 4.5, 'arial', 25)
raiz:setFillColor(0, 0, 0)

local pow2 = display.newText('^2', cw4 * 0.5, ch8 * 5.5, 'arial', 25)
pow2:setFillColor(0, 0, 0)

local pown = display.newText('^n', cw4 * 0.5, ch8 * 6.5, 'arial', 25)
pown:setFillColor(0, 0, 0)

local red = display.newText('RED', cw4 * 0.5, ch8 * 7.5, 'arial', 25)
red:setFillColor(0, 0, 0)

-- Funciones
function mostrarResultado()
	display.remove(resultado)
	if not(next(op) == nil) then
		res = table.concat(op, ' ')
	end
	resultado = display.newText(res, cw, ch * 1 / 12, 'arial', 40)
	resultado.anchorX = 1
	resultado.anchorY = 0
	resultado:setFillColor(0, 0, 0)
end

function concat(s)
	table.insert(op, s)
	print(table.concat(op, ''))
	mostrarResultado()
end

function redondear()
	comp = '5'
	aux1 = joinToString(2, #op)
	aux2 = replaceBy(aux1, ',')
	aux3 = splitBy(aux2, ',')
	aux4 = aux3[2]
	aux5 = aux3[1]
	res = tonumber(aux5)
	for i = 1, #aux4 - 1, 1 do
		comp = comp .. '0'
	end
	comp1 = tonumber(comp)
	comp2 = tonumber(aux4)
	if (comp2 >= comp1) then
		res = res + 1
	end
	op = {}
	mostrarResultado()
end

function invertir()
	res = joinToNumber(2, #op) * (-1)
	op = {}
	mostrarResultado()
end

function logaritmo()
	res = math.log10(joinToNumber(2, #op))
	op = {}
	mostrarResultado()
end

function resolver()
	operacion = ''
	val1 = 0
	val2 = 1
	for i = 2, #op do
		if (op[i] == '+' or op[i] == '-' or op[i] == '*' or op[i] == '/' or op[i] == '%' or op[i] == '^') then
			operacion = op[i]
			val1 = joinToNumber(1, i - 1)
			val2 = joinToNumber(i + 1, #op)
			break
		end
	end
	if (operacion == '+') then
		res = val1 + val2
	elseif (operacion == '-') then
		res = val1 - val2
	elseif (operacion == '*') then
		res = val1 * val2
	elseif (operacion == '/') then
		res = val1 / val2
	elseif (operacion == '%') then
		res = val1 % val2
	else
		res = math.pow(val1, val2)
	end
	op = {}
	mostrarResultado()
end

-- Funciones touch
function cero:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(0)
	end
	return true
end

function uno:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(1)
	end
	return true
end

function dos:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(2)
	end
	return true
end

function tres:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(3)
	end
	return true
end

function cuatro:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(4)
	end
	return true
end

function cinco:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(5)
	end
	return true
end

function seis:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(6)
	end
	return true
end

function siete:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(7)
	end
	return true
end

function ocho:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(8)
	end
	return true
end

function nueve:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat(9)
	end
	return true
end

function punto:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('.')
	end
	return true
end

function del:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		op = {}
		res = '0'
		mostrarResultado()
	end
	return true
end

function mas:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('+')
	end
	return true
end

function menos:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('-')
	end
	return true
end

function mul:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('*')
	end
	return true
end

function div:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('/')
	end
	return true
end

function signo:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('INV')
	end
	return true
end

function mod:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('%')
	end
	return true
end

function raiz:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('^')
		concat(0.5)
	end
	return true
end

function pow2:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('^')
		concat(2)
	end
	return true
end

function pown:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('^')
	end
	return true
end

function red:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('RED')
	end
	return true
end

function logd:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		concat('log10')
	end
	return true
end

function igual:touch(e)
	if (e.phase == 'ended' or e.phase =='cancelled') then
		if (op[1] == 'INV') then
			invertir()
		elseif (op[1] == 'RED') then
			redondear()
		elseif (op[1] == 'log10') then
			logaritmo()
		else
			resolver()
		end
	end
	return true
end

-- Listeners
cero:addEventListener('touch', cero)
uno:addEventListener('touch', uno)
dos:addEventListener('touch', dos)
tres:addEventListener('touch', tres)
cuatro:addEventListener('touch', cuatro)
cinco:addEventListener('touch', cinco)
seis:addEventListener('touch', seis)
siete:addEventListener('touch', siete)
ocho:addEventListener('touch', ocho)
nueve:addEventListener('touch', nueve)
punto:addEventListener('touch', punto)
del:addEventListener('touch', del)

mas:addEventListener('touch', mas)
menos:addEventListener('touch', menos)
mul:addEventListener('touch', mul)
div:addEventListener('touch', div)
signo:addEventListener('touch', signo)
mod:addEventListener('touch', mod)
raiz:addEventListener('touch', raiz)
pow2:addEventListener('touch', pow2)
pown:addEventListener('touch', pown)
red:addEventListener('touch', red)
logd:addEventListener('touch', logd)
igual:addEventListener('touch', igual)

mostrarResultado()