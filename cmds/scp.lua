print("SCP database accessed.")
print("Enter an SCP number.")
parallel.waitForAny(function()
    while true do
      local input = io.read()
      if input:sub(1,4) == "SCP-" then
        print("An SCP *number*, not an SCP designation.")
      else
        if input == "173" then
          print("A fairly dangerous SCP.")
          print("Said to be 'the deadlies [sic] apioarachnocognitoteleoinfohazard ever' by some.")
        elseif input == "055" or input == "55" then
          print("...what? We don't have an SCP-055.")
        elseif input == "7812" then
          print("I don't know. Cloud thing.")
        else
          print("[REDACTED]")
        end
      end
    end
  end,
  function()
    os.pullEvent("terminate")
  end)
print("Bye, O5-269837³²½[½³.")
