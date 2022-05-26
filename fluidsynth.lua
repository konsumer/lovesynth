-- manage fluidsynth in path

local socket = require("socket")

local fluidsynth = {}

-- TODO: do midi splits: https://www.fluidsynth.org/api/MIDIRouter.html

local tcp

function fluidsynth:init()
  local t = love.thread.newThread( [[
    local command = ...
    os.execute(command)
  ]])
  t:start('fluidsynth -q -s -g 1 -d -p lovesynth -o "midi.autoconnect=1" -o "shell.port=31337" ')
  tcp = assert(socket.tcp())
end

function fluidsynth:cmd(c)
  print('COMMAND: ' .. c)
  tcp:connect('localhost', 31337)
  tcp:send(c .. '\n')
  tcp:close()
end

function fluidsynth:close()
  tcp:close()
  io.popen('killall -9 fluidsynth')
end

return fluidsynth