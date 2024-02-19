local NekaUI = script.Parent.Parent

local Fusion = require(NekaUI.Packages.Fusion)
local Finalize = require(NekaUI.Utils.Finalize)
local EnsureProp = require(NekaUI.Utils.EnsureProp)

local New = Fusion.New
local Children = Fusion.Children

local function Text(Props)
  Props.TextColor3 = EnsureProp(Props.TextColor3, "Color3", Color3.fromRGB(255, 255, 255))
  Props.TextSize = EnsureProp(Props.TextSize, "number", 18)
  Props.RichText = EnsureProp(Props.RichText, "boolean", false)
  Props.FontFace = EnsureProp(Props.FontFace, "Font", Font.fromEnum(Enum.Font.GothamMedium))
  Props.ClipsDescendants = EnsureProp(Props.ClipsDescendants, "boolean", true)

  return Finalize(New "TextLabel" {
    Name = Props.Name or "Text",
    Parent = Props.Parent,
    LayoutOrder = Props.LayoutOrder,
    Position = Props.Position,
    AnchorPoint = Props.AnchorPoint,
    Size = Props.Size,
    AutomaticSize = Props.AutomaticSize or Enum.AutomaticSize.XY,
    ZIndex = Props.ZIndex,
    Visible = Props.Visible,

    BackgroundTransparency = 1,
    ClipsDescendants = Props.ClipsDescendants,

    RichText = Props.RichText,
    TextSize = Props.TextSize,
    TextColor3 = Props.TextColor3,
    FontFace = Props.FontFace,
    TextScaled = Props.TextScaled,
    Text = Props.Text,
    TextWrapped = Props.TextWrapped,
    TextXAlignment = Props.TextXAlignment or Enum.TextXAlignment.Left,
    TextYAlignment = Props.TextYAlignment or Enum.TextYAlignment.Top,
    TextTruncate = Props.TextTruncate,
    AutoLocalize = Props.AutoLocalize,

    [Children] = Props[Children]
  })
end

return Text