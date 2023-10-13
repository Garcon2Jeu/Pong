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
    self.speed   = 200
end

function Paddle:update(dt)
    self:move(dt)
    self:keepWithinScreen(dt)
end

function Paddle:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
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

    self.y = self.y + self.dy
end

function Paddle:keepWithinScreen(dt)
    self.y = self.dy < 0 and
        math.max(0, self.y)
        or
        math.min(self.y, VIRTUAL_HEIGHT - self.height)
end
