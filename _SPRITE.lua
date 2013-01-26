module (..., package.seeall )

sprite = require("sprite")

--[[
		Control de SPRITES

require("_SPRITE").new ( "Png", "Lua" )

*******
METODOS
*******

sequence ( "nombreSecuencia",   pone la secuencia indicada
           "nombreSprite", 
           "funcionSalida" )
getSequence ()					devuelve el nombre de la secuencia actual
play  ()						pone la animacion en marcha
stop  ()						para la animacion totalmente
pause ()						pausa la animacion
setVelocity ( velocidad )		modifica la velocidad 1-real 2-doble 0.5-mitad
getRealFrame ()					devuelve la imagen del spriteSheet que esta actualmente
destroy ()						elimina el sprite

*********
ATRIBUTOS
*********

frame							contiene el frame actual de la secuencia
playing							esta animandose true/false
vel								velocidad actual
loop							hay loop true/false
totalFrames						frames de la secuencia actual

--------------------------------------------------------------------
Esta funcion hay que meterla en el lua que genera el texture packer
--------------------------------------------------------------------
function getExposureSheet ()
	local s =
	{
		{ nombre = "nombreSecuencia", loop = true/false, duracion = milisegundos, frames = { secuencia de frames separados por comas } },
	}
	return s
end

]]--

function new ( _nombre, _nombreObjeto )

	local o = display.newGroup ()

	o.ruta = _ruta
	o.nombre = _nombreObjeto
	
	-- file_grafico: Url completa en donde se encuentra el archivo png/sheet
	-- file_sheet  : Url completa en donde se encuentra el lua con la informacion del sheet y las cartas de rodaje
	function o.cambiarSheet ( file_grafico, file_sheet )
		-- Antes de cambiar de sheet toca borrar el actual


		if o.spr_sheet ~= nil  then
			o.sprite:removeSelf ()
			o.spr_sheet:dispose ()
			o.spr_set = nil
			o.carta   = nil
		end
	
	

		local sprData = {}

		-- Primero recupero ( del lua ) en una tabla con los tamaños, coordenadas/posicion y otras propiedades de los sprites
		local sheet = require ( file_sheet ).getSpriteSheetData ()

		-- Ahora uso dicha informacion para, junto con el grafico, generar la coleccion de sprites de la animacion			
		o.spr_sheet = sprite.newSpriteSheetFromData ( file_grafico, sheet )

		-- La coleccion recien recuperada como tal no se puede usar y tengo que crear un "set" desde donde poder recoger
		-- las imagenes cuando quiera crear los sprites/animaciones a usar
		o.spr_set = sprite.newSpriteSet ( o.spr_sheet, 1, #sheet.frames )

		-- Ahora ya si que puedo crear el sprite, haciendo uso de todos los frames porque despues se usara el mismo sprite
		-- pero cambiando de frame/posicion que no creando un sprite para cada animacion
		o.sprite  = sprite.newSprite ( o.spr_set )

		-- Se carga la carta de rodaje con la tabla del lua
		o.carta = require ( file_sheet ).getExposureSheet()

		o:insert(o.sprite)

		o.sprite.isVisible = true



		o.frame           = 1	  -- frame actual
		o.totalFrames     = 0	  -- total de fotogramas de la secuencia acutal
		o.duracion        = 0	  -- duracion de la animacion en milisegundos
		o.vel             = 1	  -- velocidad de la secuencia actual 1 normal 2 el doble de rapido 0.5 mitad de velocidad
		o.loop            = true  -- animacion en loop? true/false
		o.secuencia       = 0	  -- numero de secuencia de la carta de rodaje
		o.nombreSecuencia = ""    -- nombre de la secuencia
		o.playing         = false

		o.transicion = transition.to ( o, { time = 1, frame = o.frame, onComplete = function() end } )
	end

	function o:crearRutas ( _nombreSprite )		
		return "graficos/ingame/" .. _nombreSprite .. ".png", _nombreSprite
	end


	o.cambiarSheet ( o:crearRutas ( _nombre ) )


	

	-- _nombreSecuencia: Nombre de la secuencia/animacion a poner en marcha
	-- _nombreSprite   : Nombre del sprite, que se usara para cargar el lua y el png correspondientes
	-- _funcionSalida  : [opcional] Puntero a la funcion que se llamara nada mas terminar la secuencia/carta a cargar
	function o:sequence ( _nombreSecuencia, _nombreSprite, _funcionSalida, _frameComienzo )
		transition.cancel ( self.transicion )

		-- Si el png/sheet en el que esta la animacion es el mismo al cargado actualmente, se cambia de secuencia y pista
		if o.sheet == _nombreSprite then

			Runtime:addEventListener ( "enterFrame", o )

			-- busco la secuencia 
			for n=1,#self.carta do
				-- si la encuentro la cargo en las variables
				if self.carta[n].nombre == _nombreSecuencia then
					self.nombreSecuencia   = _nombreSecuencia
					self.totalFrames       = #self.carta[n].frames
					self.framePenalizacion = 0
					if _frameComienzo == nil then
						self.frame = 1
					else
						if self.totalFrames < _frameComienzo then
							self.frame = 1
						else
							self.frame = _frameComienzo
							self.framePenalizacion = self.frame
						end
					end

					self.loop      = self.carta[n].loop
					self.secuencia = self.carta[n]
					self.duracion  = self.carta[n].duracion
					self.funcion   = _funcionSalida

					self:play()
					break
				end
			end

		-- Pero si no es asi, toca cargar un nuevo sheet y despues volver a llamar a esta funcion con los mismos parametros porque
		-- como ya estara cargado el sheet que interesa, se hara el cambio de secuencia
		else

			o.sheet = _nombreSprite

			Runtime:removeEventListener ( "enterFrame", o )
			o.cambiarSheet ( o:crearRutas ( _nombreSprite ) )
			o:sequence ( _nombreSecuencia, _nombreSprite, _funcionSalida, _frameComienzo )
		end
	end

	function o:getSequence ()
		return self.nombreSecuencia
	end

	function o:getSheet ()
		return self.sheet
	end

	function o:setFillColor( r, g, b)
		o.sprite:setFillColor(r,g,b)
	end

	function o:setVelocity ( v )
		transition.cancel(self.transicion)
		self.vel = v
		self.transicion = transition.to ( self, { time=self.duracion/self.vel, frame=self.totalFrames, onComplete=function() self:replay() end } )
	end

	function o:play ()
		function duracion ()
			local dur = ( self.totalFrames *  (self.totalFrames - self.frame) ) / (self.duracion / self.vel)
			if dur <= 0 then
				dur = 1
			end
			return dur
		end

		if self.totalFrames == 1 then
			self.currentFrame = self.totalFrames
			self.playing    = true
			if self.funcion ~= nil then self.funcion () end
		else
			self.transicion = transition.to ( self, { time = duracion (), frame = self.totalFrames + 1 , onComplete = function() self:replay () end } )
			self.playing    = true
		end		
	end
	
	function o:stop ()
		local ultimoFrame = self.sprite.currentFrame

		transition.cancel ( self.transicion )
		self.frame   = 1
		self.playing = false

		return ultimoFrame
	end
	
	function o:pause ()
		transition.cancel ( self.transicion )
		self.playing = false
	end

	function o:replay ()
		self.framePenalizacion = 0

		if self.loop == true then
			self.frame = 1
			self.transicion = transition.to ( self, { time = self.duracion / self.vel, frame = self.totalFrames + 1, onComplete = function() self:replay () end } )
		else
			self.playing = false
			Runtime:removeEventListener ( "enterFrame", o )
		end

		-- Si a la animacion/secuencia se le ha adjudicado una funcion de salida, se llamara a esta segun se termine la carta
		if self.funcion ~= nil then self.funcion () end
	end

	-- devuelve el fotograma real
	function o:getRealFrame ()
		return self.sprite.currentFrame
	end

	function o:enterFrame ()
		--print ("x")
		if self.playing and self.sprite ~= nil then
			self.sprite.currentFrame = self.secuencia.frames [ math.floor ( self.frame ) ]
		end
	end

	function o.destroy ()
		print ("Destruyendo SPRITE")

		Runtime:removeEventListener ( "enterFrame", o )
		
		if o.transicion ~= nil then
			transition.cancel ( o.transicion )
		end

		-- Si el sprite tiene un lua con la logica asociado (mas que nada para personajes), se llamara al destructor de este
		if o.lanzarDestructor ~= nil then
			o.lanzarDestructor ()
		end

		sprite      = nil
		o.sprite:removeSelf ()
		o.sprite    = nil
		o.spr_sheet:dispose()
		o.spr_sheet = nil
		o.spr_set   = nil
		o.carta     = nil

		for i = #o.sheetsPrecargados, 1, -1 do
			o.sheetsPrecargados[i] = nil
		end
		o.sheetsPrecargados = nil

		for i = o.sheetsPrecargadosCapa.numChildren, 1 , -1 do
			o.sheetsPrecargadosCapa[i]:removeSelf()
			o.sheetsPrecargadosCapa[i] = nil
		end
		o.sheetsPrecargadosCapa = nil

		display.remove( o )
		o = nil
	end
	
	return o
end