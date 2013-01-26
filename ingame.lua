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
	o.playerAction[3] = {1,3,3,3,2,1,2,1,2,2}
	o.playerAction[4] = {1,1,1,1,2,3,2,1,2,1}
	o.round = 1
	o.showingEnemys = false
	o.enemysID = {}
	o.beatState = -4
	o.tapNumber = 0
	o.playersInitial = {}


	function o.load( _player )
		o.gameImages = require("_SCENE").new("ingame_info")

		o.bg = o.gameImages.findThing("bg", "DEC")

		o.players = o.gameImages.findThing("ojos", "ANI")

		for i=1, #o.players do
			o.players[i]:sequence("pestaneo", "ojos")
			o.playersInitial[i] = o.players[i].x
		end

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

		o.enemys = o.gameImages.findThing("enemy1", "DEC")

		o.place = o.gameImages.findThing("place", "DEC")

		table.insert(o.transiciones, transition.to(o.place, {time = 60000, x=1024}))

		o.beatID = audio.loadSound("sounds/beat.mp3")

		o.soundBeat1()
	end

	function o.pulsarBotton( id )
		local r = 1

		if o.round == 0 then
			r = 1 
		else
			r = o.round
		end

		if o.playerAction[1][r] == nil then
			if id == 1 then
				print ("salto")
				o.playerAction[1][r] = 1
			elseif id == 2 then
				print ("morder")
				o.playerAction[1][r] = 2
			elseif id == 3 then 
				print ("ladrar")
				o.playerAction[1][r] = 3
			end
		end

		return true
	end

	function o.checkPositionBG()
		for i=1, #o.bg do
			if o.bg[i].x < -640 then
				o.bg[i].x = 1915
			end
		end
	end

	function o.scrollBG()
		for i=1, #o.bg do
			o.bg[i].x = o.bg[i].x - o.vel
		end
		
		o.checkPositionBG()
	end

	function o.showEnemys()
		

		for i = 1, #o.enemys do
			function closure()
				function closure2()
					o.enemys[i].x = 1500
					o.enemys[i].alpha = 1
					o.enemys[i]:setFillColor(255,255,255)

					if i == 1 then
						o.round = o.round + 1
						table.insert(o.timers, timer.performWithDelay(2500, o.showEnemys))
					end
				end

				if o.enemysID[i] == o.playerAction[i][o.round] then
					o.enemys[i]:setFillColor(220,255,220)
				else
					o.moverPlayer(i, -50)
					o.enemys[i]:setFillColor(0,0,0)
				end

				table.insert(o.transiciones, transition.to(o.enemys[i], {time = 100, x=200, alpha = 0, onComplete = closure2}))
			end

			o.enemysID[i] = 1

			table.insert(o.transiciones, transition.to(o.enemys[i], {time = 1200, x=300, onComplete = closure}))
		end
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
					o.players[i].x = o.players[i].x - dis 
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



	function controlTest()
		print(o.round)
	end
	--Runtime:addEventListener("enterFrame", controlTest)

	Runtime:addEventListener("enterFrame", o.scrollBG)
	Runtime:addEventListener("tap", o.hacerTap)
	return o
end

	