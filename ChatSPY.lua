-- ====================================================================
-- NYXARA CHAT SPY V2 (KUSURSUZ MENÜ İKONU & DISCORD FİLTRE)
-- ====================================================================

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

if CoreGui:FindFirstChild("NyxaraChatSpy") then CoreGui.NyxaraChatSpy:Destroy() end

local SG = Instance.new("ScreenGui", CoreGui)
SG.Name = "NyxaraChatSpy"

-- Ana Çerçeve
local MainFrame = Instance.new("Frame", SG)
MainFrame.Size = UDim2.new(0, 450, 0, 280)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Active = true; MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local Stroke = Instance.new("UIStroke", MainFrame)
Stroke.Color = Color3.fromRGB(150, 150, 150)

-- Üst Bar ve Kontroller
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(0, 90, 1, 0); Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1; Title.Text = "NYXARA SPY"; Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold; Title.TextSize = 12; Title.TextXAlignment = Enum.TextXAlignment.Left

-- Kelime Arama Çubuğu
local SearchBox = Instance.new("TextBox", TopBar)
SearchBox.Size = UDim2.new(0, 160, 0, 24); SearchBox.Position = UDim2.new(0, 105, 0, 5)
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 35); SearchBox.TextColor3 = Color3.new(1, 1, 1)
SearchBox.Font = Enum.Font.Gotham; SearchBox.TextSize = 11; SearchBox.PlaceholderText = "Mesajlarda ara..."; SearchBox.Text = ""
Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0, 4)

-- Butonlar
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 30, 0, 35); CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundTransparency = 1; CloseBtn.Text = "X"; CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50); CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.TextSize = 14

local CollapseBtn = Instance.new("TextButton", TopBar)
CollapseBtn.Size = UDim2.new(0, 30, 0, 35); CollapseBtn.Position = UDim2.new(1, -60, 0, 0)
CollapseBtn.BackgroundTransparency = 1; CollapseBtn.Text = "-"; CollapseBtn.TextColor3 = Color3.new(1, 1, 1); CollapseBtn.Font = Enum.Font.GothamBold; CollapseBtn.TextSize = 16

-- ÜÇ ÇİZGİ MENÜ BUTONU (Dikdörtgen sorunu çözüldü)
local MenuBtn = Instance.new("TextButton", TopBar)
MenuBtn.Size = UDim2.new(0, 30, 0, 35); MenuBtn.Position = UDim2.new(1, -90, 0, 0)
MenuBtn.BackgroundTransparency = 1; MenuBtn.Text = "" -- Yazıyı sildik

-- Çizgileri Frame ile oluşturuyoruz
local line1 = Instance.new("Frame", MenuBtn)
line1.Size = UDim2.new(0, 14, 0, 2); line1.Position = UDim2.new(0.5, -7, 0.5, -5)
line1.BackgroundColor3 = Color3.new(1, 1, 1); line1.BorderSizePixel = 0

local line2 = Instance.new("Frame", MenuBtn)
line2.Size = UDim2.new(0, 14, 0, 2); line2.Position = UDim2.new(0.5, -7, 0.5, 0)
line2.BackgroundColor3 = Color3.new(1, 1, 1); line2.BorderSizePixel = 0

local line3 = Instance.new("Frame", MenuBtn)
line3.Size = UDim2.new(0, 14, 0, 2); line3.Position = UDim2.new(0.5, -7, 0.5, 5)
line3.BackgroundColor3 = Color3.new(1, 1, 1); line3.BorderSizePixel = 0

-- Chat Mesaj Konteyneri
local LogContainer = Instance.new("ScrollingFrame", MainFrame)
LogContainer.Size = UDim2.new(1, -20, 1, -45); LogContainer.Position = UDim2.new(0, 10, 0, 40)
LogContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 18); LogContainer.ScrollBarThickness = 3
LogContainer.CanvasSize = UDim2.new(0, 0, 0, 0); LogContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", LogContainer).CornerRadius = UDim.new(0, 6)
local LogLayout = Instance.new("UIListLayout", LogContainer); LogLayout.SortOrder = Enum.SortOrder.LayoutOrder; LogLayout.Padding = UDim.new(0, 4)

-- Oyuncu Filtreleme Yan Paneli
local PlayerFrame = Instance.new("Frame", MainFrame)
PlayerFrame.Size = UDim2.new(0, 150, 1, -35); PlayerFrame.Position = UDim2.new(1, 0, 0, 35)
PlayerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30); PlayerFrame.BorderSizePixel = 0
local SideStroke = Instance.new("UIStroke", PlayerFrame); SideStroke.Color = Color3.fromRGB(45, 45, 50)

local PSearchBox = Instance.new("TextBox", PlayerFrame)
PSearchBox.Size = UDim2.new(1, -10, 0, 24); PSearchBox.Position = UDim2.new(0, 5, 0, 5)
PSearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40); PSearchBox.TextColor3 = Color3.new(1, 1, 1)
PSearchBox.Font = Enum.Font.Gotham; PSearchBox.TextSize = 11; PSearchBox.PlaceholderText = "Oyuncu ara..."; PSearchBox.Text = ""
Instance.new("UICorner", PSearchBox).CornerRadius = UDim.new(0, 4)

local PlayerContainer = Instance.new("ScrollingFrame", PlayerFrame)
PlayerContainer.Size = UDim2.new(1, -10, 1, -40); PlayerContainer.Position = UDim2.new(0, 5, 0, 35)
PlayerContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25); PlayerContainer.ScrollBarThickness = 2
PlayerContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
local PLayout = Instance.new("UIListLayout", PlayerContainer); PLayout.Padding = UDim.new(0, 2)

-- Boyutlandırma Tutamacı
local ResizeHandle = Instance.new("TextButton", MainFrame)
ResizeHandle.Size = UDim2.new(0, 15, 0, 15); ResizeHandle.Position = UDim2.new(1, -15, 1, -15)
ResizeHandle.BackgroundTransparency = 1; ResizeHandle.Text = "◢"; ResizeHandle.TextColor3 = Color3.fromRGB(100, 100, 100); ResizeHandle.TextSize = 12

-- Hafıza Yapısı
local chatLogs = {}
local textFilter = ""
local playerFilter = ""

local function appendLog(senderName, messageText)
    local timestamp = os.date("%X")
    local displayString = string.format("[%s] %s: %s", timestamp, senderName, messageText)
    table.insert(chatLogs, {sender = senderName, msg = messageText, full = displayString})
    updateChatUI()
end

local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
if chatEvents and chatEvents:FindFirstChild("OnMessageDoneFiltering") then
    chatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(data)
        if data and data.FromSpeaker and data.Message then
            appendLog(tostring(data.FromSpeaker), tostring(data.Message))
        end
    end)
end
TextChatService.MessageReceived:Connect(function(msgData)
    if msgData.TextSource and msgData.Text then
        appendLog(msgData.TextSource.Name, msgData.Text)
    end
end)

function updateChatUI()
    for _, child in pairs(LogContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for _, log in pairs(chatLogs) do
        local matchesText = textFilter == "" or string.find(string.lower(log.full), string.lower(textFilter))
        local matchesPlayer = playerFilter == "" or log.sender == playerFilter

        if matchesText and matchesPlayer then
            local MsgRow = Instance.new("TextButton", LogContainer)
            MsgRow.Size = UDim2.new(1, -5, 0, 0); MsgRow.AutomaticSize = Enum.AutomaticSize.Y
            MsgRow.BackgroundTransparency = 1; MsgRow.Text = log.full
            MsgRow.TextColor3 = Color3.fromRGB(225, 225, 230); MsgRow.Font = Enum.Font.Gotham; MsgRow.TextSize = 11
            MsgRow.TextWrapped = true; MsgRow.TextXAlignment = Enum.TextXAlignment.Left; MsgRow.TextYAlignment = Enum.TextYAlignment.Top
            
            MsgRow.MouseButton1Click:Connect(function()
                if setclipboard then
                    setclipboard(log.full)
                    MsgRow.TextColor3 = Color3.fromRGB(0, 255, 120)
                    task.wait(0.4)
                    if MsgRow then MsgRow.TextColor3 = Color3.fromRGB(225, 225, 230) end
                end
            end)
        end
    end
end

function updatePlayerPanel()
    for _, child in pairs(PlayerContainer:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local ResetBtn = Instance.new("TextButton", PlayerContainer)
    ResetBtn.Size = UDim2.new(1, 0, 0, 22); ResetBtn.BackgroundColor3 = playerFilter == "" and Color3.fromRGB(45, 85, 155) or Color3.fromRGB(30, 30, 35)
    ResetBtn.Text = "[ Herkesi Göster ]"; ResetBtn.TextColor3 = Color3.new(1,1,1); ResetBtn.Font = Enum.Font.GothamBold; ResetBtn.TextSize = 10
    ResetBtn.MouseButton1Click:Connect(function() playerFilter = ""; updatePlayerPanel(); updateChatUI() end)

    local searchLower = string.lower(PSearchBox.Text)
    for _, player in pairs(Players:GetPlayers()) do
        if searchLower == "" or string.find(string.lower(player.Name), searchLower) then
            local PBtn = Instance.new("TextButton", PlayerContainer)
            PBtn.Size = UDim2.new(1, 0, 0, 22)
            PBtn.BackgroundColor3 = playerFilter == player.Name and Color3.fromRGB(45, 135, 85) or Color3.fromRGB(30, 30, 35)
            PBtn.Text = player.Name; PBtn.TextColor3 = Color3.new(1,1,1); PBtn.Font = Enum.Font.Gotham; PBtn.TextSize = 10
            
            PBtn.MouseButton1Click:Connect(function()
                playerFilter = (playerFilter == player.Name) and "" or player.Name
                updatePlayerPanel(); updateChatUI()
            end)
        end
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function() textFilter = SearchBox.Text; updateChatUI() end)
PSearchBox:GetPropertyChangedSignal("Text"):Connect(function() updatePlayerPanel() end)

local menuToggled = false
MenuBtn.MouseButton1Click:Connect(function()
    menuToggled = not menuToggled
    if menuToggled then
        updatePlayerPanel()
        PlayerFrame:TweenPosition(UDim2.new(1, -150, 0, 35), "Out", "Quart", 0.25, true)
        LogContainer.Size = UDim2.new(1, -165, 1, -45)
    else
        PlayerFrame:TweenPosition(UDim2.new(1, 0, 0, 35), "Out", "Quart", 0.25, true)
        LogContainer.Size = UDim2.new(1, -20, 1, -45)
    end
end)

local isCollapsed = false; local lastHeight = 280
CollapseBtn.MouseButton1Click:Connect(function()
    isCollapsed = not isCollapsed
    if isCollapsed then
        lastHeight = MainFrame.AbsoluteSize.Y
        MainFrame.Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, 35)
        CollapseBtn.Text = "+"; LogContainer.Visible = false; PlayerFrame.Visible = false; ResizeHandle.Visible = false
    else
        MainFrame.Size = UDim2.new(0, MainFrame.AbsoluteSize.X, 0, lastHeight)
        CollapseBtn.Text = "-"; LogContainer.Visible = true; PlayerFrame.Visible = true; ResizeHandle.Visible = true
    end
end)

CloseBtn.MouseButton1Click:Connect(function() SG:Destroy() end)

local isResizing = false; local startPos = nil; local sizeOrigin = nil
ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isResizing = true; startPos = input.Position; sizeOrigin = MainFrame.AbsoluteSize
    end
end)
UIS.InputChanged:Connect(function(input)
    if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - startPos
        MainFrame.Size = UDim2.new(0, math.max(380, sizeOrigin.X + delta.X), 0, math.max(180, sizeOrigin.Y + delta.Y))
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then isResizing = false end
end)
