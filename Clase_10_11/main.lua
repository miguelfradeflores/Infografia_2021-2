-----------------------------------------------------------------------------------------
--
-- main.lua
-- # //
-----------------------------------------------------------------------------------------

-- Your code here

print("Hello world! from Lua.")

print( 4546 )
print( true )
print( type(false) )
print( nil )

variable1 = 123.45

print( variable1 )
print( type( variable1 ) )

variable1 = "Cadena de texto \n"
variable2 = [[Cadena de texto nueva 
asdfasdf ]]
variable_char = 's'
print(variable1)
print( type( variable1 ) )
print( type(variable2), variable2 )
print( type( variable_char ), variable_char )
print(type( print ))

lista_de_datos = {123,123,23}
print( lista_de_datos, type( lista_de_datos), lista_de_datos[1] )
print(lista_de_datos[0])

print( lista_de_datos[6] )

matriz = {
	{	--1
		{1,2,3},   --1
		{4,5,6},   --2
		{7,8,9}    --3

	},
	{	--2
		{1,2,3},   --1
		{9,5,6},   --2
		{7,8,9},    --3
		{"manzana", "pez", false, 45.12, nil, {1,2,3}, nil} -- 4
	}
}
print(matriz[1][2][3])
print( matriz[2][4][1],  matriz[2][4][6][2], matriz[2][4][5])

print( #lista_de_datos )
print( #matriz, #matriz[2][4], #matriz[2][4][6])

persona = {
	edad = 22,
	sexo = "masculino",
	nombre = "Juan",
	altura = 1.70,
	usa_lentes = true
}

print( persona["edad"], persona.nombre, persona["4"], pairs( persona ) )

if persona.usa_lentes  then 
	print( persona.nombre .. " usa lentes y tiene una edad de " .. persona.edad .. " " .. tostring(persona.usa_lentes)  )
end

print(  tonumber("01011",2) * 6)

if persona.nombre == "Juan" and not(persona.altura > 1.80) and persona.usa_lentes then
	print("Si es mas alta que 1.60 y usa lente") 
else
	print("No es mas alto mi tiene lentes")

end



if not (persona.nombre ~= "Juan") then
	print("Me llamo Juan")
else
	print('Se nego la expresion')
end

if persona.peso == nil then
	print("la persona pesa mas de 50")
end

for i=10,1,-1 do
	print( i )

end


for i,v in ipairs(lista_de_datos) do
	print(i,v)
end

for i=1, #lista_de_datos do
	print(lista_de_datos[i])
end

for k,v in pairs(persona) do
	print(k,v)
end


print( #persona.nombre )

-- repeat
	
-- 	print( persona.nombre )
-- 	persona.nombre = persona.nombre .. "Juan"
-- until #persona.nombre >= 12



function sumarNumeros( a,b )
	print( a+b )
	return a+b
end

for i=1, #persona.nombre do

	print(persona.nombre[i])
	print( tostring(persona.nombre.char(i )) )
end

sumarNumeros(45,62)
print( sumarNumeros(12,4) + 6 )



function isCapicua(n)
	esCapituca = true
	print( "numero original", n )
	print( "size del digito", #(tostring( n )))
	size = #(tostring( n ))
	if size == 1 then
		return true
	else
		
		aux = n   -- 151
		aux2 =  0
		indice = 1
		print(aux2)
		while aux ~= 0 do
			unDigito = aux % 10
			aux2 = (aux2 * 10) + unDigito 
			aux = math.floor(aux /10)
		end

		print( aux2, n )

		return n == aux2
	end
end

-- print( "Es capicua ",2, isCapicua(2)  )
print( "Es capicua ",151, isCapicua(151)  )
print( "Es capicua ",24, isCapicua(20)  )
print( "Es capicua ",13471, isCapicua(13471)  )
