Ship = Object:extend()

function Ship:new(width, height, speed, fireRate)
    self.speed = speed
    self.width = width
    self.height = height
    self.fireRate = fireRate
    self.currentDt = 0
    self.projectiles = {}
    self.x = love.graphics.getWidth() / 2 - self.width/2
    self.y = love.graphics.getHeight() - self.height - 10
    self.image = love.graphics.newImage('sprites/spaceShip.png')
end

function Ship:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
    elseif love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
    end

    if self.x + self.width >= love.graphics.getWidth() then
        self.x = love.graphics.getWidth() - self.width
    elseif self.x <= 0 then
        self.x = 0
    end
    self:updateProjectiles(dt)
end

function Ship:updateProjectiles(dt)
    self.currentDt = self.currentDt + dt
    if self.currentDt >= self.fireRate then
        self.currentDt = 0
        table.insert(self.projectiles, Projectile(self.x + self.width/2, self.y - 5, 5, 300, -1))
    end
    for k, v in pairs(self.projectiles) do
        v:update(dt)
        if v:isOutOfBounds() then
            table.remove(self.projectiles, k)
        end
    end
end

function Ship:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.draw(self.image, self.x, self.y)
    self:drawProjectiles()
end

function Ship:drawProjectiles()
    for k, v in pairs(self.projectiles) do
        v:draw()
    end
end

function Ship:getProjectiles()
    return self.projectiles
end