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
anim.AnimationId = "rbxassetid://7716562811"
local animtrack = char.Humanoid:LoadAnimation(anim)

local ray
local pos
local ray1
local pos1
local conn
local hit

local db = true

UserInput.InputBegan:Connect(function(InputObject, gpe)
	if InputObject.KeyCode == Enum.KeyCode.X and not gpe and db == true then
		
		local check = player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value
		local manaCost = script.ManaCost.Value
		
		local checkEquip = char.RightHand:GetChildren()
		local count = 0
		
		for _,v in ipairs(checkEquip) do				
			if v.Name == "Bamboo Stick" then
				count = count + 1
			end
		end
		
		if count == 1 and check >= manaCost then 
			
			player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value = player.PlayerGui.MainGui.manaBar.Mana.ManaLeft.Value - manaCost
			player.PlayerGui.MainGui.Ult.cooldown.Value.Value = true
			db = false

			char.Humanoid.WalkSpeed = 0
			wait(.1)
			char.HumanoidRootPart.Anchored = true

			local RootPos, MousePos = playerHRP.Position, Mouse.Hit.Position
			playerHRP.CFrame = CFrame.new(RootPos, Vector3.new(MousePos.X, RootPos.Y, MousePos.Z))

			local MouseHit = Mouse.Hit.Position
			local Dmg = script.Dmg.Value
	
			animtrack:Play()
			local guide = Instance.new("Part")
			guide.Name = "Guide"
			guide.Parent = player.Character
			guide.Anchored = true
			guide.CanCollide = false
			guide.Transparency = 1
			guide.CFrame = playerHRP.CFrame * CFrame.new(Vector3.new(0,0,-35))
			
				
			
			--arepStorage.StaffEvents.Slam:FireServer(playerHRP, MouseHit)	
			
			local tween = tweenService:Create(playerHRP, TweenInfo.new(.4, Enum.EasingStyle.Linear), {CFrame = CFrame.new(guide.Position) * CFrame.Angles(0,math.rad(playerHRP.Orientation.Y),0)})
			local tween1 = tweenService:Create(playerHRP, TweenInfo.new(.5, Enum.EasingStyle.Linear), {CFrame = playerHRP.CFrame * CFrame.new(Vector3.new(0,0,-5)) * CFrame.Angles(0,math.rad(playerHRP.Orientation.Y),0)})
			
			tween1:Play()
			wait(0.6)
			tween:Play()

			local air1 = repStorage.MeshPart:Clone()
			air1.Parent = workspace
			air1.CFrame = CFrame.new(playerHRP.Position) * CFrame.Angles(0,math.rad(playerHRP.Orientation.Y * 45),45)

			local airRay1 = Ray.new(playerHRP.Position, playerHRP.CFrame.LookVector * -40)
			local _, airPos1 = workspace:FindPartOnRay(airRay1, char)

			local goalAir1 = {
				Size = air1.Size * 2,
				CFrame = CFrame.new(airPos1) * CFrame.Angles(90,math.pi/15,0)
			}

			local airTween1 = tweenService:Create(air1, TweenInfo.new(5, Enum.EasingStyle.Linear), goalAir1)
			airTween1:Play()

			local air2 = repStorage.MeshPart:Clone()
			air2.Parent = workspace
			air2.CFrame = CFrame.new(playerHRP.Position) * CFrame.Angles(0,math.rad(playerHRP.Orientation.Y),0)

			local airRay2 = Ray.new(playerHRP.Position, playerHRP.CFrame.LookVector * -40)
			local _, airPos2 = workspace:FindPartOnRay(airRay2, char)

			local goalAir2 = {
				Size = air2.Size * 4,
				CFrame = CFrame.new(airPos2) * CFrame.Angles(90,math.pi/15,90)
			}

			local airTween2 = tweenService:Create(air2, TweenInfo.new(5, Enum.EasingStyle.Linear), goalAir2)
			airTween2:Play()

			wait(.05)
			
			local air = repStorage.MeshPart:Clone()
			air.Parent = workspace
			air.CFrame = CFrame.new(playerHRP.Position) * CFrame.Angles(0,math.rad(playerHRP.Orientation.Y * 45),45)

			local airRay = Ray.new(playerHRP.Position, playerHRP.CFrame.LookVector * -40)
			local _, airPos = workspace:FindPartOnRay(airRay, char)

			local goalAir = {
				Size = air.Size * 3,
				CFrame = CFrame.new(airPos) * CFrame.Angles(90,math.pi/15,0)
			}

			local airTween = tweenService:Create(air, TweenInfo.new(5, Enum.EasingStyle.Linear), goalAir)
			airTween:Play()
			
			
			
			wait(0.5)
			
			local hit = Instance.new("Explosion")
			hit.BlastRadius = 15
			hit.BlastPressure = 0
			hit.Visible = true
			hit.DestroyJointRadiusPercent = 0
			hit.Parent = player.Character
			hit.Position = guide.Position

			hit.Hit:Connect(function(part, distance)

				local humanoid = part.Parent:FindFirstChildWhichIsA("Humanoid")

				if humanoid and humanoid.Parent ~= player.Character then
					repStorage.StaffEvents.Slam:FireServer(humanoid, MouseHit, Dmg)
				end
			end)
			
			
			local explosion = repStorage.Particles.FireMeshExplosion:Clone()
			explosion.Parent = workspace
			explosion:SetPrimaryPartCFrame(playerHRP.CFrame * CFrame.new(Vector3.new(0,0,-5)))

			local partCheck = explosion:GetChildren()

			for _,v in ipairs(partCheck) do

				local tweenImpact = tweenService:Create(v, TweenInfo.new(1), {Size = v.Size * 2, Transparency = 1})
				tweenImpact:Play()
			end

			wait(0.5)
			animtrack:Stop()
			char.HumanoidRootPart.Anchored = false
			char.Humanoid.WalkSpeed = 16

			wait(1)		
			hit:Destroy()
			guide:Destroy()
			explosion:Destroy()
			air:Destroy()
			air1:Destroy()
			air2:Destroy()
		else
			count = 0
		end
		
	end
end)

player.PlayerGui.MainGui.Ult.cooldown.Value.Changed:Connect(function()
	local bool = player.PlayerGui.MainGui.Ult.cooldown.Value.Value
	
	
	if bool == true then
		
		player.PlayerGui.MainGui.Ult.cooldown.coolLeft.Value = player.PlayerGui.MainGui.Ult.cooldown.coolMax.Value
		player.PlayerGui.MainGui.Ult.cooldown.Value.Value = false
	end
end)

while wait() do
	local frame = player.PlayerGui.MainGui.Ult.cooldown
	local coolMax = player.PlayerGui.MainGui.Ult.cooldown.coolMax.Value
	local coolLeft = player.PlayerGui.MainGui.Ult.cooldown.coolLeft.Value
	
	if coolLeft > 0 then
		local percent = coolLeft / coolMax
		-- Change the size of the inner bar
		frame.Size = UDim2.new(1, 0, percent, 0)

		player.PlayerGui.MainGui.Ult.cooldown.coolLeft.Value = player.PlayerGui.MainGui.Ult.cooldown.coolLeft.Value - 3
	else
		frame.Size = UDim2.new(1, 0, 0, 0)
		
		db = true
	end
end

repStorage.Events.Attack.OnClientEvent:Connect(function(humanoid, dmg, crit)
	repStorage.Events.Attack:FireServer(humanoid, dmg, crit)
end)
