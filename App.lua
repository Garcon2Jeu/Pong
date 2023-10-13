Class = require "LIBRARIES.class"
Push = require "LIBRARIES.push"

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
    smallFont = love.graphics.newFont("ASSETS/font.ttf", 32)

    sounds = {
        ["paddle_hit"] = love.audio.newSource("ASSETS/SOUNDS/paddle_hit.wav", "static"),
        ["wall_hit"] = love.audio.newSource("ASSETS/SOUNDS/paddle_hit.wav", "static"),
        ["score"] = love.audio.newSource("ASSETS/SOUNDS/paddle_hit.wav", "static")
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

function App:hasCollided(object1, object2)
    if object1.x > object2.x + object2.width or object2.x > object1.x + object1.width then
        return false
    end

    if object1.y > object2.y + object2.height or object2.y > object1.y + object1.height then
        return false
    end

    return true
end
