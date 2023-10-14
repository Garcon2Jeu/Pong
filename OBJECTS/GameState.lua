GameState = Class {}

function GameState:init()
    self.start        = true
    self.serve        = false
    self.play         = false
    self.over         = false
    self.winningScore = 10
    self.winner       = null
end

function GameState:update()
    if paddle1.score == self.winningScore then
        self.winner = "1"
        self:setOver()
    elseif paddle2.score == self.winningScore then
        self.winner = "2"
        self:setOver()
    end
end

function GameState:setServe()
    self.start = false
    self.serve = true
    self.play  = false
    self.over  = false
end

function GameState:setPlay(key)
    if key == "space" then
        self.start = false
        self.serve = false
        self.play  = true
        self.over  = false
    end
end

function GameState:setOver()
    self.start = false
    self.serve = false
    self.play  = false
    self.over  = true
end

function GameState:draw()
    if self.start then
        love.graphics.printf("Start...", 0, 30, VIRTUAL_WIDTH, "center")
    elseif self.serve then
        serving = paddle1.serving and "P1 serving..." or "P2 serving..."
        love.graphics.printf(serving, 0, 30, VIRTUAL_WIDTH, "center")
    elseif self.play then
        love.graphics.printf("Play", 0, 30, VIRTUAL_WIDTH, "center")
    elseif self.over then
        love.graphics.printf("P" .. self.winner .. " wins!", 0, 30, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press 'Enter' to start again", 0, 50, VIRTUAL_WIDTH, 'center')
    end
end
