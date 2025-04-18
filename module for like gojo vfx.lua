local ts = game:GetService("TweenService")

local vfxid = 112948408449962
local vfxfolder = game:GetObjects("rbxassetid;//"..vfxid)[1]
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
	
	ts:Create(beam1, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	ts:Create(beam2, TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {TextureSpeed = 0}):Play()
	
	ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {CFrame = char.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7)}):Play()
	ts:Create(blu, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Size = Vector3.new(1.7, 1.7, 6)}):Play()
	
	blu.Changed:Connect(function()
		if blu.Size == Vector3.new(1.7, 1.7, 6) then
			stars1:Emit(5)
			stars2:Emit(17)
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
	
	for i = 0, 1, 0.04 do
		beam1.Transparency = NumberSequence.new(i,1)
		beam2.Transparency = NumberSequence.new(i,1)

		wait()
	end
end

return module