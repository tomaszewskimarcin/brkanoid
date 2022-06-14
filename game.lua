Game = Object:extend()

function Game:new()
    require("projectile")
    require("enemy")
    require("ship")
    self.ship = Ship(20, 10, 200, .3)
    self.currentDt = 0
    self.enemyRate = math.random(1,200)/100
    self.enemies = {}
end

function Game:update(dt)
    self.ship:update(dt)
    self:generalActions(dt)
    self:spawnEnemies(dt)
    self:updateEnemies(dt)
end

function Game:draw()
    self.ship:draw()
    self:drawEnemies()
end

--Update Functions

function Game:spawnEnemies(dt)
    self.currentDt = self.currentDt + dt
    if self.currentDt >= self.enemyRate then
        self.currentDt = 0
        self.enemyRate = math.random(1,200)/100
        table.insert(self.enemies, Enemy(20, math.random(100, 400)))
    end
end

function Game:updateEnemies(dt)
    for k, v in pairs(self.enemies) do
        v:setProjectiles(self.ship:getProjectiles())
        v:update(dt)
        if v:isOutOfBounds() then
            table.remove(self.enemies, k)
        end
    end
end

function Game:generalActions(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end
end

--Draw Functions

function Game:drawEnemies()
    for k, v in pairs(self.enemies) do
        v:draw()
    end
end