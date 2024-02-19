local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)

local New = Fusion.New
local Children = Fusion.Children
local Computed = Fusion.Computed

local Components = script.Parent
local Frame = require(Components.Frame)

local function MenuFrame(Props)
  return New "CanvasGroup" {
    Name = Props.Name or "MenuFrame",
    Parent = Props.Parent,
    LayoutOrder = Props.LayoutOrder,
    Position = Props.Position,
    AnchorPoint = Props.AnchorPoint,
    Size = Props.Size,
    AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.Y,
    ZIndex = Props.ZIndex,

    GroupTransparency = Props.GroupTransparency,
    
    BackgroundColor3 = Color3.fromRGB(26, 26, 26),
    BackgroundTransparency = 0.015,

    [Children] = {
      New "UICorner" {
        CornerRadius = UDim.new(0, 15)
      },
      New "UIStroke" {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(50, 50, 50),
        Thickness = 2,
      },
      Frame {
        Name = "Contents",
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.fromScale(1, 0),

        [Children] = {
          Computed(function()
            local UIListLayout
            for _, Child in ipairs(Props[Children]) do
              if Child:IsA("UIListLayout") then
                UIListLayout = Child
              end
            end
            if not UIListLayout then
              return New "UIListLayout" {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 15),
                HorizontalAlignment = Enum.HorizontalAlignment.Left
              }
            end
          end, Fusion.cleanup),

          Props[Children]
        }
      },
      Props.TopChildren,
    }
  }
end

return MenuFrame