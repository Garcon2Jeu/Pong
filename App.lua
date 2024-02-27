Class = require "LIBRARIES.class"
Push = require "LIBRARIES.push"

require "OBJECTS.GameState"
require "OBJECTS.Paddle"
require "OBJECTS.Ball"

WINDOW_WIDTH   = 1280
WINDOW_HEIGHT  = 720

VIRTUAL_WIDTH  = 432
VIRTUAL_HEIGHT = 243

CENTER_WIDTH   = VIRTUAL_WIDTH / 2
CENTER_HEIGHT  = VIRTUAL_HEIGHT / 2


App = Class {}

function App:init(dev)
    self.dev = dev or false

    love.window.setTitle("PONG - Project")
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    math.randomseed(os.time())

    smallFont = love.graphics.newFont("ASSETS/font.ttf", 8)
    scoreFont = love.graphics.newFont("ASSETS/font.ttf", 32)

    sounds = {
        ["paddle_hit"] = love.audio.newSource("ASSETS/SOUNDS/paddle_hit.wav", "static"),
        ["wall_hit"] = love.audio.newSource("ASSETS/SOUNDS/wall_hit.wav", "static"),
        ["score"] = love.audio.newSource("ASSETS/SOUNDS/score.wav", "static")
    }
end

function App:drawBackground()
    love.graphics.clear(40 / 255, 45 / 255, 52 / 255, 255 / 255)
end

function App:quit(key)
    if key == "escape" then
        love.event.quit()
    end
end

function App:reset(key)
    if key == "return" then
        love.load()
    end
end

function App:hasCollided(object1, object2)
    if object1.x > object2.x + object2.width or
        object2.x > object1.x + object1.width then
        return false
    end

    if object1.y > object2.y + object2.height or
        object2.y > object1.y + object1.height then
        return false
    end

    return true
end

function App:drawDevMode()
    if not self.dev then
        return
    end

    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)

    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 75, 25)

    love.graphics.setColor(255, 255, 0, 255)
    -- Ball stats
    love.graphics.printf("ball.x  = " .. tostring(math.floor(ball.x)), CENTER_WIDTH - 25, 50, CENTER_WIDTH + 50, "left")
    love.graphics.printf("ball.y  = " .. tostring(math.floor(ball.y)), CENTER_WIDTH - 25, 60, CENTER_WIDTH + 50, "left")
    love.graphics.printf("ball.dx = " .. tostring(math.floor(ball.dx)), CENTER_WIDTH - 25, 70, CENTER_WIDTH + 50, "left")
    love.graphics.printf("ball.dy = " .. tostring(math.floor(ball.dy)), CENTER_WIDTH - 25, 80, CENTER_WIDTH + 50, "left")
    love.graphics.printf("ball.speed = " .. tostring(math.floor(ball.speed)), CENTER_WIDTH - 25, 90, CENTER_WIDTH + 50,
        "left")

    -- Player 1 stats
    love.graphics.print("P1.x = " .. tostring(math.floor(paddle1.x)), 75, 50)
    love.graphics.print("P1.y = " .. tostring(math.floor(paddle1.y)), 75, 60)
    love.graphics.print("P1.dy = " .. tostring(math.floor(paddle1.dy)), 75, 80)
    love.graphics.print("P1.speed = " .. tostring(math.floor(paddle1.speed)), 75, 90)

    -- Player 2 stats
    love.graphics.print("P2.x = " .. tostring(math.floor(paddle2.x)), VIRTUAL_WIDTH - 150, 50)
    love.graphics.print("P2.y = " .. tostring(math.floor(paddle2.y)), VIRTUAL_WIDTH - 150, 60)
    love.graphics.print("P2.dy = " .. tostring(math.floor(paddle2.dy)), VIRTUAL_WIDTH - 150, 80)
    love.graphics.print("P2.speed = " .. tostring(math.floor(paddle2.speed)), VIRTUAL_WIDTH - 150, 90)
end
