module(..., package.seeall)

function new()
	local o = {}

	o.juego = nil
	o.vel = 5

	o.transiciones = {}
	o.timers = {}
	o.playerAction = {}
	o.playerAction[1] = {}
	o.playerAction[2] = {1,2,1,2,1,3,1,2,2,1}
	o.playerAction[3] = {}
	o.playerAction[4] = {1,1,1,1,2,3,2,1,2,1}
	o.round = 1
	o.showingEnemys = false
	o.enemysID = {}
	o.beatState = -4
	o.tapNumber = 0
	o.playersInitial = {}
	o.saltosDisponibles = 3


	function o.load( _player )
		o.gameImages = require("_SCENE").new("ingame_info")

		o.bg = o.gameImages.findThing("bg", "DEC")

		o.players = {}
		o.players[1] = o.gameImages.findThing("arabeja", "ANI")
		o.players[2] = o.gameImages.findThing("dammey", "ANI")
		o.players[3] = o.gameImages.findThing("mocteria", "ANI")
		o.players[4] = o.gameImages.findThing("trombo", "ANI")

		for i=1, #o.players do
			--
			o.playersInitial[i] = o.players[i].x
			o.players[i].xScale = 0.3
			o.players[i].yScale = 0.3

			o.players[i]:sequence("walk", o.players[i]:getSheet())
		end

		o.players[2].xScale = 0.6
		o.players[2].yScale = 0.6

		o.buttons = o.gameImages.findThing("button", "DEC")
		
		for i=1, #o.buttons do
			o.buttons[i].width = 280
			o.buttons[i].height = 50

			o.buttons[i].x = 280 * i + (i*20) - 80
			o.buttons[i].y = 740

			function closure()
				o.pulsarBotton(i)
			end

			o.buttons[i]:addEventListener("tap", closure)
		end

		o.enemys = o.gameImages.findThing("enemies", "ANI")

		o.place = o.gameImages.findThing("place", "DEC")

		table.insert(o.transiciones, transition.to(o.place, {time = 60000, x=1024}))

		o.beatID = audio.loadSound("sounds/beat.mp3")

		o.soundBeat1()

		o.mover()
	end

	function o.pulsarBotton( id )
		local r = 1

		if o.round == 0 then
			r = 1 
		else
			r = o.round
		end

		if o.playerAction[1][r] == nil then
			if id == 1 and o.saltosDisponibles > 0 then
				o.saltosDisponibles = o.saltosDisponibles - 1
				print ("salto")
				o.playerAction[1][r] = 1
				o.buttons[2].alpha = 0.3
				o.buttons[3].alpha = 0.3
			elseif id == 2 then
				print ("morder")
				o.playerAction[1][r] = 2

				o.buttons[1].alpha = 0.3
				o.buttons[3].alpha = 0.3
			elseif id == 3 then 
				print ("ladrar")
				o.playerAction[1][r] = 3
				o.buttons[2].alpha = 0.3
				o.buttons[1].alpha = 0.3
			end
		end

		return true
	end

	function o.scrollBG()
		for i=1, #o.bg do
			o.bg[i].x = o.bg[i].x - o.vel
			if o.bg[i].x < -1335 then
				o.bg[i].x = 2780
			end
		end
	end

	function o.showEnemys()
		
		o.enemysID = math.random(1,2)
		for i = 1, #o.enemys do
			function closure()
				function closure2()
					o.enemys[i].x = 1500
					o.enemys[i].alpha = 1
					o.enemys[i]:setFillColor(255,255,255)

					

					if i == 1 then
						if o.round < 10 then
							o.round = o.round + 1
							table.insert(o.timers, timer.performWithDelay(2500, o.showEnemys))
						else
							table.insert(o.timers, timer.performWithDelay(2500, o.terminar))
						end

						if o.saltosDisponibles > 0 then
							o.buttons[1].alpha = 1
						else
							o.buttons[1].alpha = 0.3
						end
						o.buttons[2].alpha = 1
						o.buttons[3].alpha = 1
					end

					
				end

				local function recuperar()
					o.players[i]:sequence("walk", o.players[i]:getSheet())
				end

				timer.performWithDelay(1500, recuperar)
				if o.playerAction[i][o.round] == 2 then
					--ATACAR
					o.players[i]:sequence("attack", o.players[i]:getSheet())
				elseif o.playerAction[i][o.round] == 1 then
					--SALTAR
					o.players[i]:sequence("jump", o.players[i]:getSheet())
				elseif o.playerAction[i][o.round] == 3 then
					--LADRAR
					o.players[i]:sequence("roar", o.players[i]:getSheet())
				end

				if (o.enemysID == 1 and o.playerAction[i][o.round] == 2) or (o.enemysID == 2 and o.playerAction[i][o.round] == 3) or o.playerAction[i][o.round] == nil then
					table.insert(o.transiciones, transition.to(o.enemys[i], {time = 100, x=o.players[i].x , alpha = 0, onComplete = closure2}))
					o.parpadearImagen(o.players[i], true)
					o.moverPlayer(i, -20)
					o.players[i]:sequence("hit", o.players[i]:getSheet())
				elseif o.playerAction[i][o.round] == 1 then
					table.insert(o.transiciones, transition.to(o.enemys[i], {time = 500, x=-200, onComplete = closure2}))
				else
					o.moverPlayer(i, 20)
					table.insert(o.timers, timer.performWithDelay(1250, closure2))
					o.parpadearImagen(o.enemys[i], false)
				end

				--table.insert(o.transiciones, transition.to(o.enemys[i], {time = 100, x=200, alpha = 0, onComplete = closure2}))
			end

			
			if o.enemysID == 1 then
				o.enemys[i]:sequence("anticuerpo", "enemies")
			else
				o.enemys[i]:sequence("globlulo", "enemies")
			end

			table.insert(o.transiciones, transition.to(o.enemys[i], {time = 1200, x=o.players[i].x + 100, onComplete = closure}))
		end
	end

	function o.terminar()
		table.insert(o.transiciones, transition.to(o.players[1], {time=1500, x = o.players[1].x + 1500}))
		table.insert(o.transiciones, transition.to(o.players[2], {time=1500, x = o.players[1].x + 1500}))
		table.insert(o.transiciones, transition.to(o.players[3], {time=1500, x = o.players[1].x + 1500}))
		table.insert(o.transiciones, transition.to(o.players[4], {time=1500, x = o.players[1].x + 1500, onComplete = o.sacarPuntuaciones}))
	end


	table.insert(o.timers, timer.performWithDelay(2500, o.showEnemys))


	function o.hacerTap( event )
		if event.y < 710 then
			if o.tapNumber < 2 then
				o.tapNumber = o.tapNumber + 1
			end

			if o.tapNumber == 1 and o.beatState == 1 then 
				o.moverPlayer(1, 1)
			elseif o.tapNumber == 1 and o.beatState == 2 then 
				print ("primer beat fallado")
			elseif o.tapNumber == 1 and o.beatState == 3 then 
				o.moverPlayer(1, 2)
			elseif o.tapNumber == 2 and o.beatState == 1 then 
				o.moverPlayer(1, 1)
			elseif o.tapNumber == 2 and o.beatState == 2 then 
				print ("segundo beat fallado")
			elseif o.tapNumber == 2 and o.beatState == 3 then 
				o.moverPlayer(1, 2)
			else
				o.moverPlayer(1, -1)
			end
		end
	end

	function o.moverPlayer( id, dis)
		if o.players[id].x + dis > o.playersInitial[id] + 150 or o.players[id].x + dis < o.playersInitial[id] - 150 then
			for i = 1, #o.players do
				if id ~= i then
					if o.players[i].x - dis < o.playersInitial[i] + 150 or o.players[i].x - dis > o.playersInitial[i] - 150 then
						o.players[i].x = o.players[i].x - dis 
					end
				end
			end
		else
			o.players[id].x = o.players[id].x + dis 
		end
	end


	function o.soundBeat1()
		o.beatState = 1

		function closure()
			if o.beatState == 1 then
				o.beatState = 2
			end
		end

		audio.play( o.beatID, { onComplete=closure } )

		table.insert(o.timers, timer.performWithDelay((15 - (o.round/2))* 20 , o.soundBeat2))
	end

	function o.soundBeat2()
		o.beatState = 3

		function closure()
			o.tapNumber = 0
			o.beatState = 0
			table.insert(o.timers, timer.performWithDelay((15 -(o.round/2))* 100 , o.soundBeat1))
		end

		audio.play( o.beatID, { onComplete=closure } )
	end

	function o.parpadearImagen( image, final )
		function aparecer1()
			function desaparecer1()
				function aparecer2()
					function desaparecer2()
						function final()
							if final == true then
								table.insert(o.transiciones, transition.to(image, {time=250, alpha = 1}))
							end
						end
						table.insert(o.transiciones, transition.to(image, {time=250, alpha = 0, onComplete = final}))
					end
					table.insert(o.transiciones, transition.to(image, {time=250, alpha = 1, onComplete = aparecer2}))
				end
				table.insert(o.transiciones, transition.to(image, {time=250, alpha = 0, onComplete = aparecer2}))
			end
			table.insert(o.transiciones, transition.to(image, {time=250, alpha = 1, onComplete = desaparecer1}))
		end
		table.insert(o.transiciones, transition.to(image, {time=250, alpha = 0, onComplete = aparecer1}))
	end



	function controlTest()
		print(o.round)
	end

	function o.mover()
		local t = math.random(250,500)

		table.insert(o.transiciones, transition.to(o.players[1], {time=t, y = o.players[1].y + math.random(-20,20), onComplete = o.volver}))
		--table.insert(o.transiciones, transition.to(o.players[2], {time=t, y = o.players[2].y + math.random(-20,20)}))
		table.insert(o.transiciones, transition.to(o.players[3], {time=t, y = o.players[3].y + math.random(-20,20)}))
	end
	
	function o.volver()
		local t = math.random(250,500)

		table.insert(o.transiciones, transition.to(o.players[1], {time=t, y = 290, onComplete = o.mover}))
		--table.insert(o.transiciones, transition.to(o.players[2], {time=t, y = 390}))
		table.insert(o.transiciones, transition.to(o.players[3], {time=t, y = 480}))
	end
	--Runtime:addEventListener("enterFrame", controlTest)

	Runtime:addEventListener("enterFrame", o.scrollBG)
	Runtime:addEventListener("tap", o.hacerTap)
	return o
end

	