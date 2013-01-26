module(..., package.seeall)

function new( _capa, _datos)
	local o = {}

	o.datos = _datos
	o.image = nil

	o.transicion = nil

	function o:show()
        o.image = display.newImage("graficos/ingame/" .. o.datos.nombre .. ".png")

		o.image.capa     = _capa
		o.nombre   = o.datos.nombre
		o.tipo     = o.datos.tipo
		o.image.nombre   = o.datos.nombre
		o.image.tipo     = o.datos.tipo
		o.image.x        = o.datos.x
		o.image.y        = o.datos.y
		o.image.xScale   = o.datos.tamx
		o.image.yScale   = o.datos.tamy
		o.image.rotation = o.datos.ang
		o.image.alpha    = o.datos.alfa  

		if string.sub(o.datos.nombre, -2) == "_v" then
			o.image:setReferencePoint(display.CenterReferencePoint)
			o.image.xScale = o.image.xScale * -1
		end

    	_capa:insert ( o.image )
	end


	function o.destroy()
		print ("Destruyendo DEC")

		--transition.cancel(o.transicion)
		o.image:removeSelf()
		o.image = nil
		o = nil
	end


	return o
end