-- Grow a Crypto Farm
-- Auto Collect From Computers

local delayTime = 1

-- البحث عن الريموت المسؤول عن الجمع
local collectRemote

for _,v in pairs(game:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if string.find(string.lower(v.Name),"collect") 
        or string.find(string.lower(v.Name),"claim") 
        or string.find(string.lower(v.Name),"withdraw") then
            collectRemote = v
        end
    end
end

-- جمع العملات
local function collectComputers()

    for _,computer in pairs(workspace:GetDescendants()) do
        
        if string.find(string.lower(computer.Name),"computer") then
            
            pcall(function()
                
                if collectRemote:IsA("RemoteEvent") then
                    collectRemote:FireServer(computer)
                else
                    collectRemote:InvokeServer(computer)
                end
                
            end)
            
        end
        
    end
    
end


-- حلقة مستمرة
while true do
    task.wait(delayTime)
    
    if collectRemote then
        collectComputers()
    end
    
end
