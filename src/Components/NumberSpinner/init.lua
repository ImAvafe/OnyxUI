local OnyxUI = require(script.Parent.Parent)
local Fusion = require(OnyxUI.Packages.Fusion)
local NumberSpinner = require(script.NumberSpinner)
local EnsureValue = require(OnyxUI.Utils.EnsureValue)
local Themer = require(OnyxUI.Utils.Themer)

local Cleanup = Fusion.Cleanup
local Observer = Fusion.Observer
local Computed = Fusion.Computed

local Text = require(OnyxUI.Components.Text)

local SPINNER_PROPS = { "Value", "Prefix", "Suffix", "Decimals", "Duration", "Commas" }

return function(Props: { [any]: any })
	Props.Name = EnsureValue(Props.Name, "string", "NumberSpinner")
	Props.AutomaticSize = EnsureValue(Props.AutomaticSize, "EnumItem", Enum.AutomaticSize.None)
	Props.TextSize = EnsureValue(Props.TextSize, "number", Themer.Theme.TextSize["1"])
	Props.Size = EnsureValue(
		Props.Size,
		"UDim2",
		Computed(function()
			return UDim2.new(UDim.new(1, 0), UDim.new(0, Props.TextSize:get()))
		end)
	)
	Props.Font = EnsureValue(Props.Font, "EnumItem", Enum.Font.GothamBold)

	Props.Value = EnsureValue(Props.Value, "number", 0)
	Props.Prefix = EnsureValue(Props.Prefix, "string", "")
	Props.Suffix = EnsureValue(Props.Suffix, "string", "")
	Props.Decimals = EnsureValue(Props.Decimals, "number", 0)
	Props.Duration = EnsureValue(Props.Duration, "number", 0.3)
	Props.Commas = EnsureValue(Props.Commas, "boolean", false)

	local PropObservers = {}

	local Spinner = NumberSpinner.fromGuiObject(Text {
		Name = Props.Name,
		Parent = Props.Parent,
		Position = Props.Position,
		Rotation = Props.Rotation,
		AnchorPoint = Props.AnchorPoint,
		Size = Props.Size,
		AutomaticSize = Props.AutomaticSize,
		Visible = Props.Visible,
		ZIndex = Props.ZIndex,
		LayoutOrder = Props.LayoutOrder,
		ClipsDescendants = Props.ClipsDescendants,
		Active = Props.Active,
		Selectable = Props.Selectable,
		Interactable = Props.Interactable,
		BackgroundColor3 = Props.BackgroundColor3,
		BackgroundTransparency = Props.BackgroundTransparency,

		RichText = Props.RichText,
		TextSize = Props.TextSize,
		TextColor3 = Props.TextColor3,
		FontFace = Props.FontFace,
		Font = Props.Font,
		TextScaled = Props.TextScaled,
		Text = Props.Text,
		TextWrapped = Props.TextWrapped,
		TextXAlignment = Props.TextXAlignment,
		TextYAlignment = Props.TextYAlignment,
		TextTruncate = Props.TextTruncate,
		AutoLocalize = Props.AutoLocalize,
		LineHeight = Props.LineHeight,
		LocalizedText = Props.LocalizedText,
		MaxVisibleGraphemes = Props.MaxVisibleGraphemes,
		TextTransparency = Props.TextTransparency,

		[Cleanup] = PropObservers,
	})

	for _, PROP_NAME in ipairs(SPINNER_PROPS) do
		Spinner[PROP_NAME] = Props[PROP_NAME]:get()
		table.insert(
			PropObservers,
			Observer(Props[PROP_NAME]):onChange(function()
				Spinner[PROP_NAME] = Props[PROP_NAME]:get()
			end)
		)
	end

	return Spinner.GuiObject
end
