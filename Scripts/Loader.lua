--// AevnWare Loader.
--// Dog little kids on a lego game -Elliot
--// Join us: discord.gg/umPbSwgRM5


--// game list, with place id's so we can find stuff. I remade this loader so MANY times.
local gameList = {
	[8832438757] = "https://AevnWare.github.io/Scripts/Games/PVP-Sword-Fighting.lua", -- PVP Sword Fighting
	[9377953133] = "https://AevnWare.github.io/Scripts/Games/PVP-Sword-Fighting.lua", -- Mobile Sword Fight (A different script will be made for this game, so You can do more.)
	[189707] = "https://AevnWare.github.io/Scripts/Games/Natural-Disaster-Survival.lua", -- Natural Disaster Survival
}

local BetaList = {
	["Universal"] = "https://AevnWare.github.io/Scripts/Scripts/Universal.lua", -- This is where like, all the testing features go, This requires manual loading.
	[0] = "https://AevnWare.github.io/Scripts/Games/Mobile-Sword-Fight.lua", -- Im currently working on this, an update will be pushed for this.
}

--// its in the name dumbfo
local gameFound = false

--// Just loops, no need to explain honestly
for placeId, scriptUrl in pairs(gameList and _G.UseExper ~= true or BetaList) do
	if game.PlaceId == placeId then
		local yippee, bruh = pcall(function()
			loadstring(game:HttpGet(scriptUrl))()
		end)

		if yippee then
			gameFound = true
			break
		else
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "AevnWare",
				Text = "report this to a Dev or Elliot",
				Duration = 5,
				Icon = "http://www.roblox.com/asset/?id=13321880274",
			})
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "AevnWare",
				Text = "I have fallen and cant get back up, Error: " .. bruh,
				Duration = 15,
				Icon = "http://www.roblox.com/asset/?id=13321880274",
			})
			gameFound = true
			break
		end
	end
end

--// Notify if no game was found.
if not gameFound then
	--[[game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "AevnWare",
		Text = "No supported game found! DM a dev or Elliot if this is a mistake.",
		Duration = 10,
		Icon = "http://www.roblox.com/asset/?id=13321880274",
	})]]
	loadstring(game:HttpGet(BetaList["Universal"]))()
end
