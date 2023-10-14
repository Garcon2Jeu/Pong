Paddle = Class {}

function Paddle:init(x, y, player)
    self.x       = x
    self.y       = y
    self.dy      = 0
    self.width   = 4
    self.height  = 20
    self.player  = player
    self.score   = 0
    self.serving = false
    self.speed   = self.player == "AI" and 50 or 300
end

function Paddle:update(dt)
    self:move(dt)
    self:keepWithinScreen(dt)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Paddle:drawScore()
    if self.player == 1 then
        love.graphics.print(self.score, CENTER_WIDTH - 50, 20)
    else
        love.graphics.print(self.score, CENTER_WIDTH + 30, 20)
    end
end

function Paddle:move(dt)
    self.dy = 0

    if love.keyboard.isDown("s") and self.player == 1 or
        love.keyboard.isDown("down") and self.player == 2 then
        self.dy = self.dy + self.speed * dt
    end

    if love.keyboard.isDown("z") and self.player == 1 or
        love.keyboard.isDown("up") and self.player == 2 then
        self.dy = self.dy - self.speed * dt
    end

    if self.player == "AI" and gameState.play then
        self.dy = self:AI(dt)
    end

    self.y = self.y + self.dy
end

function Paddle:keepWithinScreen(dt)
    self.y = self.dy < 0 and
        math.max(0, self.y)
        or
        math.min(self.y, VIRTUAL_HEIGHT - self.height)
end

function Paddle:AI(dt)
    return self.y + self.height / 2 > ball.y and
        self.dy - self.speed * dt
        or
        self.dy + self.speed * dt
end
