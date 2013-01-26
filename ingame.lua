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


	function o.load( _player )
		o.gameImages = require("_SCENE").new()

		o.bg = o.gameImages.findThing("bg", "DEC")

		o.eyes = o.gameImages.findThing("ojos", "ANI")

		for i=1, #o.eyes do
			o.eyes[i]:sequence("pestaneo", "ojos")
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

		o.beatID = media.newEventSound( "sounds/beep.mp3" )

		local playBeep = function()
		        media.playEventSound( soundID )
		end
		timer.performWithDelay( 1000, playBeep, 0 )
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
			if math.abs(o.beatState) == 0 then
				print ("PERFECTO")
			elseif math.abs(o.beatState) == 1 then
				print ("1")
			elseif math.abs(o.beatState) == 2 then
				print ("2")
			elseif math.abs(o.beatState) == 3 then
				print ("3")
			elseif math.abs(o.beatState) == 4 then
				print ("4 ... cagada")
			end
		end
	end


	function o.changeBeatEstate()
		o.beatState = o.beatState + 1
		if o.beatState == 4 then
			o.beatState = -4 
			timer.performWithDelay(750, changeBeatEstate)
		else
			timer.performWithDelay(50, changeBeatEstate)
		end		
	end

	function o.soundBeat()
			
	end



	function controlTest()
		print(o.round)
	end
	--Runtime:addEventListener("enterFrame", controlTest)

	Runtime:addEventListener("enterFrame", o.scrollBG)
	Runtime:addEventListener("tap", o.hacerTap)



	return o
end

	