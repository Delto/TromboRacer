module(..., package.seeall)

function new( _capa, _datos )
	local o = {}

	o.capa = _capa
	o.datos = _datos
	o.image = nil
	o.animationLoop = nil
	o.bucleActual = 1
	o.globales = _globales
	o.escena = _escena

	o.transicion = nil

	function o:show()
		o.image = require ( "_SPRITE" ).new ( o.datos.nombre, o.datos.nombre )


        o.image:setReferencePoint ( display.CenterReferencePoint )
		

		if o.datos.sheet == nil then
			o.nombre = o.datos.nombre
			o.tipo = o.datos.tipo
			o.sheet  = o.datos.nombre
		else
			o.nombre = o.datos.nombre
			o.tipo = o.datos.tipo
			o.sheet  = o.datos.sheet
		end

		

		o.image.nombreReal = o.datos.nombreReal
		o.image.capa     = o.capa
		o.image.nombre   = o.datos.nombre
		o.image.tipo     = o.datos.tipo
		o.image.x        = o.datos.x
		o.image.y        = o.datos.y
		o.image.xScale   = o.datos.tamx
		o.image.yScale   = o.datos.tamy
		o.image.rotation = o.datos.ang
		o.image.alpha    = o.datos.alfa         


		o.capa:insert ( o.image )

	end

	function o:sequence(_nombreSecuencia, _nombreSprite, _funcionSalida, _frameComienzo )
		if o.image.nombreReal ~= nil and _nombreSecuencia == _nombreSprite then
			o.image:sequence ( o.image.nombreReal, _nombreSprite, _funcionSalida, _frameComienzo )
		else
			o.image:sequence ( _nombreSecuencia, _nombreSprite, _funcionSalida, _frameComienzo )
		end
	end

	function o:setFillColor( r, g, b)
		o.image:setFillColor(r,g,b)
	end

	function o:getSequence()
		return o.image:getSequence()
	end

	function o:getSheet ()
		return o.image:getSheet()
	end
	
	function o.destroy()
		print ("Destruyendo ANI")
		if o.datos.nombreReal ~= nil then
			o.datos.nombre = o.datos.nombreReal
		end
		
		o:pararAnimacion()
		o.image.destroy()
		o.image = nil
		o = nil
	end

	return o
end