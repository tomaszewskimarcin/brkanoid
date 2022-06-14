EnemySpawner = Object:extend()

function EnemySpawner:new()
    self.currentDt = 0
    self.enemyRate = 0
    self.enemySpeed = 0
    self.enemies = {}
    self.projectiles = {}
    self.enemySpawned = false
end

function EnemySpawner:update(dt)
    self:spawnEnemies(dt)
    self:updateEnemies(dt)
end

function EnemySpawner:draw()
    self:drawEnemies()
end

--updateFunctions

function EnemySpawner:setProjectiles(projectiles)
    self.projectiles = projectiles
end

function EnemySpawner:spawnEnemies(dt)
    self.currentDt = self.currentDt + dt
    if self.currentDt >= self.enemyRate then
        self.currentDt = 0
        self.enemyRate = math.random(1,200)/100
        table.insert(self.enemies, Enemy(20, self.enemySpeed))
    end
end

function EnemySpawner:updateEnemies(dt)
    for k, v in pairs(self.enemies) do
        v:setProjectiles(self.projectiles)
        v:update(dt)
        if v:isOutOfBounds() or v:isDead() then
            table.remove(self.enemies, k)
        end
    end
end

--drawFunctions

function EnemySpawner:drawEnemies()
    for k, v in pairs(self.enemies) do
        v:draw()
    end
end

--generalFunctions

function EnemySpawner:setRate(rate)
    self.enemyRate = rate
end

function EnemySpawner:setSpeed(speed)
    self.enemySpeed = speed
end

function EnemySpawner:isEnemySpawned()
    if self.enemySpawned then
        self.enemySpawned = false
        return true
    end
    return false
end