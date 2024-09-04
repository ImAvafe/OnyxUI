local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local sizeTweenInfo = TweenInfo.new(0.15)

local Digit = {}

function Digit.new(Spinner, LayoutOrder, Value)
	local d = {
		Duration = Spinner.Duration,
		Value = Value,

		Labels = table.create(10),
		CanvasTweens = table.create(10),
	}
	local tweenInfo = TweenInfo.new(Spinner.Duration)

	local Frame = Instance.new("Frame")
	Frame.Name = "digit"
	Frame.LayoutOrder = LayoutOrder
	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.new(0, 0, 0, Spinner.TextSize + 6)
	Frame.ClipsDescendants = true

	local Canvas = Instance.new("Frame")
	Canvas.Name = "canvas"
	Canvas.Size = UDim2.new(1, 0, 10, 0)
	Canvas.BackgroundTransparency = 1
	Canvas.Parent = Frame

	Canvas.Position = UDim2.new(0, 0, -d.Value, 0)

	for i = 0, 9 do
		local n = Instance.new("TextLabel")
		n.Name = "n_" .. i
		n.BackgroundTransparency = 1
		n.TextSize = Spinner.TextSize
		n.TextColor3 = Spinner.TextColor3
		n.Font = Spinner.Font
		n.Text = i
		n.Size = UDim2.new(1, 0, 0.1, 0)
		n.Position = UDim2.new(0, 0, i * 0.1, 0)
		n.Parent = Canvas
		d.Labels[i] = n
		d.CanvasTweens[i] = TweenService:Create(Canvas, tweenInfo, { Position = UDim2.new(0, 0, -i, 0) })
	end

	Frame.Parent = Spinner.Frame

	local Size =
		TextService:GetTextSize("8", Spinner.TextSize, Spinner.Font, Vector2.new(Spinner.TextSize, use(Spinner.TextSize))
	TweenService:Create(Frame, sizeTweenInfo, { Size = UDim2.new(0, Size.X + 1, 0, Size.Y + 10) }):Play()

	local dProxy = setmetatable({}, {
		__index = function(_, key)
			local Direct = d[key]
			if Direct then
				return Direct
			end

			local Success = pcall(function()
				local _x = d.Labels[1][key]
			end)
			if Success then
				return d.Labels[1][key]
			end

			return nil
		end,
		__newindex = function(_, key, value)
			local Direct = d[key]
			if Direct then
				d[key] = value
				d:Update(key, value)
				return
			end

			local Success = pcall(function()
				local _x = d.Labels[1][key]
			end)
			if Success then
				for i = 0, 9 do
					d.Labels[i][key] = value
				end
				d:Update(key, value)
			end
		end,
	})

	function d:Destroy()
		local _Size = TextService:GetTextSize(
			"8",
			Spinner.TextSize,
			Spinner.Font,
			Vector2.new(Spinner.TextSize, Spinner.TextSize)
		)
		local shrinkTween = TweenService:Create(Frame, sizeTweenInfo, { Size = UDim2.new(0, 0, 0, _Size.Y + 10) })
		shrinkTween.Completed:Connect(function()
			Frame:Destroy()
			table.clear(d)
			shrinkTween:Destroy()
		end)
		shrinkTween:Play()
	end

	function d:Update(Type, _Value)
		if Type == "Duration" then
			tweenInfo = TweenInfo.new(_Value)
			for i = 0, 9 do
				d.CanvasTweens[i] = TweenService:Create(Canvas, tweenInfo, { Position = UDim2.new(0, 0, -i, 0) })
			end
		elseif Type == "Value" then
			d.CanvasTweens[_Value]:Play()
		elseif Type == "TextSize" or Type == "Font" then
			local _Size = TextService:GetTextSize(
				"8",
				Spinner.TextSize,
				Spinner.Font,
				Vector2.new(Spinner.TextSize, Spinner.TextSize)
			)
			TweenService:Create(Frame, sizeTweenInfo, { Size = UDim2.new(0, _Size.X + 1, 0, _Size.Y + 10) }):Play()
		end
	end

	return dProxy
end

return Digit
