--os.execute('clear') -- limpio la consola a cada nuevo arranque
display.setStatusBar ( display.HiddenStatusBar ) -- Oculto la barra superior

	-----------------------------------------------
	------------ ** INICIO PROGRAMA ** ------------
	-----------------------------------------------
local o = {}

iniciarJuego = function ( id )
	if o.mainMenu ~= nil then
		o.mainMenu = o.mainMenu.deleteAll()
	end

	o.ingame = require("ingame").new()
	o.ingame.load( id )
end

iniciarMenu = function()
	if o.ingame ~= nil then
		o.ingame = o.ingame.deleteAll()
	end

	o.mainMenu = require("mainMenu").new()
end

--iniciarJuego()
iniciarMenu()