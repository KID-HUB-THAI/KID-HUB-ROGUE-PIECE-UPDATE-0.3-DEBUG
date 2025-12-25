local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Window = Luna:CreateWindow({
	Name = "KID HUB", -- This Is Title Of Your Window
	Subtitle = nil, -- A Gray Subtitle next To the main title.
	LogoID = "82795327169782", -- The Asset ID of your logo. Set to nil if you do not have a logo for Luna to use.
	LoadingEnabled = true, -- Whether to enable the loading animation. Set to false if you do not want the loading screen or have your own custom one.
	LoadingTitle = "THANKS FOR USE", -- Header for loading screen
	LoadingSubtitle = "by Nebula Softworks", -- Subtitle for loading screen

	ConfigSettings = {
		RootFolder = nil, -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
		ConfigFolder = "Big Hub" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
	},

	KeySystem = false, -- As Of Beta 6, Luna Has officially Implemented A Key System!
	KeySettings = {
		Title = "IS NOT KEYLESS LOL",
		Subtitle = "KEY ",
		Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass",
		SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
		SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		Key = {"Roplox7005XD"}, -- List of keys that will be accepted by the system, please use a system like Pelican or Luarmor that provide key strings based on your HWID since putting a simple string is very easy to bypass
		SecondAction = {
			Enabled = true, -- Set to false if you do not want a second action,
			Type = "Link", -- Link / Discord.
			Parameter = "" -- If Type is Discord, then put your invite link (DO NOT PUT DISCORD.GG/). Else, put the full link of your key system here.
		}
	}
})
local Tab = Window:CreateTab({
	Name = "Tab Example",
	Icon = "view_in_ar",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

-- ===== Toggle Vars =====
getgenv().ObservationToggle = false
getgenv().MetalBatToggle = false
getgenv().YutaM1Toggle = false

-- ===== Observation =====
Tab:CreateButton({
	Name = "Observation Toggle",
	Callback = function()
		getgenv().ObservationToggle = not getgenv().ObservationToggle

		if getgenv().ObservationToggle then
			task.spawn(function()
				while getgenv().ObservationToggle do
					game.ReplicatedStorage.Remotes.Serverside:FireServer(
						"Server","Misc","Observation",1
					)
					task.wait(1)
				end
			end)
		end
	end
})
-- ========combat=========
-- ตัวแปรเก็บสถานะ เปิด / ปิด
getgenv().AttackToggle = false

local Button = Tab:CreateButton({
	Name = "Attack Toggle",
	Description = "กดเพื่อ เปิด/ปิด การโจมตี",
	Callback = function()
		-- สลับสถานะ
		AttackToggle = not AttackToggle

		if AttackToggle then
			print("Attack ON")

			-- รันโจมตีแบบวนลูป
			task.spawn(function()
				while AttackToggle do
					local args = {
						"Server",
						"Combat",
						"M1s",
						"Combat",
						1
					}

					game:GetService("ReplicatedStorage")
						:WaitForChild("Remotes")
						:WaitForChild("Serverside")
						:FireServer(unpack(args))

					task.wait(0.1) -- ปรับความเร็วการโจมตีได้
				end
			end)

		else
			print("Attack OFF")
		end
	end
})
-- ===== Metal Bat Toggle =====
getgenv().MetalBatToggle = false
getgenv().MetalBatRunning = false

Tab:CreateButton({
	Name = "Metal Bat Auto (Swing + M1)",
	Description = "ทำงานเฉพาะตอนถือ Metal Bat",
	Callback = function()
		getgenv().MetalBatToggle = not getgenv().MetalBatToggle

		if getgenv().MetalBatToggle and not getgenv().MetalBatRunning then
			print("Metal Bat : ON")
			getgenv().MetalBatRunning = true

			task.spawn(function()
				local player = game.Players.LocalPlayer

				while getgenv().MetalBatToggle do
					local char = player.Character
					if not char then
						task.wait(0.1)
						continue
					end

					-- เช็ก Tool ที่ถืออยู่
					local tool = char:FindFirstChildOfClass("Tool")

					if tool and tool.Name == "Metal Bat" then
						-- ===== Swing =====
						game.ReplicatedStorage.Remotes.Serverside:FireServer(
							"Server",
							"Sword",
							"Swing",
							"Metal Bat"
						)

						task.wait(0.1)

						-- ===== M1 =====
						game.ReplicatedStorage.Remotes.Serverside:FireServer(
							"Server",
							"Sword",
							"M1s",
							"Metal Bat",
							3
						)
					end

					task.wait(0.1) -- ความเร็วรวม
				end

				getgenv().MetalBatRunning = false
				print("Metal Bat : OFF")
			end)
		end
	end
})

-- ===== Yuta =====
Tab:CreateButton({
	Name = "Yuta M1 Toggle",
	Callback = function()
		getgenv().YutaM1Toggle = not getgenv().YutaM1Toggle

		if getgenv().YutaM1Toggle then
			task.spawn(function()
				while getgenv().YutaM1Toggle do
					game.ReplicatedStorage.Remotes.Serverside:FireServer(
						"Server","Sword","M1s","Yuta's Katana",1
					)
					task.wait(0.15)
				end
			end)
		end
	end
})



















-- 1

-- 1


















-- 1

-- 1


















-- 1
-- 1


















-- 1
-- 1


















-- 1
-- 1


















-- 1
-- 1


















-- 1
-- 1


















-- 1
-- 1

















-- ================= TAB =================
local Tab = Window:CreateTab({
    Name = "Fly + Teleport System",
    Icon = "view_in_ar",
    ImageSource = "Material",
    ShowTitle = true
})

-- ================= SERVICES =================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MapsFolder = workspace:WaitForChild("Maps")

-- ================= STATE =================
local SelectedIsland = nil

getgenv().FlyToggle   = false
getgenv().FlyDistance = 10
getgenv().TargetName  = "Bandit"

local att0, att1, alignPos, alignOri

-- ================= ISLAND SYSTEM =================

local function getAllIslands()
    local islands = {}
    for _, island in ipairs(MapsFolder:GetChildren()) do
        if island:IsA("Model") or island:IsA("Folder") then
            table.insert(islands, island.Name)
        end
    end
    table.sort(islands)
    return islands
end

local function teleportToIsland(islandName)
    if not islandName then
        warn("ยังไม่ได้เลือกเกาะ")
        return
    end

    local island = MapsFolder:FindFirstChild(islandName)
    if not island then
        warn("ไม่พบเกาะ:", islandName)
        return
    end

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    local cf = nil

    if island:IsA("Model") then
        cf = island:GetPivot()
    elseif island:IsA("Folder") then
        for _, v in ipairs(island:GetDescendants()) do
            if v:IsA("BasePart") then
                cf = v.CFrame
                break
            end
        end
    end

    if cf then
        hrp.CFrame = cf + Vector3.new(0, 50, 0)
    else
        warn("ไม่สามารถหาตำแหน่งวาปของเกาะได้")
    end
end

-- ================= FLY SYSTEM =================

local function findTarget(name)
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == name then
            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                return v
            end
        end
    end
end

local function disableCollision(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function enableCollision(character)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

local function enableFly(character, target)
    if not character or not target then return end

    local hrp = character:WaitForChild("HumanoidRootPart")
    local targetHRP = target:FindFirstChild("HumanoidRootPart")
    if not targetHRP then return end

    disableCollision(character)

    if not att0 then
        att0 = Instance.new("Attachment", hrp)
        att1 = Instance.new("Attachment", targetHRP)
        att1.Position = Vector3.new(0, getgenv().FlyDistance, 0)

        alignPos = Instance.new("AlignPosition")
        alignPos.Attachment0 = att0
        alignPos.Attachment1 = att1
        alignPos.RigidityEnabled = true
        alignPos.MaxForce = 200000
        alignPos.Parent = hrp

        alignOri = Instance.new("AlignOrientation")
        alignOri.Attachment0 = att0
        alignOri.Attachment1 = att1
        alignOri.RigidityEnabled = true
        alignOri.Parent = hrp
    else
        att1.Position = Vector3.new(0, getgenv().FlyDistance, 0)
    end
end

local function disableFly(character)
    if att0 then att0:Destroy() att0 = nil end
    if att1 then att1:Destroy() att1 = nil end
    if alignPos then alignPos:Destroy() alignPos = nil end
    if alignOri then alignOri:Destroy() alignOri = nil end
    if character then
        enableCollision(character)
    end
end

local function updateFly()
    while getgenv().FlyToggle do
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local target = findTarget(getgenv().TargetName)

        if target then
            local hum = target:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                enableFly(character, target)
            else
                disableFly(character)
            end
        end

        task.wait(0.1)
    end

    local character = LocalPlayer.Character
    if character then
        disableFly(character)
    end
end

-- ================= UI =================
local function teleportToMob(name)
    if not name then
        warn("ยังไม่ได้เลือกมอน")
        return
    end

    local mob = findMobByName(name)
    if not mob then
        warn("ไม่พบมอน:", name)
        return
    end

    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    hrp.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
end

Tab:CreateButton({
    Name = "Teleport to Mob",
    Callback = function()
        teleportToMob(SelectedMob)
    end
})

Tab:CreateButton({
    Name = "Teleport to Island",
    Callback = function()
        teleportToIsland(SelectedIsland)
    end
})

Tab:CreateDropdown({
    Name = "Select Island",
    Options = getAllIslands(),
    CurrentOption = nil,
    MultipleOptions = false,
    Callback = function(option)
        if type(option) == "string" then
            SelectedIsland = option
            print("Selected Island:", option)
        end
    end
}, "IslandDropdown")

-- ===== Services =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ===== State =====
local SelectedMob = nil

-- ===== หา list ชื่อมอนทั้งหมดในแมพ =====
local function getAllMobs()
    local mobs = {}

    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
            if not table.find(mobs, v.Name) then
                table.insert(mobs, v.Name)
            end
        end
    end

    table.sort(mobs)
    return mobs
end

-- ===== หาโมเดลมอนตามชื่อ =====
local function findMobByName(name)
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Model") and v.Name == name then
            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                return v
            end
        end
    end
end

-- ===== วาปไปหามอน =====

-- ===== UI =====
Tab:CreateDropdown({
    Name = "Select Mob",
    Options = getAllMobs(),
    CurrentOption = nil,
    MultipleOptions = false,
    Callback = function(option)
        if type(option) == "string" then
            SelectedMob = option
            print("Selected Mob:", option)
        end
    end
}, "MobDropdown")
