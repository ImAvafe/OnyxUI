local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local function applyLayout(container, layout)
	local axisName = container:GetAttribute("axis") or "XY"
	local axis = Enum.AutomaticSize[axisName]
	
	if axis == Enum.AutomaticSize.None then
		return
	end

	local maxSize = container:GetAttribute("maxSize") or Vector2.new(math.huge, math.huge)
	local minSize = container:GetAttribute("minSize") or Vector2.new(0, 0)

	if typeof(maxSize) == "UDim2" then
		if container.Parent == nil then
			maxSize = Vector2.new(0, 0)
		else
			local parentSize = container.Parent.AbsoluteSize

			maxSize = Vector2.new(
				(parentSize.X / maxSize.X.Scale) + maxSize.X.Offset,
				(parentSize.Y / maxSize.Y.Scale) + maxSize.Y.Offset
			)
		end
	end

	local padX = 0
	local padY = 0
	local padding = container:FindFirstChildOfClass("UIPadding")
	if padding ~= nil then
		padX = padding.PaddingLeft.Offset + padding.PaddingRight.Offset
		padY = padding.PaddingTop.Offset + padding.PaddingBottom.Offset
	end

	local contentSize

	local AutoScaleFrame = container:FindFirstAncestor("AutoScaleFrame") or container
	local UIScale
	if AutoScaleFrame then
		UIScale = AutoScaleFrame:FindFirstChild("UIScale")
	end

	if layout then
		if UIScale then
			contentSize = layout.AbsoluteContentSize / UIScale.Scale
		else
			contentSize = layout.AbsoluteContentSize
		end
	elseif (container:IsA("TextButton") and string.len(container.Text) > 0) or (container:IsA("TextLabel") and string.len(container.Text) > 0) or (container:IsA("TextBox") and string.len(container.PlaceholderText) > 0) then
		if UIScale then
			contentSize = Vector2.new(math.ceil(container.TextBounds.X / UIScale.Scale), math.ceil(container.TextBounds.Y / UIScale.Scale))
		else
			contentSize = container.TextBounds
		end
	else
		contentSize = Vector2.new(0, 0)

		for _, child in container:GetChildren() do
			if child:IsA("GuiObject") then
				local farX = child.Position.X.Offset + child.Size.X.Offset
				local farY = child.Position.Y.Offset + child.Size.Y.Offset

				contentSize = Vector2.new(math.max(contentSize.X, farX), math.max(contentSize.Y, farY))
			end
		end
	end
	
	local baseX = math.max(contentSize.X + padX, minSize.X)
	local baseY = math.max(contentSize.Y + padY, minSize.Y)

	local x, y
	local xClamped, yClamped

	if axis == Enum.AutomaticSize.XY then
		x = UDim.new(0, baseX)
		y = UDim.new(0, baseY)
		xClamped = UDim.new(0, math.min(baseX, maxSize.X))
		yClamped = UDim.new(0, math.min(baseY, maxSize.Y))
	elseif axis == Enum.AutomaticSize.X then
		x = UDim.new(0, baseX)
		y = container.Size.Y
		xClamped = UDim.new(0, math.min(baseX, maxSize.X))
		yClamped = container.Size.Y
	else
		x = container.Size.X
		y = UDim.new(0, baseY)
		xClamped = container.Size.X
		yClamped = UDim.new(0, math.min(baseY, maxSize.Y))
	end

	if container:IsA("ScrollingFrame") then
		local canvasX = x
		local canvasY = y

		if x.Offset > xClamped.Offset then
			canvasY -= UDim.new(0, container.ScrollBarThickness)
		end
		if y.Offset > yClamped.Offset then
			canvasX -= UDim.new(0, container.ScrollBarThickness)
		end

		container.CanvasSize = UDim2.new(canvasX, canvasY)
	end

	container.Size = UDim2.new(xClamped, yClamped)
end

local function trackParentSize(instance, callback)
	local parent = nil
	local connection = nil

	local function parentChanged(newParent)
		if parent == newParent then
			return
		end

		if connection ~= nil then
			connection:Disconnect()
			connection = nil
		end

		if newParent == nil then
			return
		end

		connection = newParent:GetPropertyChangedSignal("AbsoluteSize"):Connect(callback)
		parent = newParent
	end

	parentChanged(instance.Parent)

	instance:GetPropertyChangedSignal("Parent"):Connect(function()
		parentChanged(instance.Parent)
	end)
end

-- local defaultOptions = {}

local function automaticSize(container, options)
	options = options or {}
	options.axis = options.axis or container.AutomaticSize
	
	container.AutomaticSize = Enum.AutomaticSize.None

	if options.maxSize then
		container:SetAttribute("maxSize", options.maxSize)
	end

	if options.minSize then
		container:SetAttribute("minSize", options.maxSize)
	end

	if options.axis then
		container:SetAttribute("axis", options.axis.Name)
	end

	if not RunService:IsClient() and typeof(container:GetAttribute("maxSize") or nil) == "UDim2" then
		CollectionService:AddTag(container, "PlasmaAutomaticSize")

		return
	end

	local layout = container:FindFirstChildWhichIsA("UIGridStyleLayout")

	applyLayout(container, layout)

	if typeof(container:GetAttribute("maxSize") or nil) == "UDim2" then
		trackParentSize(container, function()
			applyLayout(container, layout)
		end)
	end

	if layout then
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			applyLayout(container, layout)
		end)
	elseif container:IsA("TextLabel") or container:IsA("TextButton") or container:IsA("TextBox") then
		container:GetPropertyChangedSignal("TextBounds"):Connect(function()
			applyLayout(container)
		end)
	else
		local function connect(child)
			if child:IsA("GuiObject") then
				child:GetPropertyChangedSignal("Size"):Connect(function()
					applyLayout(container)
				end)
			end
		end

		for _, child in container:GetChildren() do
			connect(child)
		end

		container.ChildAdded:Connect(function(child)
			applyLayout(container)

			connect(child)
		end)

		container.ChildRemoved:Connect(function()
			applyLayout(container)
		end)
	end

	container:GetAttributeChangedSignal("maxSize"):Connect(function()
		applyLayout(container, layout)
	end)

	container:GetAttributeChangedSignal("minSize"):Connect(function()
		applyLayout(container, layout)
	end)

	return container
end

return {
	AutomaticSize = automaticSize,
	ApplyLayout = applyLayout,
}