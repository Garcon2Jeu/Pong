require "App"

function love.load()
    app = App(true)
    gameState = GameState()

    paddle1 = Paddle(10, 10, 1)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 2)
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

    Push:apply("end")
end

function love.keypressed(key)
    gameState:setPlay(key)
    app:quit(key)
    app:reset(key)
end

-- love.graphics.print(tostring(paddle1.y), 50, 25)
-- love.graphics.print(tostring(paddle1.dy), 50, 50)

-- love.graphics.print(tostring(app:hasCollided(paddle1, ball)), 50, 50)
