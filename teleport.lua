--=========================================
-- NX HUB V14 // ANIMATED, DRAGGABLE & FULL LOCALIZED
--=========================================

local getgenv = getgenv or function() return _G end
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LP = Players.LocalPlayer

-- [1] TEMİZLİK
if getgenv().NXHubLoaded then
    pcall(function() CoreGui.Nyxara_Hub_UI:Destroy() end)
    pcall(function() LP.PlayerGui.Nyxara_Hub_UI:Destroy() end)
end
getgenv().NXHubLoaded = true

-- [2] ANA GUI OLUŞTURMA
local UI = Instance.new("ScreenGui")
UI.Name = "Nyxara_Hub_UI"
UI.ResetOnSpawn = false
local suc = pcall(function() UI.Parent = CoreGui end)
if not suc then UI.Parent = LP:WaitForChild("PlayerGui") end

local CurrentThemeColor = Color3.fromRGB(192, 192, 192)
local CurrentLang = "TR"

-- === AÇ/KAPAT LOGOSU (SÜRÜKLENEBİLİR) ===
local ToggleLogo = Instance.new("ImageButton", UI)
ToggleLogo.Size = UDim2.new(0, 50, 0, 50)
ToggleLogo.Position = UDim2.new(0, 20, 0, 20)
ToggleLogo.Image = "rbxassetid://96148255051218"
ToggleLogo.BackgroundTransparency = 1
ToggleLogo.Visible = false 

-- Sürükleme Mantığı (Drag)
local dragging, dragInput, dragStart, startPos
ToggleLogo.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true; dragStart = input.Position; startPos = ToggleLogo.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
ToggleLogo.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleLogo.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- [3] YÜZEN SAĞ MENÜ
local Sidebar = Instance.new("Frame", UI)
Sidebar.Size = UDim2.new(0, 60, 0, 320)
Sidebar.Position = UDim2.new(1, -80, 0.5, 0)
Sidebar.AnchorPoint = Vector2.new(1, 0.5)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.BorderSizePixel = 0
Sidebar.ClipsDescendants = true
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 30)

local SidebarStroke = Instance.new("UIStroke", Sidebar)
SidebarStroke.Color = CurrentThemeColor; SidebarStroke.Thickness = 2

local SidebarLayout = Instance.new("UIListLayout", Sidebar)
SidebarLayout.Padding = UDim.new(0, 10); SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- [4] ANA İÇERİK PANELİ
local MainPanel = Instance.new("Frame", UI)
MainPanel.Size = UDim2.new(0, 500, 0, 350)
MainPanel.Position = UDim2.new(0.5, -40, 0.5, 0)
MainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
MainPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainPanel.BorderSizePixel = 0
MainPanel.ClipsDescendants = true
Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 15)

local MainStroke = Instance.new("UIStroke", MainPanel)
MainStroke.Color = CurrentThemeColor; MainStroke.Thickness = 2

local TitleBar = Instance.new("Frame", MainPanel)
TitleBar.Size = UDim2.new(1, 0, 0, 40); TitleBar.BackgroundTransparency = 1

local TitleLine = Instance.new("Frame", TitleBar)
TitleLine.Size = UDim2.new(1, 0, 0, 1); TitleLine.Position = UDim2.new(0, 0, 1, -1)
TitleLine.BackgroundColor3 = CurrentThemeColor; TitleLine.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Size = UDim2.new(1, -20, 1, 0); TitleText.Position = UDim2.new(0, 20, 0, 0)
TitleText.BackgroundTransparency = 1; TitleText.TextColor3 = CurrentThemeColor
TitleText.Font = Enum.Font.GothamBold; TitleText.TextSize = 16; TitleText.TextXAlignment = Enum.TextXAlignment.Left

local ContentArea = Instance.new("Frame", MainPanel)
ContentArea.Size = UDim2.new(1, -20, 1, -50); ContentArea.Position = UDim2.new(0, 10, 0, 45)
ContentArea.BackgroundTransparency = 1

-- Animasyonlu Aç/Kapat
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local function ToggleUI(state)
    if state then
        ToggleLogo.Visible = false
        MainPanel.Visible = true; Sidebar.Visible = true
        TweenService:Create(MainPanel, tweenInfo, {Size = UDim2.new(0, 500, 0, 350)}):Play()
        TweenService:Create(Sidebar, tweenInfo, {Size = UDim2.new(0, 60, 0, 320)}):Play()
    else
        local t1 = TweenService:Create(MainPanel, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
        local t2 = TweenService:Create(Sidebar, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
        t1:Play(); t2:Play()
        t1.Completed:Wait()
        MainPanel.Visible = false; Sidebar.Visible = false
        ToggleLogo.Visible = true
    end
end
ToggleLogo.MouseButton1Click:Connect(function() ToggleUI(true) end)

-- [5] FULL DİL VERİTABANI
local LangData = {
    TR = { 
        Home = "Ana Sayfa", Saved = "Kayıtlı Koordinatlar", Manual = "Manuel Işınlanma", Scripts = "Harici Scriptler", Settings = "Sistem Ayarları",
        Welcome = "Hoş Geldin, Albayım.", Info = "Discord: discord.gg/erenforces",
        SavePlace = "Kaydedilecek yeri adlandır...", SaveBtn = "KAYDET", GetPosBtn = "📍 MEVCUT KONUMU AL",
        ManualPlace = "CFrame veya Koordinat Gir...", TpBtn = "IŞINLAN", CopyBtn = "MEVCUT KOORDİNATI KOPYALA",
        LangLbl = "Dil / Language:", ThemeLbl = "Tema Rengi:"
    },
    EN = { 
        Home = "Home Page", Saved = "Saved Coordinates", Manual = "Manual Teleport", Scripts = "External Scripts", Settings = "System Settings",
        Welcome = "Welcome, Colonel.", Info = "Discord: discord.gg/erenforces",
        SavePlace = "Name the location...", SaveBtn = "SAVE", GetPosBtn = "📍 GET CURRENT POSITION",
        ManualPlace = "Enter CFrame or Coordinates...", TpBtn = "TELEPORT", CopyBtn = "COPY CURRENT COORD",
        LangLbl = "Language:", ThemeLbl = "Theme Color:"
    }
}

-- [6] SEKME MANTIĞI
local Tabs = {}
local function CreateTab(langKey, iconText)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0, 40, 0, 40); btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35); btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.Font = Enum.Font.Gotham; btn.TextSize = 22; btn.Text = iconText
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)
    
    local page = Instance.new("Frame", ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0); page.BackgroundTransparency = 1; page.Visible = false
    
    Tabs[langKey] = {Btn = btn, Page = page}
    
    btn.MouseButton1Click:Connect(function()
        for key, data in pairs(Tabs) do
            if key == langKey then
                data.Page.Visible = true; data.Btn.BackgroundColor3 = CurrentThemeColor; data.Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
                TitleText.Text = LangData[CurrentLang][key]
            else
                data.Page.Visible = false; data.Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35); data.Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
    end)
    return page
end

local TabHome = CreateTab("Home", "⌂")
local TabSaved = CreateTab("Saved", "★")
local TabManual = CreateTab("Manual", "▶︎")
local TabScripts = CreateTab("Scripts", "≡")
local TabSettings = CreateTab("Settings", "⚙")

local CloseBtn = Instance.new("TextButton", Sidebar)
CloseBtn.Size = UDim2.new(0, 40, 0, 40); CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30); CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.Font = Enum.Font.GothamBlack; CloseBtn.TextSize = 16; CloseBtn.Text = "X" -- DİKDÖRTGEN HATASI İÇİN SABİT X HARFİ
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1, 0)
CloseBtn.MouseButton1Click:Connect(function() ToggleUI(false) end)

-- UI ELEMENT REFERANSLARI (Dil değişimi için)
local WelcomeLbl, InfoText, CoordNameInput, SaveCoordBtn, GetLocBtn, ManualInput, ManualTpBtn, CopyCfBtn, LangLbl, ThemeLbl

-- [7] İÇERİKLERİ DOLDURMA

-- === SEKME 1: KAYITLI KOORDİNATLAR ===
local SaveData = {}
local FileName = "NX_Coords.json"
local function LoadData() pcall(function() if isfile and isfile(FileName) then SaveData = HttpService:JSONDecode(readfile(FileName)) end end) end
local function SaveToFile() pcall(function() if writefile then writefile(FileName, HttpService:JSONEncode(SaveData)) end end) end

local TopSaveFrame = Instance.new("Frame", TabSaved); TopSaveFrame.Size = UDim2.new(1, 0, 0, 40); TopSaveFrame.BackgroundTransparency = 1
CoordNameInput = Instance.new("TextBox", TopSaveFrame); CoordNameInput.Size = UDim2.new(0.75, 0, 1, 0); CoordNameInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30); CoordNameInput.TextColor3 = Color3.new(1,1,1)
CoordNameInput.Text = ""; CoordNameInput.PlaceholderText = LangData[CurrentLang].SavePlace; CoordNameInput.Font = Enum.Font.Gotham; CoordNameInput.TextSize = 13
Instance.new("UICorner", CoordNameInput).CornerRadius = UDim.new(0, 8)
CoordNameInput.Focused:Connect(function() CoordNameInput.Text = "" end) -- Tıklayınca temizleme

SaveCoordBtn = Instance.new("TextButton", TopSaveFrame); SaveCoordBtn.Size = UDim2.new(0.23, 0, 1, 0); SaveCoordBtn.Position = UDim2.new(0.77, 0, 0, 0); SaveCoordBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 40); SaveCoordBtn.TextColor3 = Color3.new(1,1,1)
SaveCoordBtn.Font = Enum.Font.GothamBold; SaveCoordBtn.Text = LangData[CurrentLang].SaveBtn; Instance.new("UICorner", SaveCoordBtn).CornerRadius = UDim.new(0, 8)

-- Mevcut Konumu Al Butonu
GetLocBtn = Instance.new("TextButton", TabSaved); GetLocBtn.Size = UDim2.new(1, 0, 0, 30); GetLocBtn.Position = UDim2.new(0, 0, 0, 45); GetLocBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 120); GetLocBtn.TextColor3 = Color3.new(1,1,1)
GetLocBtn.Font = Enum.Font.GothamBold; GetLocBtn.Text = LangData[CurrentLang].GetPosBtn; Instance.new("UICorner", GetLocBtn).CornerRadius = UDim.new(0, 6)

local CoordList = Instance.new("ScrollingFrame", TabSaved); CoordList.Size = UDim2.new(1, 0, 1, -85); CoordList.Position = UDim2.new(0, 0, 0, 85); CoordList.BackgroundTransparency = 1; CoordList.ScrollBarThickness = 2
local ListLayout = Instance.new("UIListLayout", CoordList); ListLayout.Padding = UDim.new(0, 8)

local CachedCFrame = nil
GetLocBtn.MouseButton1Click:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        CachedCFrame = tostring(LP.Character.HumanoidRootPart.CFrame)
        GetLocBtn.Text = (CurrentLang == "TR") and "📍 KONUM ALINDI!" or "📍 LOCATION ACQUIRED!"
        GetLocBtn.BackgroundColor3 = Color3.fromRGB(40, 120, 40)
        task.delay(1.5, function() GetLocBtn.Text = LangData[CurrentLang].GetPosBtn; GetLocBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 120) end)
    end
end)

local function RefreshCoordList()
    for _, c in pairs(CoordList:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for name, cframeData in pairs(SaveData) do
        local item = Instance.new("Frame", CoordList); item.Size = UDim2.new(1, -5, 0, 40); item.BackgroundColor3 = Color3.fromRGB(30, 30, 35); Instance.new("UICorner", item).CornerRadius = UDim.new(0, 8)
        local lbl = Instance.new("TextLabel", item); lbl.Size = UDim2.new(0.5, 0, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.new(1,1,1); lbl.Font = Enum.Font.Gotham; lbl.TextSize = 13; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Text = name
        local tpBtn = Instance.new("TextButton", item); tpBtn.Size = UDim2.new(0.2, 0, 0.7, 0); tpBtn.Position = UDim2.new(0.55, 0, 0.15, 0); tpBtn.BackgroundColor3 = Color3.fromRGB(40, 100, 40); tpBtn.TextColor3 = Color3.new(1,1,1); tpBtn.Font = Enum.Font.GothamBold; tpBtn.Text = "TP"; Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 6)
        tpBtn.MouseButton1Click:Connect(function() local args = string.split(cframeData, ","); if #args == 12 and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then LP.Character.HumanoidRootPart.CFrame = CFrame.new(unpack(args)) end end)
        local delBtn = Instance.new("TextButton", item); delBtn.Size = UDim2.new(0.2, 0, 0.7, 0); delBtn.Position = UDim2.new(0.77, 0, 0.15, 0); delBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 40); delBtn.TextColor3 = Color3.new(1,1,1); delBtn.Font = Enum.Font.GothamBold; delBtn.Text = "SİL"; Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 6)
        delBtn.MouseButton1Click:Connect(function() SaveData[name] = nil; SaveToFile(); RefreshCoordList() end)
    end
    CoordList.CanvasSize = UDim2.new(0, 0, 0, #CoordList:GetChildren() * 48)
end

SaveCoordBtn.MouseButton1Click:Connect(function()
    local name = CoordNameInput.Text
    if name ~= "" then
        local targetCF = CachedCFrame
        if not targetCF and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then targetCF = tostring(LP.Character.HumanoidRootPart.CFrame) end
        if targetCF then
            SaveData[name] = targetCF; SaveToFile(); RefreshCoordList(); CoordNameInput.Text = ""; CachedCFrame = nil
        end
    end
end)
LoadData(); RefreshCoordList()

-- === SEKME 2: MANUEL IŞINLANMA ===
ManualInput = Instance.new("TextBox", TabManual)
ManualInput.Size = UDim2.new(1, 0, 0, 60); ManualInput.BackgroundColor3 = Color3.fromRGB(25, 25, 30); ManualInput.TextColor3 = Color3.fromRGB(255, 255, 255)
ManualInput.Text = ""; ManualInput.PlaceholderText = LangData[CurrentLang].ManualPlace; ManualInput.Font = Enum.Font.Gotham; ManualInput.TextSize = 12; Instance.new("UICorner", ManualInput).CornerRadius = UDim.new(0, 8)
ManualInput.Focused:Connect(function() ManualInput.Text = "" end) -- Tıklayınca temizleme

ManualTpBtn = Instance.new("TextButton", TabManual); ManualTpBtn.Size = UDim2.new(1, 0, 0, 45); ManualTpBtn.Position = UDim2.new(0, 0, 0, 75); ManualTpBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50); ManualTpBtn.TextColor3 = Color3.new(1,1,1); ManualTpBtn.Font = Enum.Font.GothamBold; ManualTpBtn.Text = LangData[CurrentLang].TpBtn; Instance.new("UICorner", ManualTpBtn).CornerRadius = UDim.new(0, 8)
CopyCfBtn = Instance.new("TextButton", TabManual); CopyCfBtn.Size = UDim2.new(1, 0, 0, 45); CopyCfBtn.Position = UDim2.new(0, 0, 1, -45); CopyCfBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 120); CopyCfBtn.TextColor3 = Color3.new(1,1,1); CopyCfBtn.Font = Enum.Font.GothamBold; CopyCfBtn.Text = LangData[CurrentLang].CopyBtn; Instance.new("UICorner", CopyCfBtn).CornerRadius = UDim.new(0, 8)

ManualTpBtn.MouseButton1Click:Connect(function()
    local txt = ManualInput.Text:gsub("CFrame.new%(", ""):gsub("%)", ""); local args = string.split(txt, ","); if #args >= 3 then pcall(function() LP.Character.HumanoidRootPart.CFrame = CFrame.new(unpack(args)) end) end
end)
CopyCfBtn.MouseButton1Click:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") and setclipboard then
        setclipboard("CFrame.new(" .. tostring(LP.Character.HumanoidRootPart.CFrame) .. ")"); CopyCfBtn.Text = "OK!"; task.delay(2, function() CopyCfBtn.Text = LangData[CurrentLang].CopyBtn end)
    end
end)

-- === SEKME 3: HOME & BANNER ===
WelcomeLbl = Instance.new("TextLabel", TabHome); WelcomeLbl.Size = UDim2.new(1, 0, 0, 40); WelcomeLbl.BackgroundTransparency = 1; WelcomeLbl.Text = LangData[CurrentLang].Welcome; WelcomeLbl.TextColor3 = Color3.new(1,1,1); WelcomeLbl.Font = Enum.Font.GothamBlack; WelcomeLbl.TextSize = 22; WelcomeLbl.TextXAlignment = Enum.TextXAlignment.Left
InfoText = Instance.new("TextLabel", TabHome); InfoText.Size = UDim2.new(1, 0, 0, 50); InfoText.Position = UDim2.new(0, 0, 0, 40); InfoText.BackgroundTransparency = 1; InfoText.Text = LangData[CurrentLang].Info; InfoText.TextColor3 = Color3.fromRGB(180, 180, 180); InfoText.Font = Enum.Font.Gotham; InfoText.TextSize = 14; InfoText.TextXAlignment = Enum.TextXAlignment.Left

local BannerImg = Instance.new("ImageLabel", TabHome)
BannerImg.Size = UDim2.new(1, 0, 0, 160); BannerImg.Position = UDim2.new(0, 0, 0, 100); BannerImg.Image = "rbxassetid://140311109100270"
BannerImg.ScaleType = Enum.ScaleType.Crop; BannerImg.BackgroundTransparency = 1; Instance.new("UICorner", BannerImg).CornerRadius = UDim.new(0, 10)

-- === SEKME 4: AYARLAR & DİL SEÇİMİ ===
local SettingsLayout = Instance.new("UIListLayout", TabSettings); SettingsLayout.Padding = UDim.new(0, 8); SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder

LangLbl = Instance.new("TextLabel", TabSettings); LangLbl.Size = UDim2.new(1, 0, 0, 25); LangLbl.BackgroundTransparency = 1; LangLbl.Text = LangData[CurrentLang].LangLbl; LangLbl.TextColor3 = Color3.new(1,1,1); LangLbl.Font = Enum.Font.GothamBold; LangLbl.TextXAlignment = Enum.TextXAlignment.Left; LangLbl.LayoutOrder = 1
local LangContainer = Instance.new("Frame", TabSettings); LangContainer.Size = UDim2.new(1, 0, 0, 35); LangContainer.BackgroundTransparency = 1; LangContainer.LayoutOrder = 2
local BtnTR = Instance.new("TextButton", LangContainer); BtnTR.Size = UDim2.new(0.48, 0, 1, 0); BtnTR.BackgroundColor3 = Color3.fromRGB(40,40,40); BtnTR.TextColor3 = Color3.new(1,1,1); BtnTR.Text = "Türkçe"; BtnTR.Font = Enum.Font.GothamBold; Instance.new("UICorner", BtnTR).CornerRadius = UDim.new(0,6)
local BtnEN = Instance.new("TextButton", LangContainer); BtnEN.Size = UDim2.new(0.48, 0, 1, 0); BtnEN.Position = UDim2.new(0.52, 0, 0, 0); BtnEN.BackgroundColor3 = Color3.fromRGB(25,25,30); BtnEN.TextColor3 = Color3.new(1,1,1); BtnEN.Text = "English"; BtnEN.Font = Enum.Font.GothamBold; Instance.new("UICorner", BtnEN).CornerRadius = UDim.new(0,6)

-- FULL DİL GÜNCELLEME FONKSİYONU
local function UpdateLanguage(lang)
    CurrentLang = lang
    local t = LangData[lang]
    for key, data in pairs(Tabs) do if data.Page.Visible then TitleText.Text = t[key] end end
    WelcomeLbl.Text = t.Welcome; InfoText.Text = t.Info
    CoordNameInput.PlaceholderText = t.SavePlace; SaveCoordBtn.Text = t.SaveBtn; GetLocBtn.Text = t.GetPosBtn
    ManualInput.PlaceholderText = t.ManualPlace; ManualTpBtn.Text = t.TpBtn; CopyCfBtn.Text = t.CopyBtn
    LangLbl.Text = t.LangLbl; ThemeLbl.Text = t.ThemeLbl
end

BtnTR.MouseButton1Click:Connect(function() BtnTR.BackgroundColor3 = Color3.fromRGB(40,40,40); BtnEN.BackgroundColor3 = Color3.fromRGB(25,25,30); UpdateLanguage("TR") end)
BtnEN.MouseButton1Click:Connect(function() BtnEN.BackgroundColor3 = Color3.fromRGB(40,40,40); BtnTR.BackgroundColor3 = Color3.fromRGB(25,25,30); UpdateLanguage("EN") end)

ThemeLbl = Instance.new("TextLabel", TabSettings); ThemeLbl.Size = UDim2.new(1, 0, 0, 25); ThemeLbl.BackgroundTransparency = 1; ThemeLbl.Text = LangData[CurrentLang].ThemeLbl; ThemeLbl.TextColor3 = Color3.new(1,1,1); ThemeLbl.Font = Enum.Font.GothamBold; ThemeLbl.TextXAlignment = Enum.TextXAlignment.Left; ThemeLbl.LayoutOrder = 3

local ThemeOrderCounter = 4
local function CreateThemeBtn(name, color)
    local b = Instance.new("TextButton", TabSettings); b.Size = UDim2.new(1, 0, 0, 35); b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.Text = name; b.TextColor3 = color; b.Font = Enum.Font.GothamBold; b.TextSize = 13; b.LayoutOrder = ThemeOrderCounter; ThemeOrderCounter = ThemeOrderCounter + 1; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function()
        CurrentThemeColor = color; SidebarStroke.Color = color; MainStroke.Color = color; TitleLine.BackgroundColor3 = color; TitleText.TextColor3 = color
        for _, t in pairs(Tabs) do if t.Page.Visible then t.Btn.BackgroundColor3 = color end end
    end)
end
CreateThemeBtn("Gümüş (Silver) [Varsayılan]", Color3.fromRGB(192, 192, 192))
CreateThemeBtn("Siber Mavi (Cyan)", Color3.fromRGB(0, 255, 255))
CreateThemeBtn("Neon Kırmızı (Crimson)", Color3.fromRGB(220, 20, 60))

-- === SEKME 5: DİĞER SCRİPTLER ===
local ScriptsLayout = Instance.new("UIListLayout", TabScripts); ScriptsLayout.Padding = UDim.new(0, 10)
local function CreateScriptBtn(name, codeToRun)
    local b = Instance.new("TextButton", TabScripts); b.Size = UDim2.new(1, 0, 0, 45); b.BackgroundColor3 = Color3.fromRGB(25, 25, 30); b.Text = name; b.TextColor3 = Color3.new(1,1,1); b.Font = Enum.Font.GothamBold; b.TextSize = 14; Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function() pcall(function() loadstring(codeToRun)() end) end)
end
CreateScriptBtn("Infinite Yield (Admin Script)", "loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()")
CreateScriptBtn("Dex Explorer (Oyun Dosyaları)", "loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()")

-- [8] BAŞLATMA
Tabs["Home"].Btn.BackgroundColor3 = CurrentThemeColor
Tabs["Home"].Btn.TextColor3 = Color3.fromRGB(10, 10, 10)
Tabs["Home"].Page.Visible = true
TitleText.Text = LangData["TR"]["Home"]
