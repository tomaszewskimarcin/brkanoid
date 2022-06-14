function love.load()
    Object = require("lib.classic")
    inspect = require("lib.inspect")
    require("classes.game")
    game = Game()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end