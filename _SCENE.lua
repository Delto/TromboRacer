module(..., package.seeall)

function new ( )

	local o = display.newGroup()

	o.todosLosGraficos = {}
	o.animaciones = {}

	-- Capas de la escena
	o.bg = display.newGroup()
	o:insert(o.bg)
	o.lo = display.newGroup()
	o:insert(o.lo)
	o.ol = display.newGroup()
	o:insert(o.ol)
	o.cine = display.newGroup()
	o:insert(o.cine)

	local function cargarEscenario ()

		-- Se carga el escenario
		local scn = require ( "ingame_info" )

		--print ("Memoria usada")
		-- BG
		for n=#scn.bg,1,-1 do
			local tipo = scn.bg[n].tipo

			local t = nil

			if tipo == "DEC" then
				t = require("_DEC").new   ( o.bg, scn.bg[n] )
				t:show()
				
			elseif tipo == "ANI" then
				t = require("_ANI").new   ( o.bg, scn.bg[n] )
				t:show()
				table.insert(o.animaciones, t)
				t:sequence(scn.bg[n].nombre, scn.bg[n].nombre)		
			else
				--print ("ERROR, tipo no reconocido en BG")
			end

			if t ~= nil then
				table.insert( o.todosLosGraficos, t)
			end
		end

		-- LO
		for n=#scn.lo,1,-1 do
			--print ( system.getInfo("textureMemoryUsed") / 1024)
			local tipo = scn.lo[n].tipo

			local t  = nil
			if tipo == "DEC" then
				t = require("_DEC").new   ( o.lo, scn.lo[n] )
				t:show()
				
			elseif tipo == "ANI" then
				t = require("_ANI").new   ( o.lo, scn.lo[n] )
				t:show()
				table.insert(o.animaciones, t)
				t:sequence(scn.lo[n].nombre, scn.lo[n].nombre)
			end

			if t ~= nil then
				table.insert( o.todosLosGraficos, t)
			end
		end

		-- OL
		for n=#scn.ol,1,-1 do
			local tipo = scn.ol[n].tipo
				
			local t = nil

			if tipo == "DEC" then
				t = require("_DEC").new   ( o.ol, scn.ol[n] )
				t:show()
				
			elseif tipo == "ANI" then
				t = require("_ANI").new   ( o.ol, scn.ol[n] )
				t:show()
				table.insert(o.animaciones, t)
				t:sequence(scn.ol[n].nombre, scn.ol[n].nombre)
			else
				--print ("ERROR, tipo no reconocido en OL")
			end

			if t ~= nil then
				table.insert( o.todosLosGraficos, t)
			end
		end
	end

	function o.findThing ( nombre, tipo )
		local t = {}
		for n=1,o.bg.numChildren do
			if o.bg[n].nombre == nombre and o.bg[n].tipo == tipo then
				table.insert(t, o.bg[n])
			elseif o.bg[n].nombreReal == nombre and o.bg[n].tipo == tipo then
				table.insert(t, o.bg[n])
			end
		end

		for n=1,o.lo.numChildren do
			if o.lo[n].nombre == nombre and o.lo[n].tipo == tipo then
				table.insert(t, o.lo[n])
			elseif o.lo[n].nombreReal == nombre and o.lo[n].tipo == tipo then
				table.insert(t, o.lo[n])
			end
		end

		for n=1,o.ol.numChildren do
			if o.ol[n].nombre == nombre and o.ol[n].tipo == tipo then
				table.insert(t, o.ol[n])
			elseif o.ol[n].nombreReal == nombre and o.ol[n].tipo == tipo then
				table.insert(t, o.ol[n])
			end
		end

		if #t > 1 then
			return t
		else
			return t [ 1 ]
		end
	end

	cargarEscenario ()

	-- Destructor
	function o.delete()
		detenerTrans_escena ()

		--print("Eliminando TODOS LOS GRAFICOS")
		for n = #o.todosLosGraficos, 1, -1 do
			--print ( system.getInfo("textureMemoryUsed") / 1024)
			--collectgarbage( "collect" )
			--print("Eliminando", o.todosLosGraficos[n].nombre, o.todosLosGraficos[n].tipo)
			if o.todosLosGraficos[n].tipo ~= nil then
				o.todosLosGraficos[n].destroy()
			end
			o.todosLosGraficos[n] = nil
		end

		o.todosLosGraficos = nil

		
		o.animaciones = nil

		-- Se eliminan los decorados
		--print ( system.getInfo("textureMemoryUsed") / 1024)
		--print("Eliminando BG")
		for n = o.bg.numChildren, 1, -1 do
			
			if o.bg[n] ~= nil then				
				--print ( system.getInfo("textureMemoryUsed") / 1024)
				--collectgarbage( "collect" )
				--print("Eliminando", o.bg[n].nombre, o.bg[n].tipo)
				if o.bg[n].destroy ~= nil then
					o.bg[n].destroy()
				else
					o.bg[n]:removeSelf ()
				end
				o.bg[n] = nil
			end
		end
		o.bg:removeSelf ()
		o.bg = nil
		--print ( system.getInfo("textureMemoryUsed") / 1024)
		--collectgarbage( "collect" )

		--print ( system.getInfo("textureMemoryUsed") / 1024)
		--print("Eliminando LO")
		for n = o.lo.numChildren, 1, -1 do
			if o.lo[n] ~= nil then
				--print ( system.getInfo("textureMemoryUsed") / 1024)
				--collectgarbage( "collect" )
				--print("Eliminando", o.lo[n].nombre, o.lo[n].tipo)
				if o.lo[n].destroy ~= nil then
					o.lo[n].destroy()
				else
					o.lo[n]:removeSelf ()
				end
				o.lo[n] = nil
			end
		end
		o.lo:removeSelf ()
		o.lo = nil
		--print ( system.getInfo("textureMemoryUsed") / 1024)
		--collectgarbage( "collect" )

		--print ( system.getInfo("textureMemoryUsed") / 1024)
		--print("Eliminando OL")
		for n = o.ol.numChildren, 1, -1 do
			if o.ol[n] ~= nil then
				--print ( system.getInfo("textureMemoryUsed") / 1024)
				--collectgarbage( "collect" )
				--print("Eliminando", o.ol[n].nombre, o.ol[n].tipo)				
				if o.ol[n].destroy ~= nil then
					o.ol[n].destroy()
				else
					o.ol[n]:removeSelf ()
				end
				o.ol[n] = nil
			end
		end
		o.ol:removeSelf ()
		o.ol = nil

		o.hotSpots = nil				

		o.cine:removeSelf ()
		o.cine = nil

		-- se elimina a si mismo
		o:removeSelf()
		o = nil

		collectgarbage( "collect" )

		print ( "[·] Memoria final al eliminar escena: " .. system.getInfo("textureMemoryUsed") / 1024)
				
	end
	
	return o
end
