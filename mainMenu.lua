module(..., package.seeall)

function new()

	workRatioWidth = 1024;
	workRatioHeight = 768;

	local aspectRatioY = workRatioWidth / display.contentWidth;
	local aspectRatioY = workRatioHeight / display.contentWidth;

	local isAnimationEnd = false;
	
	local http = require("socket.http")

	local body, code, headers = http.request( "http://rivales.com/prueba/connect.php" );
	print(body);
	print(code);
	print(headers);
	--[[local sky = display.newImage( "sky.jpg" )
	sky.x = - 100;
	sky.xScale = 4;
	sky.yScale = 4;]]--
	--sky::setReferencePoint(display.TopLeftReferencePoint)

	--local beepSound = audio.loadSound( "beep.caf" )

	--[[local textObject = display.newText( "Hello World!", 50, 50, native.systemFont, 24 )
	textObject:setTextColor( 255,255,255 )]]--

	local button = display.newImage( "button.png" )
	button.x = display.contentWidth / 2
	button.y = display.contentHeight - 50

	local sheetChoose1 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	local sheetChooseInstance1;

	local sheetChoose2 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	local sheetChooseInstance2;

	local sheetChoose3 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	local sheetChooseInstance3;

	local sheetChoose4 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	local sheetChooseInstance4;

	local a = display.newGroup()
	
	local heart = nil
	heart = require("_ANI").new   ( a, {tipo = "ANI",  nombre = "heart", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	heart:show()
	heart:sequence("beat", "heart")
	heart.image.x = display.contentWidth  / 2;
	heart.image.y = display.contentHeight / 2;
	heart.image.xScale = 0.1;
	heart.image.yScale = 0.1;
	
	local trombo = nil
	trombo = require("_ANI").new   ( a, {tipo = "ANI",  nombre = "trombo", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	trombo:show();
	trombo:sequence("walk", "trombo")
	trombo.image.x = 0;
	trombo.image.y = 0;
	trombo.image.rotation = 45;
	trombo.image.xScale = .5;
	trombo.image.yScale = .5;
		
	local dammey = nil
	dammey = require("_ANI").new   ( a, {tipo = "ANI",  nombre = "dammey", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	dammey:show();
	dammey:sequence("walk", "dammey")
	dammey.image.x = display.contentWidth
	dammey.image.y = 0;
	dammey.image.rotation = 135;
	dammey.image.xScale = 1;
	dammey.image.yScale = 1;
		
	local mocteria = nil
	mocteria = require("_ANI").new   ( a, {tipo = "ANI",  nombre = "mocteria", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	mocteria:show();
	mocteria:sequence("walk", "mocteria")
	mocteria.image.x = 0
	mocteria.image.y = display.contentHeight
	mocteria.image.rotation = 315
	mocteria.image.xScale = .5
	mocteria.image.yScale = .5	

	local arabeja = nil
	arabeja = require("_ANI").new   ( a, {tipo = "ANI",  nombre = "arabeja", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	arabeja:show();
	arabeja:sequence("walk", "arabeja")
	arabeja.image.x = display.contentWidth
	arabeja.image.y = display.contentHeight - 50;
	arabeja.image.rotation = 225
	arabeja.image.xScale =  0.5
	arabeja.image.yScale = - 0.5
	
	local array = {}
	table.insert(array , transition.to( heart.image, { time=5000, yScale= 1.5, onComplete=finalEnd} ))
	table.insert(array , transition.to( heart.image, { time=5000, xScale= 1.5} ))
	local easingx  = require("easing")

	function touchA(event) 
		--[[local r = math.random( 0, 255 )
		local g = math.random( 0, 255 )
		local b = math.random( 0, 255 )

		textObject:setTextColor( r, g, b )]]--
		if (isAnimationEnd == false) then
			local i
			for i = 1, #array, 1 do
				transition.cancel(array[i]);
			end
			table.insert(array , transition.to( heart.image, { time=500, yScale= 1.5, onComplete=finalEnd }))
			table.insert(array , transition.to( heart.image, { time=500, xScale= 1.5} ))
		else
			Runtime:removeEventListener( "tap", touchA );
			changeToSelect();
		end
	end

	function finalEnd ()
	
		isAnimationEnd = true;

		table.insert(array , transition.to( trombo.image, { time=1000, x= display.contentWidth / 2, onComplete=changeToSelect, transition=easingx.easeIn}))
		table.insert(array , transition.to( trombo.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn }))
		table.insert(array , transition.to( trombo.image, { time=1000, xScale= 0.01, delay=300,}))
		table.insert(array , transition.to( trombo.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(array , transition.to( dammey.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn} ))
		table.insert(array , transition.to( dammey.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn } ))
		table.insert(array , transition.to( dammey.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(array , transition.to( dammey.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(array , transition.to( mocteria.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn } ))
		table.insert(array , transition.to( mocteria.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn }))
		table.insert(array , transition.to( mocteria.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(array , transition.to( mocteria.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(array , transition.to( arabeja.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn} ))
		table.insert(array , transition.to( arabeja.image, { time=1000, y= display.contentHeight / 2 , transition=easingx.easeIn}))
		table.insert(array , transition.to( arabeja.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(array , transition.to( arabeja.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(array , transition.to( trombo.image, { time=1000, alpha= 0, delay=300}))
		table.insert(array , transition.to( dammey.image, { time=1000, alpha= 0, delay=300} ))
		table.insert(array , transition.to( mocteria.image, { time=1000, alpha= 0, delay=300} ))
		table.insert(array , transition.to( arabeja.image, { time=1000, alpha= 0, delay=300}))
		table.insert(array , transition.to( heart.image, { time=1000, alpha= 0, delay=300}))

	end

	function changeToSelect ()
		
		--[[table.insert(array , transition.to( trombo.image, { time=500, alpha= 0}))
		table.insert(array , transition.to( dammey.image, { time=500, alpha= 0} ))
		table.insert(array , transition.to( mocteria.image, { time=500, alpha= 0} ))
		table.insert(array , transition.to( arabeja.image, { time=500, alpha= 0}))
		table.insert(array , transition.to( heart.image, { time=500, alpha= 0}))]]--
		showSelectScene();

	end

	function showSelectScene()

		sheetChooseInstance1 = display.newSprite( sheetChoose1, { name="man", start=1, count=15, time=500 } )
		sheetChooseInstance1.x = -sheetChooseInstance1.width ;
		sheetChooseInstance1.y = (display.contentHeight / 6 ) ;
		sheetChooseInstance1:play();
		
		sheetChooseInstance2 = display.newSprite( sheetChoose2, { name="man", start=1, count=15, time=500 } )
		sheetChooseInstance2.x = display.contentWidth  + sheetChooseInstance2.width;
		sheetChooseInstance2.y = (display.contentHeight / 6) * 2.5;
		sheetChooseInstance2:play();
		
		sheetChooseInstance3 = display.newSprite( sheetChoose3, { name="man", start=1, count=15, time=500 } )
		sheetChooseInstance3.x = -sheetChooseInstance3.width;
		sheetChooseInstance3.y =  (display.contentHeight / 6 ) * 4;
		sheetChooseInstance3:play();
		
		sheetChooseInstance4 = display.newSprite( sheetChoose4, { name="man", start=1, count=15, time=500 } )
		sheetChooseInstance4.x = display.contentWidth  + sheetChooseInstance4.width;
		sheetChooseInstance4.y = display.contentHeight / 6 * 5.5;
		sheetChooseInstance4:play();
		
		table.insert(array , transition.to( sheetChooseInstance1, { time=500, x=(display.contentWidth  / 4 )* 3 }))
		table.insert(array , transition.to( sheetChooseInstance2, { time=500, x= display.contentWidth  / 4}))
		table.insert(array , transition.to( sheetChooseInstance3, { time=500, x= (display.contentWidth  / 4) * 3}))
		table.insert(array , transition.to( sheetChooseInstance4, { time=500, x= display.contentWidth  / 4}))
		
		sheetChooseInstance1:addEventListener("tap", function() selectTapHandler(1) end);
		sheetChooseInstance2:addEventListener("tap", function() selectTapHandler(2) end);
		sheetChooseInstance3:addEventListener("tap", function() selectTapHandler(3) end);
		sheetChooseInstance4:addEventListener("tap", function() selectTapHandler(4) end);

	end

	function selectTapHandler(event) 
		print(event);
	end

	--button:addEventListener( "tap", button )

	Runtime:addEventListener( "tap", touchA );

end