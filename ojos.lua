module(...)

-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- 
-- 
-- Usage example:
--			local sheetData = require "ThisFile.lua"
--          local data = sheetData.getSpriteSheetData()
--			local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
-- 
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets
function getExposureSheet()
	local s = {

		{nombre = "abiertos", loop = false, duracion = 1667, frames = {1} },
		{nombre = "cerrados", loop = false, duracion = 1667, frames = {4} },
		{nombre = "pestaneo", loop = true, duracion = 3667, frames = {4,3,2,1,1,1,1,1,2,3,4,4,4,3,2,1,1,1,1,1,2,3,4} },
	
	}
	return s
end
function getSpriteSheetData()
    local sheet = {
        frames = {
            {
                name = "laberinto_ojos10001.png",
                spriteColorRect = { x = 0, y = 4, width = 32, height = 6 },
                textureRect = { x = 2, y = 2, width = 32, height = 6 },
                spriteSourceSize = { width = 32, height = 16 },
                spriteTrimmed = true,
                textureRotated = false
            },
            {
                name = "laberinto_ojos10002.png",
                spriteColorRect = { x = 0, y = 6, width = 32, height = 4 },
                textureRect = { x = 2, y = 16, width = 32, height = 4 },
                spriteSourceSize = { width = 32, height = 16 },
                spriteTrimmed = true,
                textureRotated = false
            },
            {
                name = "laberinto_ojos10003.png",
                spriteColorRect = { x = 0, y = 6, width = 32, height = 4 },
                textureRect = { x = 2, y = 10, width = 32, height = 4 },
                spriteSourceSize = { width = 32, height = 16 },
                spriteTrimmed = true,
                textureRotated = false
            },
            {
                name = "laberinto_ojos10004.png",
                spriteColorRect = { x = 0, y = 0, width = 0, height = 0 },
                textureRect = { x = 2, y = 22, width = 0, height = 0 },
                spriteSourceSize = { width = 32, height = 16 },
                spriteTrimmed = false,
                textureRotated = false
            },
        }
    }
    return sheet
end

