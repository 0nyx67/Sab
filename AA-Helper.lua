local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local screenGui = Instance.new("ScreenGui", player.PlayerGui)
screenGui.Name = "AriesHub"
screenGui.ResetOnSpawn = false

local FULL_H = 108
local MINI_H  = 26
local WIDTH   = 148

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, WIDTH, 0, FULL_H)
mainFrame.Position = UDim2.new(0.5, -(WIDTH/2), 0.5, -(FULL_H/2))
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 9)
mainCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke", mainFrame)
uiStroke.Thickness = 1.8
uiStroke.Color = Color3.fromRGB(255, 255, 255)

local uiGradient = Instance.new("UIGradient")
uiGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(0.15, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(0.30, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(0.45, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(0.60, Color3.fromRGB(255,255,255)),
	ColorSequenceKeypoint.new(0.75, Color3.fromRGB(0,0,0)),
	ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255,255,255))
})
uiGradient.Rotation = 0
uiGradient.Parent = uiStroke

task.spawn(function()
	while task.wait() do
		for i = 0, 360, 2 do
			uiGradient.Rotation = i
			task.wait(0.01)
		end
	end
end)

-- Clip mask for content (so minimize hides cleanly)
local clipFrame = Instance.new("Frame")
clipFrame.Size = UDim2.new(1, 0, 1, 0)
clipFrame.BackgroundTransparency = 1
clipFrame.ClipsDescendants = true
clipFrame.Parent = mainFrame

-- Title bar (inside clipFrame)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, MINI_H)
titleBar.BackgroundTransparency = 1
titleBar.Parent = clipFrame

-- Settings button LEFT side of title
local settingsBtn = Instance.new("TextButton")
settingsBtn.Size = UDim2.new(0, 17, 0, 17)
settingsBtn.Position = UDim2.new(0, 5, 0.5, -8)
settingsBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
settingsBtn.Text = "⚙"
settingsBtn.TextColor3 = Color3.fromRGB(255,255,255)
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 10
settingsBtn.BorderSizePixel = 0
settingsBtn.ZIndex = 5
settingsBtn.Parent = titleBar

Instance.new("UICorner", settingsBtn).CornerRadius = UDim.new(0, 4)
local sBtnStroke = Instance.new("UIStroke", settingsBtn)
sBtnStroke.Thickness = 1
sBtnStroke.Color = Color3.fromRGB(255,255,255)
sBtnStroke.Transparency = 0.6

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -48, 1, 0)
title.Position = UDim2.new(0, 26, 0, 0)
title.Text = "aries hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 11
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextStrokeColor3 = Color3.fromRGB(0,0,0)
title.TextStrokeTransparency = 0
title.Parent = titleBar

-- Minimize button RIGHT side of title
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 17, 0, 17)
minimizeBtn.Position = UDim2.new(1, -22, 0.5, -8)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
minimizeBtn.Text = "–"
minimizeBtn.TextColor3 = Color3.fromRGB(255,255,255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 11
minimizeBtn.BorderSizePixel = 0
minimizeBtn.ZIndex = 5
minimizeBtn.Parent = titleBar

Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 4)
local mBtnStroke = Instance.new("UIStroke", minimizeBtn)
mBtnStroke.Thickness = 1
mBtnStroke.Color = Color3.fromRGB(255,255,255)
mBtnStroke.Transparency = 0.6

-- Content area
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 0, FULL_H - MINI_H)
content.Position = UDim2.new(0, 0, 0, MINI_H)
content.BackgroundTransparency = 1
content.Parent = clipFrame

local function makeBtn(label, yPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 128, 0, 23)
	btn.Position = UDim2.new(0.5, -64, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.Text = label
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 11
	btn.BorderSizePixel = 0
	btn.Parent = content
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local st = Instance.new("UIStroke", btn)
	st.Thickness = 1
	st.Color = Color3.fromRGB(255,255,255)
	st.Transparency = 0.82
	return btn
end

-- 6px gap top, 5px between buttons, leaving room for dc label
local autoBuyBtn  = makeBtn("Auto Buy: OFF",  6)
local anchoredBtn = makeBtn("Anchored: OFF",  34)

local dcLabel = Instance.new("TextLabel")
dcLabel.Size = UDim2.new(1, 0, 0, 14)
dcLabel.Position = UDim2.new(0, 0, 0, 63)
dcLabel.Text = "discord.gg/mrd4ZHXTrG"
dcLabel.Font = Enum.Font.GothamBold
dcLabel.TextSize = 9
dcLabel.BackgroundTransparency = 1
dcLabel.TextColor3 = Color3.fromRGB(255,255,255)
dcLabel.TextStrokeColor3 = Color3.fromRGB(0,0,0)
dcLabel.TextStrokeTransparency = 0.5
dcLabel.Parent = content

-- Settings panel parented to screenGui so ClipsDescendants never hides it
local PANEL_W = 138
local settingsPanel = Instance.new("Frame")
settingsPanel.Size = UDim2.new(0, PANEL_W, 0, FULL_H)
settingsPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
settingsPanel.BorderSizePixel = 0
settingsPanel.Visible = false
settingsPanel.ZIndex = 6
settingsPanel.Parent = screenGui

Instance.new("UICorner", settingsPanel).CornerRadius = UDim.new(0, 9)
local pStroke = Instance.new("UIStroke", settingsPanel)
pStroke.Thickness = 1.5
pStroke.Color = Color3.fromRGB(255,255,255)
pStroke.Transparency = 0.65

local panelTitle = Instance.new("TextLabel")
panelTitle.Size = UDim2.new(1, 0, 0, 26)
panelTitle.Text = "settings"
panelTitle.Font = Enum.Font.GothamBold
panelTitle.TextSize = 10
panelTitle.BackgroundTransparency = 1
panelTitle.TextColor3 = Color3.fromRGB(170,170,170)
panelTitle.ZIndex = 7
panelTitle.Parent = settingsPanel

local function makeToggle(label, yPos)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 118, 0, 23)
	btn.Position = UDim2.new(0.5, -59, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	btn.Text = label .. ": OFF"
	btn.TextColor3 = Color3.fromRGB(255,255,255)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 11
	btn.BorderSizePixel = 0
	btn.ZIndex = 7
	btn.Parent = settingsPanel
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	local st = Instance.new("UIStroke", btn)
	st.Thickness = 1
	st.Color = Color3.fromRGB(255,255,255)
	st.Transparency = 0.82
	return btn
end

local instantPromptBtn = makeToggle("Instant Prompt", 30)
local antiRagdollBtn   = makeToggle("Anti Ragdoll",   59)

-- Keep settings panel snapped right of mainFrame
RunService.RenderStepped:Connect(function()
	local ap = mainFrame.AbsolutePosition
	local as = mainFrame.AbsoluteSize
	settingsPanel.Position = UDim2.new(0, ap.X + as.X + 6, 0, ap.Y)
end)

-- Minimize
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	mainFrame.Size = UDim2.new(0, WIDTH, 0, minimized and MINI_H or FULL_H)
	settingsPanel.Size = UDim2.new(0, PANEL_W, 0, minimized and MINI_H or FULL_H)
	if minimized then settingsPanel.Visible = false end
	minimizeBtn.Text = minimized and "+" or "–"
end)

-- Settings toggle
local settingsOpen = false
settingsBtn.MouseButton1Click:Connect(function()
	if minimized then return end
	settingsOpen = not settingsOpen
	settingsPanel.Visible = settingsOpen
	settingsBtn.TextColor3 = settingsOpen and Color3.fromRGB(100,200,255) or Color3.fromRGB(255,255,255)
end)

-- Drag
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local dragging, dragStartPos, frameStartPos = false, nil, nil

if isMobile then
	titleBar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStartPos = i.Position; frameStartPos = mainFrame.Position
		end
	end)
	titleBar.InputChanged:Connect(function(i)
		if dragging and i.UserInputType == Enum.UserInputType.Touch then
			local d = i.Position - dragStartPos
			mainFrame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset+d.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset+d.Y)
		end
	end)
	titleBar.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.Touch then dragging = false end
	end)
else
	titleBar.InputBegan:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true; dragStartPos = i.Position; frameStartPos = mainFrame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(i)
		if dragging and dragStartPos and i.UserInputType == Enum.UserInputType.MouseMovement then
			local d = i.Position - dragStartPos
			mainFrame.Position = UDim2.new(frameStartPos.X.Scale, frameStartPos.X.Offset+d.X, frameStartPos.Y.Scale, frameStartPos.Y.Offset+d.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
end

local function setToggle(btn, on, label)
	btn.Text = on and (label..": ON") or (label..": OFF")
	btn.TextColor3 = on and Color3.fromRGB(100,255,120) or Color3.fromRGB(255,255,255)
end

-- Auto Buy
local autoBuyActive = false
autoBuyBtn.MouseButton1Click:Connect(function()
	autoBuyActive = not autoBuyActive
	setToggle(autoBuyBtn, autoBuyActive, "Auto Buy")
end)
ProximityPromptService.PromptShown:Connect(function(prompt)
	if autoBuyActive and prompt.ActionText == "Purchase" then
		prompt.HoldDuration = 0
		fireproximityprompt(prompt)
	end
end)

-- Anchored
local anchored = false
anchoredBtn.MouseButton1Click:Connect(function()
	anchored = not anchored
	setToggle(anchoredBtn, anchored, "Anchored")
	local char = player.Character or player.CharacterAdded:Wait()
	if char then
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.Anchored = anchored end
		end
	end
end)

-- Instant Prompt
local instantPromptActive = false
local instantPromptConn = nil
instantPromptBtn.MouseButton1Click:Connect(function()
	instantPromptActive = not instantPromptActive
	setToggle(instantPromptBtn, instantPromptActive, "Instant Prompt")
	if instantPromptActive then
		instantPromptConn = ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt, plr)
			if plr == player then
				fireproximityprompt(prompt)
			end
		end)
	else
		if instantPromptConn then instantPromptConn:Disconnect(); instantPromptConn = nil end
	end
end)

-- Anti Ragdoll
local Connections = {}
local antiRagdollActive = false

local function startAntiRagdoll()
	if Connections.antiRagdoll then return end
	Connections.antiRagdoll = RunService.Heartbeat:Connect(function()
		local char = player.Character
		if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local root = char:FindFirstChild("HumanoidRootPart")
		if not (hum and root) then return end
		local s = hum:GetState()
		local ragdolled = s == Enum.HumanoidStateType.Physics or s == Enum.HumanoidStateType.Ragdoll or s == Enum.HumanoidStateType.FallingDown
		local endTime = player:GetAttribute("RagdollEndTime")
		if endTime and (endTime - workspace:GetServerTimeNow()) > 0 then ragdolled = true end
		if ragdolled then
			pcall(function() player:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow()) end)
			for _, d in ipairs(char:GetDescendants()) do
				if d:IsA("BallSocketConstraint") or (d:IsA("Attachment") and d.Name:find("RagdollAttachment")) then d:Destroy() end
			end
			for _, obj in ipairs(char:GetDescendants()) do
				if obj:IsA("Motor6D") and not obj.Enabled then obj.Enabled = true end
			end
			if hum.Health > 0 then hum:ChangeState(Enum.HumanoidStateType.Running) end
			workspace.CurrentCamera.CameraSubject = hum
			root.Anchored = false
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end
	end)
end

local function stopAntiRagdoll()
	if Connections.antiRagdoll then Connections.antiRagdoll:Disconnect(); Connections.antiRagdoll = nil end
end

antiRagdollBtn.MouseButton1Click:Connect(function()
	antiRagdollActive = not antiRagdollActive
	setToggle(antiRagdollBtn, antiRagdollActive, "Anti Ragdoll")
	if antiRagdollActive then startAntiRagdoll() else stopAntiRagdoll() end
end)
