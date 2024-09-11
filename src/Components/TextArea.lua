--[=[
		@class TextArea
		
		Like [`TextInput`](/api/TextInput), but dedicated for multi-line use-cases.
]=]

local OnyxUI = script.Parent.Parent
local Util = require(OnyxUI.Util)
local Fusion = require(OnyxUI.Packages.Fusion)

local InnerScope = Fusion.innerScope

local TextInput = require(OnyxUI.Components.TextInput)
local Components = {
	TextInput = TextInput,
}

export type Props = TextInput.Props & {}

--[=[
		@within TextArea
		@interface TextAreaProps

		@field ... TextInputProps
]=]
return function(Scope: Fusion.Scope<any>, Props: Props)
	local Scope = InnerScope(Scope, Fusion, Util, Components)

	return Scope:TextInput(Util.CombineProps(Props, {
		AutomaticSize = Enum.AutomaticSize.None,
		TextWrapped = true,
		MultiLine = true,
	}))
end
