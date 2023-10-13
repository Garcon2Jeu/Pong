require "App"

function love.load()
    app = App(true)

    paddle1 = Paddle(10, 10, 1)
    paddle2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 2)
end

function love.update(dt)
    paddle1:update(dt)
    paddle2:update(dt)
end

function love.draw(dt)
    Push:apply("start")

    app:drawBackground()

    paddle1:draw()
    paddle2:draw()

    love.graphics.print(tostring(paddle1.y), 50, 25)
    love.graphics.print(tostring(paddle1.dy), 50, 50)

    Push:apply("end")
end

function love.keypressed(key)
    app:quit(key)
end
