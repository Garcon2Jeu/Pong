require "App"

function love.load()
    app = App(true)

    paddle1 = Paddle(10, 10, 1)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 2)

    ball = Ball()
end

function love.update(dt)
    paddle1:update(dt)
    paddle2:update(dt)
    ball:update(dt)
end

function love.draw(dt)
    Push:apply("start")

    app:drawBackground()

    paddle1:draw()
    paddle2:draw()
    ball:draw()

    -- love.graphics.print(tostring(paddle1.y), 50, 25)
    -- love.graphics.print(tostring(paddle1.dy), 50, 50)

    -- love.graphics.print(tostring(app:hasCollided(paddle1, ball)), 50, 50)

    Push:apply("end")
end

function love.keypressed(key)
    app:quit(key)
    ball:reset(key)
end
