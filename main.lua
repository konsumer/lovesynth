require("input")
local fluidsynth = require('fluidsynth')

fluidsynth:init()
love.timer.sleep(1)
fluidsynth:cmd('load ./sf2/Synensmb.sf2')

function love.load(args)
end

function love.update(dt)
end

function love.draw()
end

function input_released(button)
  if button == 'a' then
    fluidsynth:cmd('noteoff 1 60')
  end
  if button == 'b' then
    fluidsynth:cmd('noteoff 1 62')
  end
end

function input_pressed(button)
  if button == 'a' then
    fluidsynth:cmd('noteon 1 60 127')
  end
  if button == 'b' then
    fluidsynth:cmd('noteon 1 62 127')
  end
end

function love.quit()
  fluidsynth:close()
end