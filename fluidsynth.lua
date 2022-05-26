-- manage fluidsynth in path

local socket = require("socket")

local fluidsynth = {}

-- TODO: do midi splits: https://www.fluidsynth.org/api/MIDIRouter.html

local tcp = assert(socket.tcp())

-- start fluidsynth in another thread
function fluidsynth:init(file)
  local t = love.thread.newThread( [[
    local file = ...
    if file then
      os.execute(string.format('fluidsynth -q -s -g 1 -d -p lovesynth -o "midi.autoconnect=1" -o "shell.port=31337" %q', file))
    else
      os.execute('fluidsynth -q -s -g 1 -d -p lovesynth -o "midi.autoconnect=1" -o "shell.port=31337"')
    end
  ]])
  t:start(file)
end

-- send a single command over tcp
function fluidsynth:cmd(c)
  tcp:connect('localhost', 31337)
  tcp:send(c .. '\n')
  tcp:close()
end

-- send a noteon message
function fluidsynth:noteon(channel, note, velocity)
  fluidsynth:cmd(string.format('noteon %d %d %d', channel, note, velocity))
end

-- send a noteoff message
function fluidsynth:noteoff(channel, note)
  fluidsynth:cmd(string.format('noteoff %d %d', channel, note))
end

-- send a load message
function fluidsynth:load(file)
  fluidsynth:cmd(string.format('load %q', file))
end

-- close tcp & kill all copies of fluidsynth
function fluidsynth:close()
  tcp:close()
  io.popen('killall -9 fluidsynth')
end

return fluidsynth