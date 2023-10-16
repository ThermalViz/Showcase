local Players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local START_POSITION = UDim2.new(0.648, 0, -.9, 0)
local GOAL_POSITION = UDim2.new(0.648, 0, 0.125, 0)
local START_POSITION_DROP = UDim2.new(-0.346, 0, 0.408, 0)
local GOAL_POSITION_DROP = UDim2.new(0.415, 0, 0.408, 0)
local guiPos = true

local player = Players.LocalPlayer

if player.Character == nil then
	player.CharacterAdded:Wait()	
end

while player.Character.Parent ~= game.Workspace do
	player.Character.AncestryChanged:wait()
end

local guiObject = Players.LocalPlayer.PlayerGui:WaitForChild("Inventory").Border

local guiObjectDrop = player.PlayerGui.DelConfirm.Border

local debounce = true

local function callback(state)
	if state == Enum.TweenStatus.Completed then
		print("The tween completed uninterrupted")
	elseif state == Enum.TweenStatus.Canceled then
		print("Another tween cancelled this one")
	end
end

UserInputService.InputBegan:Connect(function(inputObject,gpe)
	if inputObject.KeyCode == Enum.KeyCode.V and not gpe then
		print("INV")
		if guiPos == true then
			guiPos = false
			guiObject.Position = START_POSITION
			local willPlay = guiObject:TweenPosition(
				GOAL_POSITION,           -- Final position the tween should reach
				Enum.EasingDirection.Out, -- Direction of the easing
				Enum.EasingStyle.Bounce,   -- Kind of easing to apply
				.8,                       -- Duration of the tween in seconds
				true,                    -- Whether in-progress tweens are interrupted
				callback                 -- Function to be callled when on completion/cancelation
			)
		else
			guiPos = true
			local willPlay = guiObject:TweenPosition(
				START_POSITION,           -- Final position the tween should reach
				Enum.EasingDirection.In, -- Direction of the easing
				Enum.EasingStyle.Sine,   -- Kind of easing to apply
				.3,                       -- Duration of the tween in seconds
				true,                    -- Whether in-progress tweens are interrupted
				callback                 -- Function to be callled when on completion/cancelation
			)

			local willPlayBack = guiObjectDrop:TweenPosition(
				START_POSITION_DROP,           -- Final position the tween should reach
				Enum.EasingDirection.In, -- Direction of the easing
				Enum.EasingStyle.Sine,   -- Kind of easing to apply
				.8,                       -- Duration of the tween in seconds
				true,                    -- Whether in-progress tweens are interrupted
				callback                 -- Function to be callled when on completion/cancelation
			)
		end		
	end
end)

player.PlayerGui:WaitForChild("SecondaryGui").Inv.TextButton.MouseButton1Click:Connect(function()
	if guiPos == true then
		guiPos = false
		guiObject.Position = START_POSITION
		local willPlay = guiObject:TweenPosition(
			GOAL_POSITION,           -- Final position the tween should reach
			Enum.EasingDirection.Out, -- Direction of the easing
			Enum.EasingStyle.Bounce,   -- Kind of easing to apply
			.8,                       -- Duration of the tween in seconds
			true,                    -- Whether in-progress tweens are interrupted
			callback                 -- Function to be callled when on completion/cancelation
		)
	else
		guiPos = true
		local willPlay = guiObject:TweenPosition(
			START_POSITION,           -- Final position the tween should reach
			Enum.EasingDirection.In, -- Direction of the easing
			Enum.EasingStyle.Sine,   -- Kind of easing to apply
			.3,                       -- Duration of the tween in seconds
			true,                    -- Whether in-progress tweens are interrupted
			callback                 -- Function to be callled when on completion/cancelation
		)

		local willPlayBack = guiObjectDrop:TweenPosition(
			START_POSITION_DROP,           -- Final position the tween should reach
			Enum.EasingDirection.In, -- Direction of the easing
			Enum.EasingStyle.Sine,   -- Kind of easing to apply
			.8,                       -- Duration of the tween in seconds
			true,                    -- Whether in-progress tweens are interrupted
			callback                 -- Function to be callled when on completion/cancelation
		)
	end
end)

