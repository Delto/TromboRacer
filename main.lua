--os.execute('clear') -- limpio la consola a cada nuevo arranque
display.setStatusBar ( display.HiddenStatusBar ) -- Oculto la barra superior

	-----------------------------------------------
	------------ ** INICIO PROGRAMA ** ------------
	-----------------------------------------------


function iniciarJuego()
	ingame = require("ingame").new()
	ingame.load(1)
end

function iniciarMenu()
	require("mainMenu").new()
end

--iniciarJuego()
iniciarMenu()