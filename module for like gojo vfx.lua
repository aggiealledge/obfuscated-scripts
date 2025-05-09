local ts = game:GetService("TweenService")

local vfxid = 112948408449962
local vfxfolder = game:GetObjects("rbxassetid://"..vfxid)[1]
game:GetService("ContentProvider"):PreloadAsync({vfxfolder})

--local vfxfolder = workspace.bluevfx
if vfxfolder then
	vfxfolder.Parent = game:GetService("ReplicatedStorage")
elseif not vfxfolder then
	warn("whoops!!! no blue vfx")
end

---------------------------------------------------------------------------------

local module = {}

function module.bluevfx(char)
	local plr = game.Players:GetPlayerFromCharacter(char)
	local cam = workspace.CurrentCamera
	
	local blu = vfxfolder.blu
	local part = vfxfolder.bluwindpart
	local wind = vfxfolder.bluwind1
	
	blu = blu:Clone()
	blu.Parent = char
	part = part:Clone()
	part.Parent = char
	part.Anchored = false
	wind = wind:Clone()
	wind.Parent = char
	
	local beam1 = part.beam1
	local beam2 = part.beam2
	
	local stars1 = part.Attachment.stars1
	local stars2 = part.Attachment.stars2
	
	local weld = Instance.new("Weld", part)
	weld.Part0 = char.HumanoidRootPart
	weld.Part1 = part
	
	blu.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
	blu.Size = Vector3.new(0.5, 0.5, 7.5)
	
	wind.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
	wind.Size = Vector3.new(10, 10, 6)	
	
	ts:Create(beam1, TweenInfo.new(1.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	ts:Create(beam2, TweenInfo.new(1.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	
	ts:Create(wind, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(17, 14, 64)}):Play()
	ts:Create(wind, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -35)}):Play()
	ts:Create(wind, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	ts:Create(wind, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Color = Color3.fromRGB(171, 240, 255)}):Play()
	
	wind:GetPropertyChangedSignal("Transparency"):Connect(function()
		if wind.Transparency == 1 then
			wind:Destroy()
		end
	end)
	
	ts:Create(blu, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -70)}):Play()
	ts:Create(blu, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {Size = Vector3.new(5, 5, 1)}):Play()
	
	for i = 1, 0, 0.035 do
		beam1.Transparency = NumberSequence.new(i,1)
		beam2.Transparency = NumberSequence.new(i,1)

		wait()
	end
	
	task.wait(0.2)
	
	ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)}):Play()
	ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Size = Vector3.new(1.7, 1.7, 8)}):Play()
	
	blu.Changed:Connect(function()
		if blu.Size == Vector3.new(1.7, 1.7, 8) then
			ts:Create(cam, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 90}):Play()
			
			stars1:Emit(5)
			stars2:Emit(7)
			ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(10, 10, 0.3)}):Play()
			ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			--ts:Create(blu.Highlight, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {OutlineTransparency = 1}):Play()
			ts:Create(blu.PointLight, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Brightness = 0}):Play()
			ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = blu.CFrame * CFrame.new(0, 0, 4)}):Play()
			--wait(0.4)
		elseif blu.Transparency == 1 then
			blu:Destroy()
			part:Destroy()
			
			ts:Create(cam, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 70}):Play()
		end
	end)
	
	for i = 0, 1, 0.05 do
		beam1.Transparency = NumberSequence.new(i,1)
		beam2.Transparency = NumberSequence.new(i,1)

		wait()
	end
end

local function randomglass(gui)
	local texture
	local r = Random.new()
	
	
	--local frame = gui.ImageLabel
	
	local nframe = Instance.new("ImageLabel", gui)
	nframe.ImageTransparency = 0.7
	nframe.BackgroundTransparency = 1
	--frame:Destroy()
	local random = math.random(1, 2)
	if random == 1 then
		texture = "rbxassetid://6118439519"
	elseif random == 2 then
		texture = "rbxassetid://6118439008"
	end
	nframe.Name = "glass shard"
	nframe.Image = texture
	nframe.Size = UDim2.new(math.random(3, 8)/10, 0, math.random(3, 8)/10, 0)
	nframe.Position = UDim2.new(r:NextNumber(0,0.8),0,r:NextNumber(-0.4,0.8),0)
	nframe.Position += UDim2.fromScale(-0.07, 0)
	nframe.Rotation = math.random(-90, 90)
	nframe.Parent = gui
	
	--nframe:TweenPosition(nframe.Position + UDim2.fromScale(0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Cubic, 0.7)
	--nframe:TweenSize(UDim2.fromScale(0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Cubic, 0.7)
	
	ts:Create(nframe, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0, 0)}):Play()
	ts:Create(nframe, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Position = nframe.Position + UDim2.fromScale(0.1, 0.5)}):Play()
end

function module.shatter(parent, amount, char)
	local sfx = Instance.new("Sound", char.Head)
	sfx.SoundId = "rbxassetid://6737581315"
	sfx.Volume = 3
	sfx:Play()
	
	local gui = Instance.new("ScreenGui", parent)
	gui.IgnoreGuiInset = true
	gui.Name = "screenshatter"
	for i = 1,amount do
		randomglass(gui)
	end
	task.wait(1)
	for i,v in pairs(gui:GetChildren()) do
		v:Destroy()
	end
	gui:Destroy()
	sfx.Ended:Wait()
	sfx:Destroy()
end

function module.palmvfx(char)
	local part = vfxfolder.palmwindpart:Clone()
	part.Parent = char
	part.Anchored = false
	
	local att = part.Attachment
	local dust = att.dust
	local blast = att.windblast
	local circle = att.windcircle
	
	local weld = Instance.new("Weld", part)
	weld.Part0 = char.HumanoidRootPart
	weld.Part1 = part
	
	dust:Emit(10)
	blast:Emit(20)
	circle:Emit(2)
	
	task.wait(0.5)
	part:Destroy()
end

function module.divevfx(part, bool, vol)
	if bool == true then
		--[[
		if divdb == true then
			return
		end
		--]]
		--divergent = true
		divdb = true
		
		local vfxpart = vfxfolder:WaitForChild("divergentarm")
		
		local sound = Instance.new("Sound", vfxpart)
		sound.SoundId = "rbxassetid://120714138513879"
		sound.Volume = vol
		sound:Play()
		
		vfxpart = vfxpart:Clone()
		vfxpart.Anchored = false
		vfxpart.Parent = part.Parent

		local weld = Instance.new("Weld", vfxpart)
		weld.Part0 = part
		weld.Part1 = vfxpart

		local att = vfxpart.Attachment
		for i,v in pairs(att:GetChildren()) do
			if v:IsA("ParticleEmitter") then
				if v.Name == "sparks" then
					v:Emit(40)
				else
					v:Emit(40)
					v.Enabled = true
				end
			end
		end
	elseif bool == false then
		--divergent = false
		divdb = false
		
		--local vfxpart = part.Parent:FindFirstChild("divergentarm") --vfxfolder:WaitForChild("divergentarm")
		
		for i,b in pairs(part.Parent:GetChildren()) do
			if b.Name == "divergentarm" then
				for i,v in pairs(b:GetDescendants()) do
					if v:IsA("ParticleEmitter") or v:IsA("Trail") then
						v.Enabled = false
					end
				end
				wait(0.5)
				b:Destroy()
			end
		end
	end
end

function module.divergentboom(char, degree, cfr)
	local div1 = vfxfolder.divergentmesh1:Clone()
	div1.Parent = workspace
	div1.Size = Vector3.new(2.9, 16.4, 2.9)
	local div2 = vfxfolder.divergentmesh2:Clone()
	div2.Parent = workspace
	div2.Size = Vector3.new(2.5, 16, 2.5)
	
	div1.CFrame = char.HumanoidRootPart.CFrame * cfr * CFrame.Angles(degree, 0, 0)
	div2.CFrame = char.HumanoidRootPart.CFrame * cfr * CFrame.Angles(degree, 0, 0)
	
	ts:Create(div1, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(12, 8, 12)}):Play()
	ts:Create(div2, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(12.4, 8.4, 12.4)}):Play()
	
	ts:Create(div1, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	ts:Create(div2, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
	
	--ts:Create(div1, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = div1.CFrame * CFrame.Angles(1.5, -1.5, -1.5)}):Play()
	--ts:Create(div2, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = div1.CFrame * CFrame.Angles(1.5, -1.5, -1.5)}):Play()
	
	div1.Changed:Connect(function()
		if div1.Transparency == 1 then
			div1:Destroy()
			div2:Destroy()
		end
	end)
end

function module.divehit(char)
	local cam = workspace.CurrentCamera
	ts:Create(cam, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 90}):Play()
	
	local sfx = Instance.new("Sound", char.Head)
	sfx.SoundId = "rbxassetid://89209613603828"
	sfx.Volume = 4.5
	sfx:Play()
	
	local part = vfxfolder.divergentstars:Clone()
	part.Parent = char
	part.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5)
	
	local att = part.Attachment
	
	for i,v in pairs(att:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v:Emit(30)
			v.Enabled = true
			--task.wait(0.2)
			--v.Enabled = false
		end
	end
	task.wait(0.2)
	for i,v in pairs(att:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
		end
	end
	--task.wait(0.1)
	ts:Create(cam, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 70}):Play()
	task.wait(0.5)
	part:Destroy()
end
return module
