local OnyxUI = require(script.Parent.Parent)
local CombineProps = require(script.Parent.Parent.Utils.CombineProps)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Fusion = require(OnyxUI.Packages.Fusion)

local Computed = Fusion.Computed

local Image = require(script.Parent.Image)
local Themer = require(script.Parent.Parent.Utils.Themer)

type Props = Image.Props & {}

local function Text(Props: Props)
	local Name = EnsureValue(Props.Name, "string", "Icon")
	local Size = EnsureValue(
		Props.Size,
		"number",
		Computed(function()
			return UDim2.fromOffset(Themer.Theme.TextSize["1"]:get(), Themer.Theme.TextSize["1"]:get())
		end)
	)
	local BackgroundTransparency = EnsureValue(Props.BackgroundTransparency, "number", 1)

	return Image(CombineProps(Props, {
		Name = Name,
		Size = Size,
		BackgroundTransparency = BackgroundTransparency,
	}))
end

return Text
