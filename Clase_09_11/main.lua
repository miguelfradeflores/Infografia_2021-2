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


