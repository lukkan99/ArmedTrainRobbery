------------------------------------------------------------
-- Game Gamestate ------------------------------------------
------------------------------------------------------------
-- Manages the train in the playable part, 'the train'.
------------------------------------------------------------

-- Libraries
local class = require 'lib.middleclass'
local Gamestate = require 'lib.hump.gamestate'
local Character = require 'class.Character'
local Entity = require 'class.Entity'

-- Gamestate
local train = {}
local speed = 5

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
end

local function movePlayer()
    if love.keyboard.isDown('a') then
        player.x = player.x - speed
    elseif love.keyboard.isDown('d') then
        player.x = player.x + speed
    end
    if love.keyboard.isDown('w') then
        player.x = player.y + speed
    elseif love.keyboard.isDown('s') then
        player.x = player.y - speed
    end
    
end

local function moveNpc(x,y,npc)
    
end

function train:init()
    local player = Entity:new (10,10, media.image.player)
    self.entities = {}

    for name, dialog in pairs(dialogs) do
        local character = Character:new(dialog)
        self.entities[name] = Entity:new(100, 100, media.image[name], character)
    end

    self.focus = nil -- the character you want to talk to
end

function train:update(dt)
    movePlayer()
end

function train:draw()
    love.graphics.print('train', 50, 50)
end

function train:keypressed(key, isrepeat)
    self.focus = self.entities.ticket_man
    Gamestate.switch(gamestate.dialog)
end

return train
