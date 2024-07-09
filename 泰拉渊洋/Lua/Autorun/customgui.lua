if SERVER then return end -- we don't want server to run GUI code.

local modPath = ...

-- our main frame where we will put our custom GUI
local frame = GUI.Frame(GUI.RectTransform(Vector2(1, 1)), nil)
frame.CanBeFocused = false

-- menu frame
local menu = GUI.Frame(GUI.RectTransform(Vector2(1, 1), frame.RectTransform, GUI.Anchor.Center), nil)
menu.CanBeFocused = false
menu.Visible = false

-- put a button that goes behind the menu content, so we can close it when we click outside
local closeButton = GUI.Button(GUI.RectTransform(Vector2(10, 10), menu.RectTransform, GUI.Anchor.Center), "", GUI.Alignment.Center, nil)
closeButton.OnClicked = function ()
    menu.Visible = not menu.Visible
end

-- a button top right of our screen to open a sub-frame menu
local button = GUI.Button(GUI.RectTransform(Vector2(0.2,0.2), frame.RectTransform, GUI.Anchor.TopRight), "button", GUI.Alignment.Center, "GUIButtonSmall")
button.RectTransform.AbsoluteOffset = Point(25, 50)
button.OnClicked = function ()
    menu.Visible = not menu.Visible
end

local menuContent = GUI.Frame(GUI.RectTransform(Vector2(0.4, 0.6), menu.RectTransform, GUI.Anchor.Center))
local menuList = GUI.ListBox(GUI.RectTransform(Vector2(1, 1), menuContent.RectTransform, GUI.Anchor.BottomCenter))

local imageFrame = GUI.Frame(GUI.RectTransform(Point(65, 65), menuList.Content.RectTransform), "GUITextBox")
imageFrame.RectTransform.MinSize = Point(0, 65)
local sprite = ItemPrefab.GetItemPrefab("leo2").InventoryIcon
local image = GUI.Image(GUI.RectTransform(Vector2(1, 1), imageFrame.RectTransform, GUI.Anchor.Center), sprite)
image.ToolTip = "fuck"


local dropDown = GUI.DropDown(GUI.RectTransform(Vector2(1, 0.05), menuList.Content.RectTransform), "This is a dropdown", 3, nil, false)
dropDown.AddItem("First Item", 0)
dropDown.AddItem("Second Item", 1)
dropDown.AddItem("Third Item", 2)
dropDown.OnSelected = function (guiComponent, object)
    print(object)
end

local customImageFrame = GUI.Frame(GUI.RectTransform(Point(512, 512), menuList.Content.RectTransform), "GUITextBox")
customImageFrame.RectTransform.MinSize = Point(512,512)
local customSprite = Sprite(modPath .. "/long.png")
GUI.Image(GUI.RectTransform(Point(65, 65), customImageFrame.RectTransform, GUI.Anchor.Center), customSprite)


Hook.Patch("Barotrauma.GameScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)

Hook.Patch("Barotrauma.SubEditorScreen", "AddToGUIUpdateList", function()
    frame.AddToGUIUpdateList()
end)