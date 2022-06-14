local enemyRate = math.random(1,200)/100
local currentDt = 0
local enemies = {}

function love.load()
    Object = require("lib.classic")
    inspect = require("lib.inspect")
    require("game")
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end