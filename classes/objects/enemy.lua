Enemy = Object:extend()

function Enemy:new(size, speed)
    self.size = size
    self.speedX = speed
    self.speedY = speed/2
    self.outOfBounds = false
    self.dead = false
    self.projectiles = {}
    self.x = math.random(self.size, love.graphics.getWidth() - self.size)
    self.y = 0 - self.size
    self.dir = math.random(-1,1)
end

function Enemy:update(dt)
    self.x = self.x + (self.speedX*self.dir)*dt
    self.y = self.y + self.speedY*dt
    if self.dir == 1 and self.x >= love.graphics.getWidth() - self.size then
        self.x = love.graphics.getWidth() - self.size
        self.dir = self.dir * -1
    elseif self.dir == -1 and self.x <= 0 then
        self.x = 0
        self.dir = self.dir * -1
    end
    if self.y >= love.graphics.getHeight() - self.size then
        self.outOfBounds = true
    end
    self.dead = self:collidesWithProjectiles()
end

function Enemy:collidesWithProjectiles()
    for k,v in pairs(self.projectiles) do
        if self:collidesWithProjectile(v) then
            return true
        end
    end
    return false
end

function Enemy:collidesWithProjectile(projectile)
    return projectile.x + projectile.size > self.x and projectile.x < self.x + self.size and projectile.y + projectile.size > self.y and projectile.y < self.y + self.size
end

function Enemy:draw()
    love.graphics.rectangle("line", self.x, self.y, self.size, self.size)
end

function Enemy:isOutOfBounds()
    return self.outOfBounds
end

function Enemy:isDead()
    return self.dead
end

function Enemy:setProjectiles(projectiles)
    self.projectiles = projectiles
end