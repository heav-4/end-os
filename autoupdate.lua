local url = "https://raw.githubusercontent.com/heav-4/end-os/main/"

function get(filepath)
  local fd,err = http.get(url..filepath.."?apioform="..math.random(1,123489923))
  if not fd then print(err) sleep(3) os.reboot() end
  local data = fd:readAll()
  fd:close()
  return data
end

function w(filepath,info)
  local fd = fs.open(filepath,"w")
  fd.write(info)
  fd:close()
end

function r(filepath)
  local fd = fs.open(filepath,"r")
  if not fd then return "" end
  local info = fd:readAll()
  fd:close()
  return info
end

local files = {}
local filestr = get("files")

local res = ""
for i=1,#filestr do
  local c = filestr:sub(i,i)
  if c == "-" then
    table.insert(files,res)
    res = ""
  elseif c == "#" then
    fs.makeDir(res)
    res = ""
  else
    res = res .. c
  end
end

local filefuncs = {}
local upd = false

for i,v in ipairs(files) do
  table.insert(filefuncs,function()
    local curtxt = r(v)
    local newtxt = get(v)
    if curtxt == newtxt then
      print("no updates for "..v)
    else
      w(v,newtxt)
      print("updated "..v)
      upd = true
    end
  end)
end
  
parallel.waitForAll(unpack(filefuncs))

if upd then os.reboot() end
