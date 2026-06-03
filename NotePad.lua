local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")

if CoreGui:FindFirstChild("ProfesorNotepad") then
    CoreGui.NyxaraNotepad:Destroy()
end

local SG = Instance.new("ScreenGui")
SG.Name = "NyxaraNotepad"
SG.Parent = CoreGui

local MainFrame = Instance.new("Frame", SG)
MainFrame.Size = UDim2.new(0, 450, 0, 250)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 150, 255)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -120, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PROFESOR NOTEPAD"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16

local CollapseBtn = Instance.new("TextButton", TopBar)
CollapseBtn.Size = UDim2.new(0, 30, 0, 30)
CollapseBtn.Position = UDim2.new(1, -60, 0, 0)
CollapseBtn.BackgroundTransparency = 1
CollapseBtn.Text = "-"
CollapseBtn.TextColor3 = Color3.new(1, 1, 1)
CollapseBtn.Font = Enum.Font.GothamBold
CollapseBtn.TextSize = 18

local CopyAllBtn = Instance.new("TextButton", TopBar)
CopyAllBtn.Size = UDim2.new(0, 30, 0, 30)
CopyAllBtn.Position = UDim2.new(1, -90, 0, 0)
CopyAllBtn.BackgroundTransparency = 1
CopyAllBtn.Text = "📋"
CopyAllBtn.TextColor3 = Color3.new(1, 1, 1)
CopyAllBtn.Font = Enum.Font.GothamBold
CopyAllBtn.TextSize = 14

local ClearBtn = Instance.new("TextButton", TopBar)
ClearBtn.Size = UDim2.new(0, 30, 0, 30)
ClearBtn.Position = UDim2.new(1, -120, 0, 0)
ClearBtn.BackgroundTransparency = 1
ClearBtn.Text = "🗑️"
ClearBtn.TextColor3 = Color3.new(1, 1, 1)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextSize = 14

local NoteBox = Instance.new("TextBox", MainFrame)
NoteBox.Size = UDim2.new(1, -20, 1, -55)
NoteBox.Position = UDim2.new(0, 10, 0, 35)
NoteBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
NoteBox.TextColor3 = Color3.new(1, 1, 1)
NoteBox.Font = Enum.Font.Gotham
NoteBox.TextSize = 12
NoteBox.TextXAlignment = Enum.TextXAlignment.Left
NoteBox.TextYAlignment = Enum.TextYAlignment.Top
NoteBox.MultiLine = true
NoteBox.TextWrapped = true
NoteBox.ClearTextOnFocus = false
NoteBox.Text = ""
NoteBox.PlaceholderText = "Buraya raporlarını veya notlarını yaz...\n\nSatır atlamak için Enter'a bas.\nBoyutu ayarlamak için sağ alt köşeden sürükle."
Instance.new("UICorner", NoteBox).CornerRadius = UDim.new(0, 6)

local UIPadding = Instance.new("UIPadding", NoteBox)
UIPadding.PaddingTop = UDim.new(0, 8)
UIPadding.PaddingBottom = UDim.new(0, 8)
UIPadding.PaddingLeft = UDim.new(0, 8)
UIPadding.PaddingRight = UDim.new(0, 8)

local ResizeHandle = Instance.new("TextButton", MainFrame)
ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
ResizeHandle.BackgroundTransparency = 1
ResizeHandle.Text = "◢"
ResizeHandle.TextColor3 = Color3.fromRGB(150, 150, 150)
ResizeHandle.TextSize = 16
ResizeHandle.Font = Enum.Font.GothamBold

NoteBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        NoteBox.Text = NoteBox.Text .. "\n"
        task.wait()
        NoteBox:CaptureFocus()
        NoteBox.CursorPosition = #NoteBox.Text + 1
    end
end)

local draggingResize = false
local dragStartPos = nil
local startSize = nil

ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingResize = true
        dragStartPos = input.Position
        startSize = MainFrame.AbsoluteSize
    end
end)

UIS.InputChanged:Connect(function(input)
    if draggingResize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartPos
        local newWidth = math.max(250, startSize.X + delta.X)
        local newHeight = math.max(150, startSize.Y + delta.Y)
        MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingResize = false
    end
end)

local function copyFeedback()
    CopyAllBtn.Text = "✔️"
    CopyAllBtn.TextColor3 = Color3.fromRGB(40, 200, 80)
    task.wait(1)
    if CopyAllBtn then
        CopyAllBtn.Text = "📋"
        CopyAllBtn.TextColor3 = Color3.new(1, 1, 1)
    end
end

CopyAllBtn.MouseButton1Click:Connect(function()
    if NoteBox.Text ~= "" and setclipboard then 
        setclipboard(NoteBox.Text) 
        task.spawn(copyFeedback)
    end
end)

ClearBtn.MouseButton1Click:Connect(function()
    NoteBox.Text = ""
end)

local isCollapsed = false
local savedHeight = 250

CollapseBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    if isCollapsed then
        savedHeight = MainFrame.AbsoluteSize.Y 
        MainFrame.Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 30)
        CollapseBtn.Text = "+"
        NoteBox.Visible = false
        ResizeHandle.Visible = false
    else
        MainFrame.Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, savedHeight) 
        CollapseBtn.Text = "-"
        NoteBox.Visible = true
        ResizeHandle.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    SG:Destroy()
end)
