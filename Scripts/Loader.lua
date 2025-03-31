--// Eluvium Loader.
--// Get better at games, I would say -Echelon
--// Join us: discord.gg/umPbSwgRM5

--// game list, with place id's so we can find stuff. I remade this loader so MANY times.
local gameList = {
	[8832438757] = "https://Eluvium-gg.github.io/Scripts/Games/PVP-Sword-Fighting.lua", -- PVP Sword Fighting
	[9377953133] = "https://Eluvium-gg.github.io/Scripts/Games/PVP-Sword-Fighting.lua", -- Mobile Sword Fight
	[189707] = "https://Eluvium-gg.github.io/Scripts/Games/Natural-Disaster-Survival.lua", -- Natural Disaster Survival
}

--// its in the name dumbfo
local gameFound = false

--// Just loops, no need to explain honestly
for placeId, scriptUrl in pairs(gameList) do
	if game.PlaceId == placeId then
		local yippee, bruh = pcall(function()
			loadstring(game:HttpGet(scriptUrl))()
		end)

		if yippee then
			gameFound = true
			break
		else
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Eluvium",
				Text = "report this to a Dev or Echelon",
				Duration = 5,
				Icon = "http://www.roblox.com/asset/?id=13321880274",
			})
			game:GetService("StarterGui"):SetCore("SendNotification", {
				Title = "Eluvium",
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
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Eluvium",
		Text = "No supported game found! DM a dev or Echelon if this is a mistake.",
		Duration = 10,
		Icon = "http://www.roblox.com/asset/?id=13321880274",
	})
end
