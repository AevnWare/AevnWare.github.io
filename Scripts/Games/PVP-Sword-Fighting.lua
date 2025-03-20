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
	Http = loadstring(game:HttpGet("https://eluvium-gg.github.io/Scripts/Httplua"))()
	Base64Lib = loadstring(game:HttpGet("https://eluvium-gg.github.io/Scripts/Base64.lua"))()
end
local LastPosition = CFrame.new(0,0,0)
local Plr = game.Players.LocalPlayer::Player
local Character = Plr.Character or Plr.CharacterAdded:Wait()


--// Services
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

--// Create the main window
local Window = lib:Window("Eluvium | Version 0.1.0 Alpha", Color3.fromRGB(255, 245, 165), Enum.KeyCode.RightControl)

--// Var's
local InfinityJump = false
local AntiBan = true
local RespawnAtDeathPos = false
local KillAura = false
local SpinBot = false
local AllowNpc = true
local LegitKillAura = false
local Reach = 10
local BHOP = false


--// Other Tasks

task.spawn(function()
	Character.Humanoid.Died:Once(function()
		LastPosition = Character.HumanoidRootPart.CFrame
	end)
	Plr.CharacterAdded:Connect(function(Model)
		Character = Model
		Model.Humanoid.Died:Once(function()
			LastPosition = Model.HumanoidRootPart.CFrame
		end)
		if RespawnAtDeathPos then
			game.TweenService:Create(Model:WaitForChild("HumanoidRootPart"),TweenInfo.new(1,Enum.EasingStyle.Linear),{CFrame = LastPosition}):Play()
		end
	end)
end)

--// Create main tabs
local HomeTab = Window:Tab("🏠 Home")
local LegitTab = Window:Tab("🤫 Legit")
local RageTab = Window:Tab("🔥 Overpowered")
local SettingsTab = Window:Tab("⚙ Settings")
local CustomizationTab = Window:Tab("📄 UI Customization")
local CharacterCustomizationTab = Window:Tab("🎩 Char Customization")

--// Home Tab Features (General Information)
HomeTab:Label("⚠️ Disclaimer: Use at your own risk!")
HomeTab:Label("🖥️ Made by The Eluvium Team")
HomeTab:Label("Welcome to Eluvium, " .. game.Players.LocalPlayer.DisplayName .. "!")
HomeTab:Label("Local ID: " .. Base64Lib.encode(game.Players.LocalPlayer.Name))
HomeTab:Label("Your Local ID, Is for Verifying.")
HomeTab:Label("Dominate sword fights effortlessly with Eluvium.")
HomeTab:Label("🛠️ Version: 0.1.0 Alpha")
HomeTab:Label("📜 Current Script: PVP Sword Fighting")
HomeTab:Label("📅 Last Updated: March 19 2025")
HomeTab:Label("Discord: .gg/YMqQD4EPYd")
HomeTab:Label("TIP: Press 'Right Control' to toggle UI.")

--// Legit Tab Features (Balanced Cheats)

LegitTab:Toggle("Infinity Jump", false, function(Value)
	InfinityJump = Value
end)
LegitTab:Toggle("Legit Kill Aura", false, function(Value)
	LegitKillAura = Value
end)
LegitTab:Toggle("Bunny Hopping [Speed Boost]", false, function(Value)
	BHOP = Value
	if Value == true then
		local rootPart = Character.HumanoidRootPart
		rootPart.Velocity = Vector3.new(0, 47, 0)
	end
end)

--// Rage Tab Features (Overpowered Cheats)

RageTab:Toggle("Kill Aura", false, function(Value)
	KillAura = Value
end)

RageTab:Toggle("Spinbot", false, function(Value)
	SpinBot = Value
end)

--// Settings Tab (User Preferences)

SettingsTab:Toggle("Allow Cheats to Affect NPCs", true, function(Value)
	AllowNpc = Value
end)

SettingsTab:Toggle("Anti-Ban Protection", true, function(Value)
	AntiBan = Value
end)

SettingsTab:Toggle("Respawn at Death Position", false, function(Value)
	RespawnAtDeathPos = Value
end)

SettingsTab:Slider("Kill Aura Distance",5,25,10,function(Value)
	Reach = Value
end)

--// UI Customization Tab

local killaurapart = Instance.new("Part")
local LKApart = Instance.new("Part")

CustomizationTab:Colorpicker("Select UI Color", Color3.fromRGB(255, 245, 165), function(Value)
	lib:ChangePresetColor(Color3.fromRGB(Value.R * 255, Value.G * 255, Value.B * 255))
	killaurapart.Color = Value
end)

--// Character Customization Tab

local SelectedGlowing = false

CharacterCustomizationTab:Toggle("Toggle ForceField", false, function(Value)
	SelectedGlowing = Value
end)

--// Notification to indicate the UI has loaded
lib:Notification("UI Loaded", "Eluvium is ready to use. Enjoy!", "Success")

killaurapart.Shape = Enum.PartType.Cylinder
killaurapart.Material = Enum.Material.Neon
killaurapart.Color = Color3.fromRGB(255, 245, 165)
killaurapart.Transparency = 0.85
killaurapart.Anchored = true
killaurapart.CanCollide = false

LKApart.Shape = Enum.PartType.Cylinder
LKApart.Material = Enum.Material.Neon
LKApart.Color = Color3.fromRGB(255, 245, 165)
LKApart.Transparency = 0.85
LKApart.Anchored = true
LKApart.CanCollide = false

local IJ = Instance.new("Part")
IJ.Transparency = 1
IJ.Anchored = true
IJ.Size = Vector3.new(0.5,0.5,0.5)

RunService.Heartbeat:Connect(function(D)
	if SpinBot then
		game.Players.LocalPlayer.Character.Humanoid.AutoRotate = false
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0,math.rad((360 * 5) * D),0)
	else
		game.Players.LocalPlayer.Character.Humanoid.AutoRotate = true
	end
	killaurapart.Size = Vector3.new(0.25,Reach * 2,Reach * 2)
	if KillAura then
		local Sword = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")::Tool
		local Handle
		if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and string.match(string.lower(game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name),"sword") then
			Handle = Sword:FindFirstChild("Handle")
			Handle.Material = Enum.Material.ForceField
			Handle.Color = killaurapart.Color
			Handle:BreakJoints()
		else
			game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if string.match(string.lower(v.Name), "sword") then
					v.Parent = game.Players.LocalPlayer.Character
					break
				end
			end
			if Sword then
				Handle = Sword:FindFirstChild("Handle")
				Handle.Material = Enum.Material.ForceField
				Handle.Color = killaurapart.Color
				Handle:BreakJoints()
			end
		end
		if Handle then
			Handle.AssemblyLinearVelocity = Vector3.new(math.random(-120,120),-20,math.random(-120,120))
		else
			return
		end
		killaurapart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0) * CFrame.Angles(0,0,math.rad(90))
		killaurapart.Parent = workspace
		local Attacking = false
		if AllowNpc then
			for i, v in pairs(game.Workspace:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Torso") and v ~= game.Players.LocalPlayer.Character then
					local humanoid = v:FindFirstChildOfClass("Humanoid")
					local head = v:FindFirstChild("Head")

					local distance = (head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude

					if distance <= Reach then -- Check if within reach
						Attacking = true
						while humanoid.Health > 0.1 and (head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude <= Reach do
							Handle.CFrame = head.Parent.HumanoidRootPart.CFrame * CFrame.new(0,math.round(math.random(0,3) / 3) * 1.5,0)
							if Sword.Parent == Character then
								Sword:Activate()
								Sword:Activate()
								Sword:Activate()
								Sword:Activate()
								Sword:Activate()
							end
							if Character.Humanoid.Health < 0.1 then
								break
							end
							task.wait(1/75)
						end
						Attacking = false
					end
				end
			end
		else
			for i, v in pairs(game.Players:GetPlayers()) do
				if v ~= game.Players.LocalPlayer and v.Character then
					local head = v.Character:FindFirstChild("Head")
					local humanoid = v.Character:FindFirstChild("Humanoid")

					if head and humanoid and humanoid.Health > 0 then
						local distance = (head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude

						if distance <= Reach then -- Check if within reach
							Attacking = true
							while humanoid.Health > 0.1 and (head.Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude <= Reach do
								Handle.CFrame = head.Parent.HumanoidRootPart.CFrame * CFrame.new(0,math.round(math.random(0,3) / 3) * 1.5,0)
								if Sword.Parent == Character then
									Sword:Activate()
									Sword:Activate()
									Sword:Activate()
									Sword:Activate()
									Sword:Activate()
								end
								if Character.Humanoid.Health < 0.1 then
									break
								end
								task.wait(1/75)
							end
							Attacking = false
						end
					end
				end
			end
		end
		if Attacking ~= true then
			Handle.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,3.5 + math.sin(time()) / 2,0)
		end
	else
		killaurapart.Parent = game
	end
	if Character:FindFirstChild("Humanoid") and Character:FindFirstChild("Humanoid").Jump == true then
		if InfinityJump == true then
			IJ.Parent = workspace
			IJ.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3.5,0)
		end
	else
		IJ.Parent = game
	end
end)

RunService.Heartbeat:Connect(function(D)
	LKApart.Size = Vector3.new(0.25, Reach / 1.75 * 2, Reach / 1.75 * 2)

	if LegitKillAura then
		local Character = game.Players.LocalPlayer.Character
		local Sword = Character:FindFirstChildOfClass("Tool")
		local Handle

		if Sword and string.match(string.lower(Sword.Name), "sword") then
			Handle = Sword:FindFirstChild("Handle")
			Handle.Material = Enum.Material.ForceField
			Handle:BreakJoints()
			Handle.Color = LKApart.Color
		else
			Character.Humanoid:UnequipTools()
			for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if string.match(string.lower(v.Name), "sword") then
					v.Parent = Character
					break
				end
			end
			if Sword then
				Handle = Sword:FindFirstChild("Handle")
				Handle:BreakJoints()
				Handle.Material = Enum.Material.ForceField
				Handle.Color = LKApart.Color
			end
		end

		if Handle then
			Handle.AssemblyLinearVelocity = Vector3.new(math.random(-120,120),-20,math.random(-120,120))
		else
			return
		end

		LKApart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, 0, math.rad(90))
		LKApart.Parent = workspace
		
		local CurChar = Character
		
		local Attacking = false

		local function attackTarget(target)
			local head = target:FindFirstChild("Head")
			local humanoid = target:FindFirstChildOfClass("Humanoid")
			if head and humanoid and humanoid.Health > 0 then
				local distance = (head.Position - Character.Head.Position).Magnitude

				if distance <= Reach / 1.75 then -- Adjusted reach
					Attacking = true
					local targetCFrame = CFrame.lookAt(Character.HumanoidRootPart.Position, head.Position)
					Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame:Lerp(targetCFrame, 0.2) -- Smooth rotation

					while humanoid.Health > 0.1 and (head.Position - Character.Head.Position).Magnitude <= Reach / 1.75 do
						Handle.CFrame = head.Parent.HumanoidRootPart.CFrame
						if Sword.Parent == Character then
							Sword:Activate()
						end
						if Character.Humanoid.Health < 0.1 then
							break
						end
						task.wait(1/75)
					end
					Attacking = false
				end
			end
		end

		for i, v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character then
				attackTarget(v.Character)
			end
		end

		if AllowNpc then
			for i, v in pairs(workspace:GetChildren()) do
				if v:IsA("Model") and v:FindFirstChild("Torso") and v ~= Character then
					attackTarget(v)
				end
			end
		end

		if not Attacking then
			Handle.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(1.5, 1, 0) -- Sword at right arm
		end
	else
		LKApart.Parent = game
	end
end)
local TweenService = game:GetService("TweenService")

local SpeedBoost = 23
local TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out) -- Adjust time & style for smooth effect

RunService.Heartbeat:Connect(function()
	if BHOP then
		if Character:FindFirstChild("Humanoid") and Character:FindFirstChild("HumanoidRootPart") then
			local humanoid = Character:FindFirstChildOfClass("Humanoid")
			local rootPart = Character.HumanoidRootPart
			local currentState = humanoid:GetState()

			if currentState == Enum.HumanoidStateType.Landed then
				rootPart.Velocity = Vector3.new(humanoid.MoveDirection.X * (SpeedBoost + 55), 27, humanoid.MoveDirection.Z * (SpeedBoost + 55))
			else
				rootPart.Velocity = Vector3.new(humanoid.MoveDirection.X * (SpeedBoost), rootPart.Velocity.Y, humanoid.MoveDirection.Z * (SpeedBoost))
			end
		end
	end

	if SelectedGlowing then
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("Part") then
				v.Material = Enum.Material.ForceField
			end
		end
	else
		for i,v in pairs(Character:GetDescendants()) do
			if v:IsA("Part") then
				v.Material = Enum.Material.Plastic
			end
		end
	end
end)
