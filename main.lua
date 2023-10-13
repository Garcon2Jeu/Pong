require "App"

function love.load()
    app = App(true)
end

function love.update()
end

function love.draw()
    love.graphics.setFont(smallFont)
    love.graphics.print("hello world", 0, 0)
end
