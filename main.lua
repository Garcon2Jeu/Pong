require "App"

function love.load()
    app = App()
    gameState = GameState()

    paddle1 = Paddle(10, 10, 1)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, "AI")
    ball = Ball()
end

function love.update(dt)
    gameState:update()

    paddle1:update(dt)
    paddle2:update(dt)
    ball:update(dt)
end

function love.draw(dt)
    Push:apply("start")

    app:drawBackground()

    love.graphics.setFont(smallFont)
    gameState:draw()

    love.graphics.setFont(scoreFont)
    paddle1:drawScore()
    paddle2:drawScore()

    paddle1:draw()
    paddle2:draw()
    ball:draw()

    app:drawDevMode()

    Push:apply("end")
end

function love.keypressed(key)
    gameState:setPlay(key)
    app:quit(key)
    app:reset(key)
end
