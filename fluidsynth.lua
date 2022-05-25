-- manage fluidsynth in path

local fluidsynth = {}

-- TODO: do midi splits: https://www.fluidsynth.org/api/MIDIRouter.html



function fluidsynth:init()
  fluidsynth.handle = io.popen('fluidsynth -s -g 3 -d -p lovesynth  -m coremidi', 'r+')
  fluidsynth.count = 0
  -- todo: translate options-table for init
end

function fluidsynth:cmd(c)
  fluidsynth.handle:write(table.concat(c, ' ') .. '\n')
end

function fluidsynth:close()
  fluidsynth:cmd({'quit'})
  fluidsynth.handle:close()
end

function fluidsynth:noteon(channel, key, velocity)
  fluidsynth:cmd({'noteon', channel, key, velocity})
end

function fluidsynth:noteoff(channel, key)
  fluidsynth:cmd({'noteoff', channel, key })
end

function fluidsynth:load(filename)
  fluidsynth.count = fluidsynth.count + 1
  fluidsynth:cmd({'load', filename })
end

function fluidsynth:set(name, value)
  fluidsynth:cmd({'set', name, value })
end


return fluidsynth