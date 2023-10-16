local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local repStorage = game:GetService("ReplicatedStorage")
local tweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")



local player  = Players.LocalPlayer
local char = player.Character
local playerHRP = char.HumanoidRootPart
local Mouse = player:GetMouse()

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://7652957485"
local animtrack = char.Humanoid:LoadAnimation(anim)

local ray
local pos
local ray1
local pos1
local conn
local hit

local db = true

UserInput.InputBegan:Connect(function(InputObject, gpe)
	if InputObject.KeyCode == Enum.KeyCode.Q and not gpe and db == true then
		
		local check = player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value
		local manaCost = script.ManaCost.Value
		
		local checkEquip = char.RightHand:GetChildren()
		local count = 0
		
		for _,v in ipairs(checkEquip) do				
			if v.Name == "Knight's Blade" then
				count = count + 1
			end
		end
		
		if count == 1 and check >= manaCost then 
			
			player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value = player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value - manaCost
			player.PlayerGui.MainGui.Skill2.cooldown.Value.Value = true
			db = false		
			
			player.Character["Knight's Blade"].Bits.Enabled = true
			player.Character["Knight's Blade"].BitsSmall.Enabled = true
			player.Character["Knight's Blade"].Wave1.Enabled = true
			player.Character["Knight's Blade"].Wave2.Enabled = true
			
			local attackBoost = script.AttackBoost.Value

			repStorage.SwordEvents.PowerUP:FireServer(attackBoost)		
			animtrack:Play()

			wait(0.55)
			animtrack:Stop()
			
			wait(5)
			player.Character["Knight's Blade"].Bits.Enabled = false
			player.Character["Knight's Blade"].BitsSmall.Enabled = false
			player.Character["Knight's Blade"].Wave1.Enabled = false
			player.Character["Knight's Blade"].Wave2.Enabled = false
			
		else
			count = 0
		end
		
	end
end)

player.PlayerGui.MainGui.Skill2.cooldown.Value.Changed:Connect(function()
	local bool = player.PlayerGui.MainGui.Skill2.cooldown.Value.Value


	if bool == true then

		player.PlayerGui.MainGui.Skill2.cooldown.coolLeft.Value = player.PlayerGui.MainGui.Skill2.cooldown.coolMax.Value
		player.PlayerGui.MainGui.Skill2.cooldown.Value.Value = false
	end
end)

while wait() do
	local frame = player.PlayerGui.MainGui.Skill2.cooldown
	local coolMax = player.PlayerGui.MainGui.Skill2.cooldown.coolMax.Value
	local coolLeft = player.PlayerGui.MainGui.Skill2.cooldown.coolLeft.Value

	if coolLeft > 0 then
		local percent = coolLeft / coolMax
		-- Change the size of the inner bar
		frame.Size = UDim2.new(1, 0, percent, 0)

		player.PlayerGui.MainGui.Skill2.cooldown.coolLeft.Value = player.PlayerGui.MainGui.Skill2.cooldown.coolLeft.Value - 3
	else
		frame.Size = UDim2.new(1, 0, 0, 0)

		db = true
	end
end
