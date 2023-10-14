Ball = Class {}

function Ball:init()
    self.x      = CENTER_WIDTH - 2
    self.y      = CENTER_HEIGHT - 2
    self.dx     = math.random(2) == 1 and 100 or -100
    self.dy     = math.random(-50, 50)
    self.width  = 4
    self.height = 4
    self.speed  = 1
end

function Ball:update(dt)
    if not gameState.play then
        return
    end

    self:move(dt)

    if App:hasCollided(self, paddle1) then
        self:bounceOffPaddles(paddle1.x + 5)
    elseif App:hasCollided(self, paddle2) then
        self:bounceOffPaddles(paddle2.x - 4)
    end

    self:bounceOffWalls()
    self:score()
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:move(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Ball:bounceOffPaddles(offset)
    self.x = offset
    self.speed = self.speed + .05
    self.dx = -self.dx * self.speed
    self.dy = self.dy < 0 and
        -math.random(10, 150)
        or
        math.random(10, 150)
    sounds["paddle_hit"]:play()
end

function Ball:bounceOffWalls()
    if self.y < 0 then
        self.y = 0
        self.dy = -self.dy
        sounds["wall_hit"]:play()
    elseif self.y + self.height > VIRTUAL_HEIGHT then
        self.y = VIRTUAL_HEIGHT - self.height
        self.dy = -self.dy
        sounds["wall_hit"]:play()
    end
end

function Ball:score()
    if self.x + self.width <= 0 then
        paddle2.score = paddle2.score + 1
        paddle1.serving = true
        self:reset(100)
        sounds["score"]:play()
        gameState:setServe()
    elseif self.x >= VIRTUAL_WIDTH then
        paddle1.score = paddle1.score + 1
        paddle2.serving = true
        paddle2.speed = paddle2.speed + 7
        self:reset(-100)
        sounds["score"]:play()
        gameState:setServe()
    end
end

function Ball:reset(dx)
    self.x     = CENTER_WIDTH - 2
    self.y     = CENTER_HEIGHT - 2
    self.dx    = dx
    self.dy    = math.random(-50, 50)
    self.speed = 1
end
