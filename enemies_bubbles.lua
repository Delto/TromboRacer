module(...)

-- This file is for use with Corona Game Edition
-- 
-- The function getSpriteSheetData() returns a table suitable for importing using sprite.newSpriteSheetFromData()
-- 
-- This file is automatically generated with TexturePacker (http://texturepacker.com). Do not edit
-- $TexturePacker:SmartUpdate:9ad5e325babc88084f30efd03e853e95$
-- 
-- Usage example:
--        local sheetData = require "ThisFile.lua"
--        local data = sheetData.getSpriteSheetData()
--        local spriteSheet = sprite.newSpriteSheetFromData( "Untitled.png", data )
-- 
-- For more details, see http://developer.anscamobile.com/content/game-edition-sprite-sheets

function getExposureSheet()
	local s = {
		{nombre = "anticuerpo", loop = false, duracion = 1667, frames = {1} },
		{nombre = "globlulo", loop = false, duracion = 1667, frames = {6} },
		{nombre = "burbujasmini", loop = false, duracion = 1667, frames = {2} },
		{nombre = "burbujas1", loop = false, duracion = 1667, frames = {3} },
		{nombre = "burbujas2", loop = false, duracion = 1667, frames = {4} },
		{nombre = "burbujasgrupo", loop = false, duracion = 1667, frames = {5} },
	}
	return s
end

local SpriteSheet = {}
SpriteSheet.getSpriteSheetData = function ()
	return {
		frames = {
			{
				name = "Anticuerpo.png",
				spriteColorRect = { x = 0, y = 0, width = 222, height = 196 },
				textureRect = { x = 770, y = 2, width = 222, height = 196 },
				spriteSourceSize = { width = 222, height = 196 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "burbujamini.png",
				spriteColorRect = { x = 0, y = 0, width = 21, height = 22 },
				textureRect = { x = 994, y = 2, width = 21, height = 22 },
				spriteSourceSize = { width = 21, height = 22 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "burbujas1.png",
				spriteColorRect = { x = 0, y = 0, width = 766, height = 80 },
				textureRect = { x = 2, y = 136, width = 766, height = 80 },
				spriteSourceSize = { width = 766, height = 80 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "burbujas2.png",
				spriteColorRect = { x = 0, y = 0, width = 468, height = 109 },
				textureRect = { x = 2, y = 393, width = 468, height = 109 },
				spriteSourceSize = { width = 468, height = 109 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "burbujas_grupo.png",
				spriteColorRect = { x = 0, y = 0, width = 766, height = 132 },
				textureRect = { x = 2, y = 2, width = 766, height = 132 },
				spriteSourceSize = { width = 766, height = 132 },
				spriteTrimmed = false,
				textureRotated = false
			},
			{
				name = "globulo.png",
				spriteColorRect = { x = 0, y = 0, width = 131, height = 173 },
				textureRect = { x = 2, y = 218, width = 131, height = 173 },
				spriteSourceSize = { width = 131, height = 173 },
				spriteTrimmed = false,
				textureRotated = false
			},
		}
	}
end
return SpriteSheet
