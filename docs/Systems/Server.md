> **This thing is very boring If you don't like it go to other item**

## Functions

### HourToSecond

```
local function HourToSecond(hour)
    return 3600*hour
end
```

A function to change hour to second

4 hour to 14400

### Format

```lua
local function Format(sec)
    return os.date("%I:%M %p %m/%d/%y",sec)
end
```

Format the unix timestamp to a human reading

USA Format

### updateWord

```lua
local function updateWord()
    local randomWord = Words[math.random(1,#Words)]

    print(typeof(randomWord))
    warn("Your new word:",randomWord)
    WordData:SetAsync("WORD",tostring(randomWord))
end
```

randomWord = A random item in the list of Word

By geting a random number between 1 and the lenth of list

I don't feel like updating the server
