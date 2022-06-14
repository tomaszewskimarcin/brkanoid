Projectile = Object:extend()

function Projectile:new(x, y, size, speed, dir)
    self.outOfBounds = false
    self.size = size
    self.dir = dir
    self.speed = speed * dir
    self.x = x - self.size/2
    self.y = y + self.size*dir
end

function Projectile:update(dt)
    self.y = self.y + self.speed*dt
    if (self.dir > 0 and self.y >= love.graphics.getHeight()) or (self.dir < 0 and self.y <= 0) then
        self.outOfBounds = true
    end
end

function Projectile:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.size, self.size)
end

function Projectile:isOutOfBounds()
    return self.outOfBounds
end