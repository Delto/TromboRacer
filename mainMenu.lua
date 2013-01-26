module(..., package.seeall)

function new()
	workRatioWidth = 1024;
	workRatioHeight = 768;

	local aspectRatioY = workRatioWidth / display.contentWidth;
	local aspectRatioY = workRatioHeight / display.contentWidth;

	local isAnimationEnd = false;

	local sky = display.newImage( "sky.jpg" )
	sky.x = - 100;
	sky.xScale = 4;
	sky.yScale = 4;
	--sky::setReferencePoint(display.TopLeftReferencePoint)

	local beepSound = audio.loadSound( "beep.caf" )

	--[[local textObject = display.newText( "Hello World!", 50, 50, native.systemFont, 24 )
	textObject:setTextColor( 255,255,255 )]]--

	-- an image sheet with a cat
	local sheet1 = graphics.newImageSheet( "runningcat.png", { width=512, height=256, numFrames=8 } )

	-- play 8 frames every 1000 ms
	local instance1 = display.newSprite( sheet1, { name="cat", start=1, count=8, time=1000 } )
	instance1.x = 0;
	instance1.y = 0;
	instance1.rotation = 45
	instance1:play()

	-- an image sheet with a cat
	local sheet2 = graphics.newImageSheet( "runningcat.png", { width=512, height=256, numFrames=8 } )

	-- play 8 frames every 1000 ms
	local instance2 = display.newSprite( sheet2, { name="cat", start=1, count=8, time=1000 } )
	instance2.x = display.contentWidth
	instance2.y = 0;
	instance2.rotation = 135
	instance2:play()

	-- an image sheet with a cat
	local sheet3 = graphics.newImageSheet( "runningcat.png", { width=512, height=256, numFrames=8 } )

	-- play 8 frames every 1000 ms
	local instance3 = display.newSprite( sheet3, { name="cat", start=1, count=8, time=1000 } )
	instance3.x = 0
	instance3.y = display.contentHeight
	instance3.rotation = 315
	instance3:play()

	-- an image sheet with a cat
	local sheet4 = graphics.newImageSheet( "runningcat.png", { width=512, height=256, numFrames=8 } )

	-- play 8 frames every 1000 ms
	local instance4 = display.newSprite( sheet4, { name="cat", start=1, count=8, time=1000 } )
	instance4.x = display.contentWidth
	instance4.y = display.contentHeight - 50;
	instance4.rotation = 225
	instance4:play()

	-- A sprite sheet with a green dude
	local heart = graphics.newImageSheet( "greenman.png", { width=128, height=128, numFrames=15 } )

	-- play 15 frames every 500 ms
	local heartInstance = display.newSprite( heart, { name="man", start=1, count=15, time=500 } )
	heartInstance.x = display.contentWidth  / 2;
	heartInstance.y = display.contentHeight / 2;
	heartInstance.xScale = .1
	heartInstance.yScale = .1
	heartInstance:play()

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

	local array = {}
	table.insert(array , transition.to( heartInstance, { time=5000, yScale= 5, onComplete=finalEnd} ))
	table.insert(array , transition.to( heartInstance, { time=5000, xScale= 5} ))

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
			table.insert(array , transition.to( heartInstance, { time=500, yScale= 5, onComplete=finalEnd }))
			table.insert(array , transition.to( heartInstance, { time=500, xScale= 5} ))
		else
			changeToSelect();
			Runtime:removeEventListener( "tap", touchA );
		end
	end

	function finalEnd ()
		isAnimationEnd = true;
		table.insert(array , transition.to( instance1, { time=300, x= display.contentWidth / 4 }))
		table.insert(array , transition.to( instance1, { time=300, y= display.contentHeight / 4 }))
		table.insert(array , transition.to( instance2, { time=300, x= display.contentWidth / 4 * 3 } ))
		table.insert(array , transition.to( instance2, { time=300, y= (display.contentHeight / 4) } ))
		table.insert(array , transition.to( instance3, { time=300, x= (display.contentWidth / 4 ) } ))
		table.insert(array , transition.to( instance3, { time=300, y= display.contentHeight / 4 * 3 }))
		table.insert(array , transition.to( instance4, { time=300, x= (display.contentWidth / 4 ) * 3 } ))
		table.insert(array , transition.to( instance4, { time=300, y= (display.contentHeight / 4 ) * 3 }))
	end

	function changeToSelect ()
		
		table.insert(array , transition.to( instance1, { time=500, alpha= 0}))
		table.insert(array , transition.to( instance2, { time=500, alpha= 0} ))
		table.insert(array , transition.to( instance3, { time=500, alpha= 0} ))
		table.insert(array , transition.to( instance4, { time=500, alpha= 0}))
		table.insert(array , transition.to( heartInstance, { time=500, alpha= 0}))
		table.insert(array , transition.to( heartInstance, { time=500, alpha= 0} ))
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
	end

	--button:addEventListener( "tap", button )


	Runtime:addEventListener( "tap", touchA );

	--transition.to( heartInstance, { time=1000, y=textObject.y+100 } )

end