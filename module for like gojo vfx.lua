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
	local blu = vfxfolder.blu
	local part = vfxfolder.bluwindpart
	
	blu = blu:Clone()
	blu.Parent = char
	part = part:Clone()
	part.Parent = char
	part.Anchored = false
	
	local beam1 = part.beam1
	local beam2 = part.beam2
	
	local stars1 = part.Attachment.stars1
	local stars2 = part.Attachment.stars2
	
	local weld = Instance.new("Weld", part)
	weld.Part0 = char.HumanoidRootPart
	weld.Part1 = part
	
	blu.CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -50)
	
	ts:Create(beam1, TweenInfo.new(1.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	ts:Create(beam2, TweenInfo.new(1.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	
	ts:Create(blu, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)}):Play()
	ts:Create(blu, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Size = Vector3.new(1.7, 1.7, 8)}):Play()
	
	blu.Changed:Connect(function()
		if blu.Size == Vector3.new(1.7, 1.7, 8) then
			stars1:Emit(5)
			stars2:Emit(7)
			ts:Create(blu, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(10, 10, 0.3)}):Play()
			ts:Create(blu, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			ts:Create(blu.Highlight, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {OutlineTransparency = 1}):Play()
			ts:Create(blu.PointLight, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Brightness = 0}):Play()
			ts:Create(blu, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {CFrame = blu.CFrame * CFrame.new(0, 0, 4)}):Play()
			wait(1)
			blu:Destroy()
			part:Destroy()
		end
	end)
	
	for i = 0, 1, 0.035 do
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

return module
