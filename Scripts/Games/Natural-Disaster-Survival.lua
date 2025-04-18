local lib
local Http
local Base64Lib

_G.Eluvium = true

if game["Run Service"]:IsStudio() then
	lib = require(game.ReplicatedStorage:WaitForChild("UIModule"))
	Base64Lib = require(game.ReplicatedStorage:WaitForChild("Base64"))
	Http = require(game.ReplicatedStorage:WaitForChild("Http"))
else
	lib = loadstring(game:HttpGet("https://eluvium-gg.github.io/Scripts/Library.lua"))()
	Http = loadstring(game:HttpGet("https://eluvium-gg.github.io/Scripts/Http.lua"))()
	Base64Lib = loadstring(game:HttpGet("https://eluvium-gg.github.io/Scripts/Base64.lua"))()
end
local LastPosition = CFrame.new(0,0,0)
local Plr = game.Players.LocalPlayer
local Character = Plr.Character or Plr.CharacterAdded:Wait()


--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// Create the main window
local Window = lib:Window("Eluvium | Version 0.1.0 Alpha", Color3.fromRGB(255, 245, 165), Enum.KeyCode.RightControl)

--// Var's
local InfinityJump = false
local NoFall = false
local Legit = false


--// Other Tasks

task.spawn(function()
	Plr.CharacterAdded:Connect(function(Model)
		Character = Model
	end)
end)

--// Create main tabs
local HomeTab = Window:Tab("Home")
local LegitTab = Window:Tab("Cheats")
local SettingsTab = Window:Tab("Settings")
local CustomizationTab = Window:Tab("UI Customization")

--// Home Tab Features (General Information)
HomeTab:Label("⚠️ Disclaimer: Use at your own risk!")
HomeTab:Label("🖥️ Made by The Eluvium Team")
HomeTab:Label("Welcome to Eluvium, " .. game.Players.LocalPlayer.DisplayName .. "!")
HomeTab:Label("Local ID: " .. Base64Lib.encode(game.Players.LocalPlayer.Name))
HomeTab:Label("Your Local ID, Is for Verifying.")
HomeTab:Label("📜 Current Script: Natural Disaster Survival")
HomeTab:Label("📅 Last Updated: April 17 2025")
HomeTab:Label("Discord: .gg/YMqQD4EPYd")
HomeTab:Label("TIP: Press 'Right Control' to toggle UI.")

--// Legit Tab Features (Balanced Cheats)

LegitTab:Toggle("Infinity Jump", false, function(Value)
	InfinityJump = Value
end)

LegitTab:Toggle("NoFall", false, function(Value)
	NoFall = Value
end)
--// Settings Tab (User Preferences)

SettingsTab:Toggle("Legit Mode", false, function(Value)
	Legit = Value
end)
SettingsTab:Label("NoFall limit fall damage in legit mode")

--// UI Customization Tab

CustomizationTab:Colorpicker("Select UI Color", Color3.fromRGB(255, 245, 165), function(Value)
	lib:ChangePresetColor(Color3.fromRGB(Value.R * 255, Value.G * 255, Value.B * 255))
end)


--// Notification to indicate the UI has loaded
lib:Notification("UI Loaded", "Eluvium is ready to use. Enjoy!", "Success")

local IJ = Instance.new("Part")
IJ.Transparency = 1
IJ.Anchored = true
IJ.Size = Vector3.new(0.5,0.5,0.5)

game["Run Service"].Heartbeat:Connect(function()
	if NoFall then
		if Character.HumanoidRootPart.Velocity.Y < -40 and Legit ~= true then
			Character.HumanoidRootPart.Velocity = Vector3.new(Character.HumanoidRootPart.Velocity.X,-40,Character.HumanoidRootPart.Velocity.Z)
		elseif Character.HumanoidRootPart.Velocity.Y < -70 and Legit ~= false then
			Character.HumanoidRootPart.Velocity = Vector3.new(Character.HumanoidRootPart.Velocity.X,-70,Character.HumanoidRootPart.Velocity.Z)
		end
	end
	if InfinityJump then
		if Character then
			if Character:FindFirstChildOfClass("Humanoid") then
				if Character:FindFirstChildOfClass("Humanoid").Jump == true then
					IJ.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0)
					IJ.Parent = workspace
				else
					IJ.Parent = nil
				end
			end
		end
	end
end)
