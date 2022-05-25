require("input")
local fluidsynth = require('fluidsynth')

fluidsynth:init()
fluidsynth:load('./sf2/Synensmb.sf2')
fluidsynth:set('midi.autoconnect', 1)

function love.load(args)
end

function love.update(dt)
end

function love.draw()
end

function love.quit()
  fluidsynth:close()
end