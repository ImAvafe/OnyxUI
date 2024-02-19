local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)

local Children = Fusion.Children
local New = Fusion.New

local Components = script.Parent.Parent.Components
local MenuFrame = require(Components.MenuFrame)
local Button = require(Components.Button)
local AutoScaleFrame = require(Components.AutoScaleFrame)
local TitleBar = require(Components.TitleBar)
local ScrollingFrame = require(Components.ScrollingFrame)
local SettingToggle = require(NekaUI.Extras.SettingToggle)

local function SettingsMenu(Props)
  return AutoScaleFrame {
    Parent = Props.Parent,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    BaseResolution = Vector2.new(883, 893),

    [Children] = {
      New "UIListLayout" {},
      MenuFrame {
        Size = UDim2.fromOffset(330, 0),

        [Children] = {
          TitleBar {
            Title = "Settings",
          },
          ScrollingFrame {
            Size = UDim2.new(UDim.new(1, 0), UDim.new(0, 135)),
            AutomaticSize = Enum.AutomaticSize.None,

            [Children] = {
              New "UIListLayout" {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 10),
              },
              New "UIPadding" {
                PaddingTop = UDim.new(0, 2),
                PaddingBottom = UDim.new(0, 3),
                PaddingRight = UDim.new(0, 2),
              },
              SettingToggle {
                Label = "Music",
                SwitchedOn = true,
              },
              SettingToggle {
                Label = "Low quality",
              },
              SettingToggle {
                Label = "Copyrighted audio",
                SwitchedOn = true,
              },
              SettingToggle {
                Label = "Infinite Bobux",
                Disabled = true,
              },
              SettingToggle {
                Label = "Something else",
              },
              SettingToggle {
                Label = "Nothing same",
              },
            },
          },
          Button {
            Contents = {"Apply"},
            Size = UDim2.fromScale(1, 0),
            Style = "Filled",
            AutomaticSize = Enum.AutomaticSize.Y
          },
        }
      }
    }
  }
end

return SettingsMenu