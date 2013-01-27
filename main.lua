--os.execute('clear') -- limpio la consola a cada nuevo arranque
display.setStatusBar ( display.HiddenStatusBar ) -- Oculto la barra superior

	-----------------------------------------------
	------------ ** INICIO PROGRAMA ** ------------
	-----------------------------------------------
local o = {}

iniciarJuego = function ( id )
	function closure()		
		if o.mainMenu ~= nil then
			o.mainMenu = o.mainMenu.deleteAll()
		end

		o.ingame = require("ingame").new()
		o.ingame.load( id )

		transition.to(o.myRectangle, {time = 500, alpha = 0})
	end

	o.crearRectangulo()
	transition.to(o.myRectangle, {time = 500, alpha = 1, onComplete = closure})
end

iniciarMenu = function( first )
	function closure()
		if o.ingame ~= nil then
			o.ingame = o.ingame.deleteAll()
		end

		o.mainMenu = require("mainMenu").new()

		transition.to(o.myRectangle, {time = 500, alpha = 0})
	end

	if first ~= nil then
		closure()
	else
		o.crearRectangulo()
		transition.to(o.myRectangle, {time = 500, alpha = 1, onComplete = closure})
	end
end

function o.crearRectangulo()
	if o.myRectangle == nil then
		o.myRectangle = display.newRect(-1000, -100, 5000, 5000)
		o.myRectangle.strokeWidth = 3
		o.myRectangle:setFillColor(0, 0, 0)
		o.myRectangle:setStrokeColor(0, 0, 0)

		o.myRectangle.alpha = 0
	end
end

--iniciarJuego()
iniciarMenu( true )