os.pullEvent = os.pullEventRaw

local stc = term.setTextColor
local iscolor = term.isColor()
local fakedout = false
term.setTextColor = function(c)
    if iscolor then return stc(c) end  
end

local cmd = {}

function cls() term.setCursorPos(1,1) term.clear() end

cls()

print('"""Autoupdating"""....')
print("(replacing all files with new ones)")

local f = http.get("https://raw.githubusercontent.com/heav-4/end-os/main/autoupdate.lua")

if not f then os.reboot() end

local data = f:readAll()
f:close()

f = fs.open("autoupdate.lua","w")
f.write(data)
f:close()

shell.run("autoupdate.lua")

cls()

print("end operating system version version^2")

while true do
    parallel.waitForAny(function()
        while true do
            term.write("> ")
            local input = io.read()
            if input == "help" then
                print("What for?")
            else
                print(("?"):rep(math.random(1,10)))
            end
        end
    end,function()
        os.pullEventRaw("terminate")
       if not fakedout then return end
    end)
    if not fakedout then
        fakedout = true
        term.setTextColor(colors.red)
        print("Terminated")
        term.setTextColor(colors.yellow)
        term.write("> ")
        term.setTextColor(colors.white)
        io.read()
        print("\nActually, no.")
    end
end
