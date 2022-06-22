> **This thing is very boring If you don't like it go to other item**

So the game is build with 3 function that is needed for the game to work

---

## Update row

```lua
local function updateRow(row,value,index)
    if index > 5 then
      --warn("Out of space")
    else
        local word = IntToWord(index)
        local cell = row:FindFirstChild(word)
        if cell then
            cell.TextLabel.Text = string.upper(value)
          else
            warn("cell not found")
        end
    end
end
```

IntToWord is module that change a number to string format

**You know what a string is right?**

Cells name like One,Two and more

word = 1 to One
FindFirstChild find a item name with the word var

Change the text by cell.TextLabel.Text = string.upper(value)

## IsVaildKey

```lua
local function IsValidKey(key)
  key = tostring(key)
  key = string.upper(key)
  local result = nil
  pcall(function()
    result = Enum.KeyCode[key]
  end)
  return result
end
```

This is a function to check if the Enum.KeyCode was letter

Thats all
