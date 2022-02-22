print("List of things:")
local list = fs.list("/cmds")
print(table.concat(list,", "))
