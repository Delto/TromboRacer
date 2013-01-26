module(..., package.seeall)

function new()
	local o = {}

	o.workRatioWidth = 1024;
	o.workRatioHeight = 768;

	o.aspectRatioY = o.workRatioWidth / display.contentWidth;
	o.aspectRatioY = o.workRatioHeight / display.contentWidth;

	o.isAnimationEnd = false;
	
	o.http = require("socket.http")

	o.body, o.code, o.headers = o.http.request( "http://rivales.com/prueba/connect.php" );
	print(o.body);
	print(o.code);
	print(o.headers);
	--[[local sky = display.newImage( "sky.jpg" )
	sky.x = - 100;
	sky.xScale = 4;
	sky.yScale = 4;]]--
	--sky::setReferencePoint(display.TopLeftReferencePoint)

	--local beepSound = audio.loadSound( "beep.caf" )

	--[[local textObject = display.newText( "Hello World!", 50, 50, native.systemFont, 24 )
	textObject:setTextColor( 255,255,255 )]]--

	o.button = display.newImage( "button.png" )
	o.button.x = display.contentWidth / 2
	o.button.y = display.contentHeight - 50

	o.sheetChoose1 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	--o.sheetChooseInstance1;

	o.sheetChoose2 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	--o.sheetChooseInstance2;

	o.sheetChoose3 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	--o.sheetChooseInstance3;

	o.sheetChoose4 = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	--o.sheetChooseInstance4;

	o.a = display.newGroup()
	
	o.heart = nil
	o.heart = require("_ANI").new   ( o.a, {tipo = "ANI",  nombre = "heart", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	o.heart:show()
	o.heart:sequence("beat", "heart")
	o.heart.image.x = display.contentWidth  / 2;
	o.heart.image.y = display.contentHeight / 2;
	o.heart.image.xScale = 0.1;
	o.heart.image.yScale = 0.1;
	
	o.trombo = nil
	o.trombo = require("_ANI").new   ( o.a, {tipo = "ANI",  nombre = "trombo", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	o.trombo:show();
	o.trombo:sequence("walk", "trombo")
	o.trombo.image.x = 0;
	o.trombo.image.y = 0;
	o.trombo.image.rotation = 45;
	o.trombo.image.xScale = .5;
	o.trombo.image.yScale = .5;
		
	o.dammey = nil
	o.dammey = require("_ANI").new   ( o.a, {tipo = "ANI",  nombre = "dammey", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	o.dammey:show();
	o.dammey:sequence("walk", "dammey")
	o.dammey.image.x = display.contentWidth
	o.dammey.image.y = 0;
	o.dammey.image.rotation = 135;
	o.dammey.image.xScale = 1;
	o.dammey.image.yScale = 1;
		
	o.mocteria = nil
	o.mocteria = require("_ANI").new   ( o.a, {tipo = "ANI",  nombre = "mocteria", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	--t.y = display.contentHeight / 2 - (t.height / 2);
	o.mocteria:show();
	o.mocteria:sequence("walk", "mocteria")
	o.mocteria.image.x = 0
	o.mocteria.image.y = display.contentHeight
	o.mocteria.image.rotation = 315
	o.mocteria.image.xScale = .5
	o.mocteria.image.yScale = .5	

	o.arabeja = nil
	o.arabeja = require("_ANI").new   ( o.a, {tipo = "ANI",  nombre = "arabeja", x = 200, y = 200, tamx = 1, tamy = 1, ancho = 1280, alto = 800, ang = 0, alfa = 1})
	o.arabeja:show();
	o.arabeja:sequence("walk", "arabeja")
	o.arabeja.image.x = display.contentWidth
	o.arabeja.image.y = display.contentHeight - 50;
	o.arabeja.image.rotation = 225
	o.arabeja.image.xScale =  0.5
	o.arabeja.image.yScale = - 0.5
	
	o.array = {}
	table.insert(o.array , transition.to( o.heart.image, { time=5000, yScale= 1.5, onComplete=o.finalEnd} ))
	table.insert(o.array , transition.to( o.heart.image, { time=5000, xScale= 1.5} ))
	easingx  = require("easing")

	function touchA(event) 
		--[[local r = math.random( 0, 255 )
		local g = math.random( 0, 255 )
		local b = math.random( 0, 255 )

		textObject:setTextColor( r, g, b )]]--
		if (o.isAnimationEnd == false) then
			local i
			for i = 1, #o.array, 1 do
				transition.cancel(o.array[i]);
			end
			table.insert(o.array , transition.to( o.heart.image, { time=500, yScale= 1.5, onComplete=o.finalEnd }))
			table.insert(o.array , transition.to( o.heart.image, { time=500, xScale= 1.5} ))
		else
			Runtime:removeEventListener( "tap", touchA );
			o.changeToSelect();
		end
	end

	function o.finalEnd ()
	
		o.isAnimationEnd = true;

		table.insert(o.array , transition.to( o.trombo.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn }))
		table.insert(o.array , transition.to( o.trombo.image, { time=1000, xScale= 0.01, delay=300,}))
		table.insert(o.array , transition.to( o.trombo.image, { time=1000, x= display.contentWidth / 2, onComplete=o.changeToSelect, transition=easingx.easeIn}))
		table.insert(o.array , transition.to( o.trombo.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.dammey.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn} ))
		table.insert(o.array , transition.to( o.dammey.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn } ))
		table.insert(o.array , transition.to( o.dammey.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.dammey.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.mocteria.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn } ))
		table.insert(o.array , transition.to( o.mocteria.image, { time=1000, y= display.contentHeight / 2, transition=easingx.easeIn }))
		table.insert(o.array , transition.to( o.mocteria.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.mocteria.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.arabeja.image, { time=1000, x= display.contentWidth / 2 , transition=easingx.easeIn} ))
		table.insert(o.array , transition.to( o.arabeja.image, { time=1000, y= display.contentHeight / 2 , transition=easingx.easeIn}))
		table.insert(o.array , transition.to( o.arabeja.image, { time=1000, xScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.arabeja.image, { time=1000, yScale= 0.01, delay=300}))
		table.insert(o.array , transition.to( o.trombo.image, { time=1000, alpha= 0, delay=300}))
		table.insert(o.array , transition.to( o.dammey.image, { time=1000, alpha= 0, delay=300} ))
		table.insert(o.array , transition.to( o.mocteria.image, { time=1000, alpha= 0, delay=300} ))
		table.insert(o.array , transition.to( o.arabeja.image, { time=1000, alpha= 0, delay=300}))
		table.insert(o.array , transition.to( o.heart.image, { time=1000, alpha= 0, delay=300}))

	end

	function o.changeToSelect ()
		
		--[[table.insert(array , transition.to( trombo.image, { time=500, alpha= 0}))
		table.insert(array , transition.to( dammey.image, { time=500, alpha= 0} ))
		table.insert(array , transition.to( mocteria.image, { time=500, alpha= 0} ))
		table.insert(array , transition.to( arabeja.image, { time=500, alpha= 0}))
		table.insert(array , transition.to( heart.image, { time=500, alpha= 0}))]]--
		o.showSelectScene();

	end

	function o.showSelectScene()

		o.sheetChooseInstance1 = display.newSprite( o.sheetChoose1, { name="man", start=1, count=15, time=500 } )
		o.sheetChooseInstance1.x = -o.sheetChooseInstance1.width ;
		o.sheetChooseInstance1.y = (display.contentHeight / 6 ) ;
		o.sheetChooseInstance1:play();
		
		o.sheetChooseInstance2 = display.newSprite( o.sheetChoose2, { name="man", start=1, count=15, time=500 } )
		o.sheetChooseInstance2.x = display.contentWidth  + o.sheetChooseInstance2.width;
		o.sheetChooseInstance2.y = (display.contentHeight / 6) * 2.5;
		o.sheetChooseInstance2:play();
		
		o.sheetChooseInstance3 = display.newSprite( o.sheetChoose3, { name="man", start=1, count=15, time=500 } )
		o.sheetChooseInstance3.x = -o.sheetChooseInstance3.width;
		o.sheetChooseInstance3.y =  (display.contentHeight / 6 ) * 4;
		o.sheetChooseInstance3:play();
		
		o.sheetChooseInstance4 = display.newSprite( o.sheetChoose4, { name="man", start=1, count=15, time=500 } )
		o.sheetChooseInstance4.x = display.contentWidth  + o.sheetChooseInstance4.width;
		o.sheetChooseInstance4.y = display.contentHeight / 6 * 5.5;
		o.sheetChooseInstance4:play();
		
		table.insert(o.array , transition.to( o.sheetChooseInstance1, { time=500, x=(display.contentWidth  / 4 )* 3 }))
		table.insert(o.array , transition.to( o.sheetChooseInstance2, { time=500, x= display.contentWidth  / 4}))
		table.insert(o.array , transition.to( o.sheetChooseInstance3, { time=500, x= (display.contentWidth  / 4) * 3}))
		table.insert(o.array , transition.to( o.sheetChooseInstance4, { time=500, x= display.contentWidth  / 4}))
		
		o.sheetChooseInstance1:addEventListener("tap", function() o.selectTapHandler(1) end);
		o.sheetChooseInstance2:addEventListener("tap", function() o.selectTapHandler(2) end);
		o.sheetChooseInstance3:addEventListener("tap", function() o.selectTapHandler(3) end);
		o.sheetChooseInstance4:addEventListener("tap", function() o.selectTapHandler(4) end);

	end

	function o.selectTapHandler(event) 
		print(event);
	end

	--button:addEventListener( "tap", button )

	Runtime:addEventListener( "tap", touchA );

end