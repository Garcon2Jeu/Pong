Ball = Class {}

function Ball:init()
    self.x      = CENTER_WIDTH - 2
    self.y      = CENTER_HEIGHT - 2
    self.dx     = math.random(2) == 1 and 100 or -100
    self.dy     = math.random(-50, 50)
    self.width  = 4
    self.height = 4
end

function Ball:update(dt)
    self:move(dt)

    if App:hasCollided(self, paddle1) then
        self:bounceOffPaddles(paddle1.x + 5)
    elseif App:hasCollided(self, paddle2) then
        self:bounceOffPaddles(paddle2.x - 4)
    end

    self:bounceOffWalls()
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:reset(key)
    if key == "return" then
        self:init()
    end
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:bounceOffPaddles(offset)
    self.x = offset
    self.dx = -self.dx
    self.dy = self.dy < 0 and
        -math.random(10, 150)
        or
        math.random(10, 150)
end

function Ball:bounceOffWalls()
    if self.y < 0 then
        self.y = 0
        self.dy = -self.dy
    elseif self.y + self.height > VIRTUAL_HEIGHT then
        self.y = VIRTUAL_HEIGHT - self.height
        self.dy = -self.dy
    end
end
