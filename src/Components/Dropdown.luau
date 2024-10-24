local OnyxUI = script.Parent.Parent
local Fusion = require(OnyxUI.Parent.Fusion)
local Util = require(OnyxUI.Util)
local Themer = require(OnyxUI.Themer)

local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

local Base = require(OnyxUI.Components.Base)
local Components = {
	TextInput = require(OnyxUI.Components.TextInput),
	Frame = require(OnyxUI.Components.Frame),
}

export type Props = Base.Props & {
	Open: Fusion.UsedAs<boolean>?,
}

return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = Fusion.innerScope(Scope, Fusion, Components, Util)
	local Theme = Themer.Theme:now()

	local Open = Scope:EnsureValue(Util.Fallback(Props.Open, false))

	return Scope:Hydrate(Scope:TextInput(Util.CombineProps(Props, {
		Name = script.Name,
		Parent = Props.Parent,
		StrokeColor = Theme.Colors.NeutralContent.Dark,
		PlaceholderText = "Dropdown",
		-- TextEditable = false,

		[Children] = {
			Scope:Computed(function(Use)
				if Use(Open) then
					return Scope:New "Folder" {
						[Children] = {
							Scope:Frame {
								AnchorPoint = Vector2.new(0, 1),
								Position = UDim2.fromScale(0, 1),
								Size = UDim2.fromScale(1, 1),
								BackgroundTransparency = 0,
							},
						},
					}
				end
			end),
		},
	}))) {
		[OnEvent "Focused"] = function()
			Open:set(true)
		end,
		[OnEvent "FocusLost"] = function()
			Open:set(false)
		end,
	}
end
