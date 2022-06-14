Game = Object:extend()

function Game:new()
    require("classes.objects.projectile")
    require("classes.objects.enemy")
    require("classes.objects.ship")
    require("classes.enemySpawner")
    self.ship = Ship(20, 10, 200, .3)
    self.enemySpawner = EnemySpawner()
    self:updateEnemySpawnerRateAndSpeed()
end

function Game:update(dt)
    self:generalActions(dt)
    self.ship:update(dt)
    if(self.enemySpawner:isEnemySpawned()) then
        self:updateEnemySpawnerRateAndSpeed()
    end
    self.enemySpawner:setProjectiles(self.ship:getProjectiles())
    self.enemySpawner:update(dt)
end

function Game:draw()
    self.ship:draw()
    self.enemySpawner:draw()
end

--Update Functions

function Game:generalActions(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit(0)
    end
end

function Game:updateEnemySpawnerRateAndSpeed()
    self.enemySpawner:setRate(math.random(1,200)/100)
    self.enemySpawner:setSpeed(math.random(100, 400))
end