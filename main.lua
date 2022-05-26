require("input")
local fluidsynth = require('fluidsynth')

local files = love.filesystem.getDirectoryItems('sf2')
local currentFile = 1

fluidsynth:init(string.format('sf2/%s', files[currentFile]))

function love.load(args)
end

function love.update(dt)
end

function love.draw()
  love.graphics.printf(files[currentFile], 10, 10, 460, 'center')
end

function input_pressed(button)
  local change = false
  if button == 'a' then
    fluidsynth:noteon(currentFile, 60, 127)
  end
  if button == 'b' then
    fluidsynth:noteon(currentFile, 62, 127)
  end

  if button == 'up' then
    currentFile = currentFile - 1
    change = true
  end

  if button == 'down' then
    currentFile = currentFile + 1
    change = true
  end

  if currentFile > #files then
    currentFile = 1
  end
  if currentFile < 1 then
    currentFile = #files
  end

  if change then
    fluidsynth:load(string.format('sf2/%s', files[currentFile]))
    fluidsynth:cmd(string.format('inst %d', currentFile))
  end
end

function input_released(button)
  if button == 'a' then
    fluidsynth:noteoff(currentFile, 60)
  end
  if button == 'b' then
    fluidsynth:noteoff(currentFile, 62)
  end
end

function love.quit()
  fluidsynth:close()
end