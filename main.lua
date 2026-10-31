local _version = "1.6.66"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. _version .. "/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "01ROXHUB | DUELS <font color='#FFD700'>[BETA]</font>",
    Author = "BY 01ROXHUB MATI HUB",
    Folder = "01ROXHUB",
    Acrylic = false,
    Transparent = false,
    NewElements = true,
    HideSearchBar = false,
    Background = "rbxassetid://87524321260822",
    BackgroundImageTransparency = 0.55,
    OpenButton = {
        Title = "OPEN 01ROXHUB",
        Icon = "swords",
        CornerRadius = UDim.new(0, 14),
        StrokeThickness = 1.1,
        Enabled = true,
        Draggable = true,
        Scale = 0.9,
        Color = ColorSequence.new(Color3.fromRGB(20, 20, 20), Color3.fromRGB(0, 0, 0))
    },
    Topbar = { Height = 44, ButtonsType = "Default" }
})
Window:SetSize(UDim2.fromOffset(580, 460))
WindUI:SetTheme("Dark")
local Home = Window:Tab({ Title = "HOME", Icon = "house" })
local Aimbot = Window:Tab({ Title = "AIMBOT", Icon = "crosshair" })
local Visuales = Window:Tab({ Title = "VISUALES", Icon = "eye" })
local Movimiento = Window:Tab({ Title = "MOVIMIENTO", Icon = "person-standing" })
local Animaciones = Window:Tab({ Title = "ANIMACIONES", Icon = "footprints" })
local AutoFarm = Window:Tab({ Title = "ALTO FARM", Icon = "coins" })
local AutoKills = Window:Tab({ Title = "ALTO KILLS", Icon = "skull" })
local Settings = Window:Tab({ Title = "SETTINGS", Icon = "settings" })
local Creditos = Window:Tab({ Title = "CRÉDITOS", Icon = "badge-info" })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local LP = Players.LocalPlayer
while not LP do task.wait() LP = Players.LocalPlayer end
local player = LP
local camera = workspace.CurrentCamera
local fovVisiblePreference = false
local fovRadius = 120
local autoShootEnabled = false
local autoShootAgresivoEnabled = false
local autoShootTargetPart = "Cabeza"
local silentAimManualEnabled = false
local silentAimFovEnabled = false
local silentAimTargetPart = "Cabeza"
local espEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)
local activeESPs = {}
local MAX_ESP_DISTANCE = 1500
local serverDeadCharacters = setmetatable({}, { __mode = "k" })
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "01ROXHUB"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Parent = LP:WaitForChild("PlayerGui")
local espFolder = Instance.new("Folder")
espFolder.Name = "01ROXHUB"
espFolder.Parent = screenGui
local isEnemy, estaEnLobby, IsInMatchStrict
local esEnemigoValido, esCuchillo, esPistola
local startTargetMonitor
do
local function dmvsDisconnectConnectionList(list)
    if not list then return end
    for i = #list, 1, -1 do local c = list[i] list[i] = nil if c and c.Connected then c:Disconnect() end end
end
local function dmvsIsTargetAlive(target)
    local character = target
    if typeof(target) == "Instance" and target:IsA("Player") then character = target.Character end
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    return humanoid.Health >= 5
end
local function dmvsGetInGameScoreboard()
    local gui = player:FindFirstChild("PlayerGui")
    local main = gui and gui:FindFirstChild("Main")
    local frame = main and main:FindFirstChild("MainGameFrame")
    return frame and frame:FindFirstChild("IngameScore") or nil
end
local dmvsTeamResolverState = { Snapshot = {}, Scoreboard = nil, InGame = false, LocalGame = nil, LastRefresh = 0, RefreshInterval = 2, Dirty = true, WatchConnections = {} }
local function dmvsInvalidateScoreboard() dmvsTeamResolverState.Dirty = true end
local function dmvsWatchScoreboard(score)
    local state = dmvsTeamResolverState
    if state.Scoreboard == score then return end
    dmvsDisconnectConnectionList(state.WatchConnections)
    state.Scoreboard = score
    if not score then return end
    local watchTeams
    watchTeams = function()
        dmvsInvalidateScoreboard()
        dmvsDisconnectConnectionList(state.WatchConnections)
        state.WatchConnections[#state.WatchConnections + 1] = score.ChildAdded:Connect(watchTeams)
        state.WatchConnections[#state.WatchConnections + 1] = score.ChildRemoved:Connect(watchTeams)
        for _, name in ipairs({"TeamRed", "TeamBlue"}) do
            local folder = score:FindFirstChild(name)
            if folder then
                state.WatchConnections[#state.WatchConnections + 1] = folder.ChildAdded:Connect(dmvsInvalidateScoreboard)
                state.WatchConnections[#state.WatchConnections + 1] = folder.ChildRemoved:Connect(dmvsInvalidateScoreboard)
            end
        end
    end
    watchTeams()
end
local function dmvsRefreshScoreboardTeams(force)
    local state = dmvsTeamResolverState
    local now = os.clock()
    local localGame = player:GetAttribute("Game")
    if not force and not state.Dirty and now - state.LastRefresh < state.RefreshInterval and state.LocalGame == localGame and (not state.Scoreboard or state.Scoreboard.Parent) then return state.Snapshot end
    state.LastRefresh = now
    state.LocalGame = localGame
    local snapshot = {}
    local score = dmvsGetInGameScoreboard()
    if score ~= state.Scoreboard then dmvsWatchScoreboard(score) end
    for _, teamName in ipairs({"TeamRed", "TeamBlue"}) do
        local teamFolder = score and score:FindFirstChild(teamName)
        if teamFolder then
            local team = teamName == "TeamRed" and "Red" or "Blue"
            for _, entry in ipairs(teamFolder:GetChildren()) do if entry:IsA("GuiObject") then snapshot[string.lower(entry.Name)] = team end end
        end
    end
    state.Snapshot = snapshot
    state.Dirty = false
    state.InGame = score ~= nil and snapshot[string.lower(player.Name)] ~= nil
    return snapshot
end
local dmvsInfectionState = { Active = false, LastRefresh = -math.huge, Targets = {} }
local function dmvsIsInfectionMode() return dmvsInfectionState.Active end
local function dmvsIsInfectedTarget(targetPlayer)
    if not targetPlayer then return false end
    return dmvsInfectionState.Active and dmvsInfectionState.Targets[targetPlayer] == true
end
local function dmvsInfectionMarkDirty() dmvsInfectionState.LastRefresh = -math.huge end
local function dmvsIsInSameGame(targetPlayer)
    if not targetPlayer or targetPlayer == player or not targetPlayer.Parent then return false end
    if dmvsIsInfectionMode() then return dmvsIsInfectedTarget(targetPlayer) end
    local roster = dmvsRefreshScoreboardTeams(false)
    if not dmvsTeamResolverState.InGame or not roster[string.lower(targetPlayer.Name)] then return false end
    local myGame = player:GetAttribute("Game") local targetGame = targetPlayer:GetAttribute("Game")
    if myGame ~= nil and myGame ~= "" and targetGame ~= nil and targetGame ~= "" then if myGame ~= targetGame then return false end end
    return true
end
local function dmvsResolvePlayerTeam(targetPlayer)
    if not targetPlayer then return nil end
    local snapshot = dmvsRefreshScoreboardTeams(false)
    local byName = snapshot[string.lower(targetPlayer.Name)]
    if byName then return byName end
    local attr = targetPlayer:GetAttribute("Team") or targetPlayer:GetAttribute("team")
    if attr ~= nil and tostring(attr) ~= "" then return tostring(attr) end
    if targetPlayer.Team then return targetPlayer.Team.Name end
    return nil
end
local function dmvsPlayersAreEnemies(firstPlayer, secondPlayer)
    if not firstPlayer or not secondPlayer or firstPlayer == secondPlayer then return false end
    if dmvsIsInfectionMode() then return dmvsIsInfectedTarget(secondPlayer) end
    local firstTeam = dmvsResolvePlayerTeam(firstPlayer)
    local secondTeam = dmvsResolvePlayerTeam(secondPlayer)
    if firstTeam ~= nil and secondTeam ~= nil then return firstTeam ~= secondTeam end
    return true
end
local function updateMyTeam() dmvsInvalidateScoreboard() end
local function updateEnemy() dmvsInvalidateScoreboard() dmvsInfectionMarkDirty() end
local dmvsTeamPlayerConnections = {}
local function disconnectPlayerTeamEvents(p)
    local connections = dmvsTeamPlayerConnections[p]
    if connections then dmvsDisconnectConnectionList(connections) dmvsTeamPlayerConnections[p] = nil end
end
local function setupPlayerEvents(p)
    if not p or p == player or not p.Parent then return end
    disconnectPlayerTeamEvents(p)
    dmvsTeamPlayerConnections[p] = {
        p:GetPropertyChangedSignal("Team"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("Team"):Connect(updateEnemy),
        p:GetAttributeChangedSignal("Game"):Connect(updateEnemy),
        p.CharacterAdded:Connect(function() dmvsInfectionMarkDirty() updateEnemy() end),
    }
    updateEnemy()
end
local RoxhubTargetConnections = {} local RoxhubTargetMonitorActive = false
local function RoxhubMonitorConnection(c) RoxhubTargetConnections[#RoxhubTargetConnections + 1] = c return c end
local function RoxhubStartTargetMonitor()
    if RoxhubTargetMonitorActive then return end
    RoxhubTargetMonitorActive = true
    local function localChanged() updateMyTeam() dmvsInfectionMarkDirty() end
    for _, name in ipairs({"Team", "TeamColor"}) do RoxhubMonitorConnection(player:GetPropertyChangedSignal(name):Connect(localChanged)) end
    for _, name in ipairs({"Team", "team", "Game", "MatchId"}) do RoxhubMonitorConnection(player:GetAttributeChangedSignal(name):Connect(localChanged)) end
    for _, other in ipairs(Players:GetPlayers()) do if other ~= player then setupPlayerEvents(other) end end
    RoxhubMonitorConnection(Players.PlayerAdded:Connect(function(other) setupPlayerEvents(other) dmvsInfectionMarkDirty() end))
    RoxhubMonitorConnection(Players.PlayerRemoving:Connect(function(other) disconnectPlayerTeamEvents(other) updateEnemy() end))
    dmvsInvalidateScoreboard() dmvsInfectionMarkDirty()
end
startTargetMonitor = RoxhubStartTargetMonitor
isEnemy = function(targetPlayer)
    if not dmvsIsInSameGame(targetPlayer) or not targetPlayer.Character then return false end
    if not dmvsIsTargetAlive(targetPlayer) then return false end
    return dmvsPlayersAreEnemies(player, targetPlayer)
end
estaEnLobby = function()
    local character = player.Character
    if not character then return true end
    if character:FindFirstChildOfClass("ForceField") then return true end
    if player.Team then local name = player.Team.Name:lower() if name:find("lobby") or name:find("spectat") or name:find("menu") or name:find("dead") then return true end end
    return false
end
IsInMatchStrict = function()
    if estaEnLobby() then return false end
    dmvsRefreshScoreboardTeams(false)
    return dmvsTeamResolverState.InGame or dmvsIsInfectionMode()
end
esEnemigoValido = function(other)
    if not isEnemy(other) then return false end
    local character = other.Character
    return character ~= nil and not character:FindFirstChildOfClass("ForceField") and dmvsIsTargetAlive(other)
end
esCuchillo = function(tool)
    if not tool or not tool:IsA("Tool") then return false end
    if tool:FindFirstChild("Slash") or tool:FindFirstChild("SlashStart") then return true end
    return false
end
esPistola = function(tool)
    if not tool or not tool:IsA("Tool") then return false end
    return tool:FindFirstChild("showBeam") ~= nil
end
end
startTargetMonitor()
local function getExecutor()
    if identifyexecutor then local ok, exec = pcall(identifyexecutor) if ok and exec then return exec end end
    return "Delta"
end
local function getGameName()
    local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
    if ok and info and info.Name then return info.Name end
    return "01ROXHUB"
end
local avatarThumb = "rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=420&h=420"
local gameThumb = "rbxthumb://type=GameIcon&id="..game.GameId.."&w=512&h=512"
Home:Section({ Title = "PERFIL", Icon = "user", Opened = true })
Home:Paragraph({ Title = "Usuario: "..LP.DisplayName, Desc = "Usuario: @"..LP.Name.."\nID: "..LP.UserId.."\nEdad de la cuenta: "..LP.AccountAge.." días", Image = avatarThumb, ImageSize = 60 })
Home:Section({ Title = "Sistema", Icon = "monitor", Opened = true })
Home:Paragraph({ Title = "EXECUTOR", Desc = "Ejecutor actual: "..getExecutor() })
Home:Section({ Title = "Información del Servidor", Icon = "server", Opened = true })
Home:Paragraph({ Title = "Juego Actual", Desc = getGameName().."\nPlace ID: "..game.PlaceId, Image = gameThumb, ImageSize = 60 })
Aimbot:Section({ Title = "AUTO SHOOT", Icon = "target" })
Aimbot:Toggle({ Title = "AUTO SHOOT [NORMAL]", Value = false, Callback = function(v) autoShootEnabled = v if not v and not autoShootAgresivoEnabled then getgenv().RoxhubTargetPart = nil end end })
Aimbot:Toggle({ Title = "AUTO SHOOT [AGRESIVO]", Value = false, Callback = function(v) autoShootAgresivoEnabled = v if not v and not autoShootEnabled then getgenv().RoxhubTargetPart = nil end end })
Aimbot:Dropdown({ Title = "TARGET PARTE", Values = {"Cabeza","Torso","Cuerpo Completo"}, Value = "Cabeza", Callback = function(v) autoShootTargetPart = v end })
Aimbot:Section({ Title = "SILENT AIM + FOV", Icon = "radar" })
Aimbot:Toggle({ Title = "SILENT AIM", Value = false, Callback = function(v) silentAimManualEnabled = v if not v and not autoShootEnabled and not autoShootAgresivoEnabled then getgenv().RoxhubTargetPart = nil end end })
Aimbot:Dropdown({ Title = "Silent Target", Values = {"Cabeza","Torso","Cuerpo Completo"}, Value = "Cabeza", Callback = function(v) silentAimTargetPart = v end })
Aimbot:Toggle({ Title = "SILENT AIM [FOV]", Value = false, Callback = function(v) silentAimFovEnabled = v if not v and not silentAimManualEnabled and not autoShootEnabled and not autoShootAgresivoEnabled then getgenv().RoxhubTargetPart = nil end end })
Aimbot:Toggle({ Title = "MOSTRAR FOV", Value = false, Callback = function(v) fovVisiblePreference = v end })
Aimbot:Slider({ Title = "TAMAÑO DEL FOV", Value = { Min = 10, Max = 800, Default = 120 }, Callback = function(v) fovRadius = v end })
getgenv().RoxhubTargetPart = nil
local oldNamecall
if hookmetamethod and getnamecallmethod and checkcaller then
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if not checkcaller() and getgenv().RoxhubTargetPart then
            if method == "Raycast" and self == workspace then
                local target = getgenv().RoxhubTargetPart
                if target and target.Parent then
                    local origin, direction, p3 = ...
                    if typeof(direction) == "Vector3" and direction.Magnitude > 20 then
                        local cameraOrigin = workspace.CurrentCamera.CFrame.Position
                        if (origin - cameraOrigin).Magnitude >= 1 then
                            local newDir = (target.Position - origin).Unit * 5000
                            return oldNamecall(self, origin, newDir, p3)
                        end
                    end
                else
                    getgenv().RoxhubTargetPart = nil
                end
            end
        end
        return oldNamecall(self, ...)
    end)
end
task.spawn(function()
    local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude
    while task.wait(0.1) do
        if (autoShootEnabled or autoShootAgresivoEnabled) and not estaEnLobby() then
            local char = LP.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
            local arma = char:FindFirstChildOfClass("Tool")
            if not arma or not arma:FindFirstChild("Handle") then getgenv().RoxhubTargetPart = nil continue end
            if esCuchillo(arma) then getgenv().RoxhubTargetPart = nil continue end
            local closestPart = nil local shortest = math.huge
            local myPos = char.HumanoidRootPart.Position local headPos = char:FindFirstChild("Head") and char.Head.Position or myPos
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and esEnemigoValido(p) then
                    local enemyHum = p.Character and p.Character:FindFirstChild("Humanoid")
                    if enemyHum and enemyHum.Health > 0 then
                        params.FilterDescendantsInstances = { char, p.Character }
                        local function Proc(part)
                            local d = (part.Position - myPos).Magnitude
                            if d < shortest then
                                if not workspace:Raycast(headPos, part.Position - headPos, params) then shortest = d closestPart = part end
                            end
                        end
                        if autoShootAgresivoEnabled then for _, part in ipairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then Proc(part) end end
                        elseif autoShootTargetPart == "Cabeza" then local h = p.Character:FindFirstChild("Head") if h then Proc(h) end
                        elseif autoShootTargetPart == "Torso" then for _, n in ipairs({"UpperTorso","Torso","HumanoidRootPart"}) do local pt = p.Character:FindFirstChild(n) if pt then Proc(pt) end end
                        else for _, part in ipairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then Proc(part) end end end
                    end
                end
            end
            if closestPart then getgenv().RoxhubTargetPart = closestPart pcall(function() arma:Activate() task.delay(0.05, function() if arma.Parent == char then arma:Deactivate() end end) end) task.wait(0.2) else getgenv().RoxhubTargetPart = nil end
        end
    end
end)
task.spawn(function()
    local params = RaycastParams.new() params.FilterType = Enum.RaycastFilterType.Exclude
    while task.wait(0.1) do
        if (silentAimManualEnabled or silentAimFovEnabled) and not estaEnLobby() then
            local char = LP.Character if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
            local closestPart = nil local shortestCenter = math.huge local shortestDist = math.huge
            local myPos = char.HumanoidRootPart.Position local headPos = char:FindFirstChild("Head") and char.Head.Position or myPos
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and esEnemigoValido(p) then
                    local enemyHum = p.Character and p.Character:FindFirstChild("Humanoid")
                    if enemyHum and enemyHum.Health > 0 then
                        local parts = {}
                        if silentAimTargetPart == "Cabeza" then local h = p.Character:FindFirstChild("Head") if h then table.insert(parts, h) end
                        elseif silentAimTargetPart == "Torso" then for _, n in ipairs({"UpperTorso","Torso","HumanoidRootPart"}) do local pt = p.Character:FindFirstChild(n) if pt then table.insert(parts, pt) end end
                        else for _, part in ipairs(p.Character:GetChildren()) do if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then table.insert(parts, part) end end end
                        params.FilterDescendantsInstances = { char, p.Character }
                        for _, part in ipairs(parts) do
                            local dist = (part.Position - myPos).Magnitude
                            local pos2D, onScreen = camera:WorldToViewportPoint(part.Position)
                            local distToCenter = (Vector2.new(pos2D.X, pos2D.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                            local okFilter = false
                            if silentAimFovEnabled then if onScreen and distToCenter <= fovRadius and distToCenter < shortestCenter then okFilter = true end
                            elseif silentAimManualEnabled then if dist < shortestDist then okFilter = true end end
                            if okFilter then if not workspace:Raycast(headPos, part.Position - headPos, params) then if silentAimFovEnabled then shortestCenter = distToCenter closestPart = part else shortestDist = dist closestPart = part end end end
                        end
                    end
                end
            end
            if closestPart then getgenv().RoxhubTargetPart = closestPart else if not autoShootEnabled and not autoShootAgresivoEnabled then getgenv().RoxhubTargetPart = nil end end
        end
    end
end)
local function cleanESP(targetPlayer)
    if activeESPs[targetPlayer] then if activeESPs[targetPlayer].Highlight then activeESPs[targetPlayer].Highlight:Destroy() end activeESPs[targetPlayer] = nil end
end
local function WatchServerDeath(char)
    if not char then return end
    task.spawn(function()
        local hum = char:WaitForChild("Humanoid", 10)
        if not hum then return end
        hum.Died:Connect(function() serverDeadCharacters[char] = true local p = Players:GetPlayerFromCharacter(char) if p then cleanESP(p) end end)
    end)
end
for _, p in ipairs(Players:GetPlayers()) do if p ~= LP then if p.Character then WatchServerDeath(p.Character) end p.CharacterAdded:Connect(function(c) WatchServerDeath(c) end) end end
Players.PlayerAdded:Connect(function(p) if p ~= LP then if p.Character then WatchServerDeath(p.Character) end p.CharacterAdded:Connect(function(c) WatchServerDeath(c) end) end end)
Visuales:Section({ Title = "VISUALES", Icon = "eye", Opened = true })
Visuales:Toggle({ Title = "ESP BRILLO", Value = false, Callback = function(s) espEnabled = s if not s then for _, p in pairs(Players:GetPlayers()) do local h = espFolder:FindFirstChild(p.Name .. "01ROXHUB") if h then h:Destroy() end activeESPs[p] = nil end end end })
Visuales:Colorpicker({ Title = "COLOR DEL ESP", Default = Color3.fromRGB(255, 0, 0), Callback = function(c) espColor = c for _, v in pairs(activeESPs) do if v.Highlight then v.Highlight.FillColor = c end end end })
task.spawn(function()
    while task.wait(0.2) do
        if espEnabled and IsInMatchStrict() then
            local myChar = LP.Character local myHead = myChar and myChar:FindFirstChild("Head") local myPos = myHead and myHead.Position
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP then
                    local char = p.Character local dead = char and serverDeadCharacters[char] == true
                    if char and not dead and char:FindFirstChild("Head") and esEnemigoValido(p) then
                        local dist = myPos and (char.Head.Position - myPos).Magnitude or 0
                        if dist <= MAX_ESP_DISTANCE then
                            if activeESPs[p] and activeESPs[p].Char ~= char then cleanESP(p) end
                            if not activeESPs[p] then
                                local highlight = Instance.new("Highlight")
                                highlight.Name = p.Name .. "01ROXHUB"
                                highlight.FillTransparency = 0.6
                                highlight.OutlineTransparency = 1
                                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                                highlight.FillColor = espColor
                                highlight.OutlineColor = espColor
                                highlight.Adornee = char
                                highlight.Parent = espFolder
                                activeESPs[p] = { Highlight = highlight, Char = char }
                            end
                            local espObj = activeESPs[p]
                            if espObj.Highlight.FillColor ~= espColor then espObj.Highlight.FillColor = espColor espObj.Highlight.OutlineColor = espColor end
                        else cleanESP(p) end
                    else cleanESP(p) end
                end
            end
        else
            for _, p in pairs(Players:GetPlayers()) do cleanESP(p) end
        end
    end
end)
local FOVCircle = nil
if Drawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    FOVCircle.Radius = fovRadius
    FOVCircle.Filled = false
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Visible = false
    FOVCircle.Thickness = 1
end
RunService.RenderStepped:Connect(function()
    if fovVisiblePreference and FOVCircle then
        FOVCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
        FOVCircle.Radius = fovRadius
        FOVCircle.Visible = true
        if silentAimFovEnabled and getgenv().RoxhubTargetPart then FOVCircle.Color = Color3.fromRGB(0, 255, 0) else FOVCircle.Color = Color3.fromRGB(255, 255, 255) end
    elseif FOVCircle then
        FOVCircle.Visible = false
    end
end)
Players.PlayerRemoving:Connect(function(p) cleanESP(p) end)
local AllPacks = {
    Astronaut = { idle1="rbxassetid://891621366", idle2="rbxassetid://891633237", walk="rbxassetid://891667138", run="rbxassetid://891636393", jump="rbxassetid://891627522", fall="rbxassetid://891617961" },
    Bubbly = { idle1="rbxassetid://910004836", idle2="rbxassetid://910009958", walk="rbxassetid://910034870", run="rbxassetid://910025107", jump="rbxassetid://910016857", fall="rbxassetid://910001910" },
    Cartoony = { idle1="rbxassetid://742637544", idle2="rbxassetid://742638445", walk="rbxassetid://742640026", run="rbxassetid://742638842", jump="rbxassetid://742637942", fall="rbxassetid://742637151" },
    Elder = { idle1="rbxassetid://845397899", idle2="rbxassetid://845400520", walk="rbxassetid://845403856", run="rbxassetid://845386501", jump="rbxassetid://845398858", fall="rbxassetid://845396048" },
    Knight = { idle1="rbxassetid://657595757", idle2="rbxassetid://657568135", walk="rbxassetid://657552124", run="rbxassetid://657564596", jump="rbxassetid://658409194", fall="rbxassetid://657600338" },
    Ninja = { idle1="rbxassetid://656117400", idle2="rbxassetid://656118341", walk="rbxassetid://656121766", run="rbxassetid://656118852", jump="rbxassetid://656117878", fall="rbxassetid://656115606" },
    Pirate = { idle1="rbxassetid://750781874", idle2="rbxassetid://750782770", walk="rbxassetid://750785693", run="rbxassetid://750783738", jump="rbxassetid://750782230", fall="rbxassetid://750780242" },
    Robot = { idle1="rbxassetid://616088211", idle2="rbxassetid://616089559", walk="rbxassetid://616095330", run="rbxassetid://616091570", jump="rbxassetid://616090535", fall="rbxassetid://616087089" },
    Stylish = { idle1="rbxassetid://616136790", idle2="rbxassetid://616138447", walk="rbxassetid://616146177", run="rbxassetid://616140816", jump="rbxassetid://616139451", fall="rbxassetid://616134815" },
    SuperHero = { idle1="rbxassetid://616111295", idle2="rbxassetid://616113536", walk="rbxassetid://616122287", run="rbxassetid://616117076", jump="rbxassetid://616115533", fall="rbxassetid://616108001" },
    Zombie = { idle1="rbxassetid://616158929", idle2="rbxassetid://616160636", walk="rbxassetid://616168032", run="rbxassetid://616163682", jump="rbxassetid://616161997", fall="rbxassetid://616157476" },
    Confident = { idle1="rbxassetid://1069977950", idle2="rbxassetid://1069987858", walk="rbxassetid://1070017263", run="rbxassetid://1070001516", jump="rbxassetid://1069984524", fall="rbxassetid://1069973677" },
}
local PackNames = {"Ninguno"} for name in pairs(AllPacks) do table.insert(PackNames, name) end table.sort(PackNames)
local SelectedPack = "Ninguno"
local function ApplyAnims(ids)
    local char = LP.Character if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid") local Animate = char:FindFirstChild("Animate")
    if not hum or not Animate then return end
    local animator = hum:FindFirstChildOfClass("Animator") if animator then for _, t in pairs(animator:GetPlayingAnimationTracks()) do t:Stop(0) t:Destroy() end end
    local function setAnim(parentName, childName, newId) local p = Animate:FindFirstChild(parentName) if p then local a = p:FindFirstChild(childName) if a and a:IsA("Animation") then a.AnimationId = newId end end end
    pcall(setAnim, "idle", "Animation1", ids.idle1) pcall(setAnim, "idle", "Animation2", ids.idle2) pcall(setAnim, "walk", "WalkAnim", ids.walk) pcall(setAnim, "run", "RunAnim", ids.run) pcall(setAnim, "jump", "JumpAnim", ids.jump) pcall(setAnim, "fall", "FallAnim", ids.fall)
    task.wait(0.05) Animate.Enabled = false task.wait(0.05) Animate.Enabled = true hum:ChangeState(Enum.HumanoidStateType.Running)
end
Animaciones:Section({ Title = "Paquetes Completos", Icon = "package" })
Animaciones:Dropdown({ Title = "Elegir Paquete", Values = PackNames, Value = "Ninguno", Callback = function(v) SelectedPack = v end })
Animaciones:Button({ Title = "Aplicar Paquete Completo", Icon = "sparkles", Callback = function() if SelectedPack ~= "Ninguno" and AllPacks[SelectedPack] then ApplyAnims(AllPacks[SelectedPack]) end end })
Animaciones:Button({ Title = "Restaurar Default", Icon = "rotate-ccw", Callback = function() if LP.Character and LP.Character:FindFirstChild("Animate") then LP.Character:FindFirstChild("Animate"):Destroy() end end })
Animaciones:Section({ Title = "Mezclador de Animaciones", Icon = "layers" })
local Mix = { Reposo="Ninguno", Caminar="Ninguno", Correr="Ninguno", Saltar="Ninguno", Caer="Ninguno" }
Animaciones:Dropdown({ Title = "Reposo", Values = PackNames, Value = "Ninguno", Callback = function(v) Mix.Reposo = v end })
Animaciones:Dropdown({ Title = "Caminar", Values = PackNames, Value = "Ninguno", Callback = function(v) Mix.Caminar = v end })
Animaciones:Dropdown({ Title = "Correr", Values = PackNames, Value = "Ninguno", Callback = function(v) Mix.Correr = v end })
Animaciones:Dropdown({ Title = "Saltar", Values = PackNames, Value = "Ninguno", Callback = function(v) Mix.Saltar = v end })
Animaciones:Dropdown({ Title = "Caer", Values = PackNames, Value = "Ninguno", Callback = function(v) Mix.Caer = v end })
Animaciones:Button({ Title = "Combinar y Aplicar", Icon = "sparkles", Callback = function()
    local final = {
        idle1 = AllPacks[Mix.Reposo] and AllPacks[Mix.Reposo].idle1 or "rbxassetid://0",
        idle2 = AllPacks[Mix.Reposo] and AllPacks[Mix.Reposo].idle2 or "rbxassetid://0",
        walk = AllPacks[Mix.Caminar] and AllPacks[Mix.Caminar].walk or "rbxassetid://0",
        run = AllPacks[Mix.Correr] and AllPacks[Mix.Correr].run or "rbxassetid://0",
        jump = AllPacks[Mix.Saltar] and AllPacks[Mix.Saltar].jump or "rbxassetid://0",
        fall = AllPacks[Mix.Caer] and AllPacks[Mix.Caer].fall or "rbxassetid://0",
    }
    ApplyAnims(final)
end })
LP.CharacterAdded:Connect(function(char) char:WaitForChild("Animate", 5) if SelectedPack ~= "Ninguno" and AllPacks[SelectedPack] then task.wait(0.3) ApplyAnims(AllPacks[SelectedPack]) end end)
