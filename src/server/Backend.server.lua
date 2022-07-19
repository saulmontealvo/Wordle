-- Vars
local SendData = game.ReplicatedStorage.SentData
local DataStoreService = game:GetService("DataStoreService")
local Data = DataStoreService:GetDataStore("ubnaiudhbiusahdiu")
local WordData = DataStoreService:GetDataStore("21323123")
local TodayWordle
local Words = require(game.ServerScriptService.Words)
-- Config
local list = {}
local Debug = true
list.HourBetweenWord = 4
-- Function
local function HourToSecond(hour)
    return 3600*hour
end
local function Format(sec)
    return os.date("%I:%M %p %m/%d/%y",sec)
end
local function updateWord()
    local randomWord = Words[math.random(1,#Words)]

    print(typeof(randomWord))
    warn("Your new word:",randomWord)
    WordData:SetAsync("WORD",tostring(randomWord))
    TodayWordle = randomWord
end
local function VerifyWord(Word)
	local url = "https://api.dictionaryapi.dev/api/v2/entries/en/"..Word
	local success,errormessage = pcall(function()
		local response = http:GetAsync(url)
	end)
	if success then
		
		return true
	else
		
		return false
	end
	
end
-- Check when the server innit on a game
local LastWordle = Data:GetAsync("DOG")

if LastWordle == nil then
    local Init_Time =os.time()+HourToSecond(list.HourBetweenWord)
    if Debug then
        warn("Next wordle until",Format(Init_Time))
    end
    Data:SetAsync("DOG",Init_Time)
    LastWordle = Data:GetAsync("DOG")
    updateWord()
else
    --warn("Next Word:",Format(LastWordle))
end

if Debug then
    warn("Word:",tostring(WordData:GetAsync("WORD")))
end

local updateFunction = coroutine.create(function()
    while true do
        task.wait(1)
        if os.time() >= LastWordle then
            warn("Time for a new wordle")
            local New_Time = os.time()+HourToSecond(list.HourBetweenWord)
            if Debug then
                warn("Next Word",Format(New_Time))
            end
            Data:SetAsync("DOG",New_Time)
            LastWordle = Data:GetAsync("DOG")
            updateWord()
        else
            --warn("Time until new wordle,",LastWordle-os.time())
        end
    end
end)

task.wait(3)
coroutine.resume(updateFunction)

SendData.OnServerInvoke = function(player:Player,index:number,letter:string)
    for i,v in pairs(string.split(TodayWordle,"")) do
        print(i,v)
    end
end