Class = require "LIBRARIES.class"
Push = require "LIBRARIES.push"

WINDOW_WIDTH = 1420
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243


App = Class {}

function App:init(dev)
    self.dev = dev or false

    love.window.setTitle("PONG - Project")
    love.graphics.setDefaultFilter("nearest", "nearest")
    Push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = false
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
