--[[
    SCRIPT: Gear Spawner por ID
    Hospedagem: github.com
]]

local GEAR_ID = 16641274 -- <--- COLOQUE O ID DO GEAR AQUI
local players = game:GetService("Players")
local insertService = game:GetService("InsertService")

local function darGear(player)
    local success, model = pcall(function()
        -- O InsertService exige que o item seja público ou do dono do mapa
        return insertService:LoadAsset(GEAR_ID)
    end)

    if success and model then
        local tool = model:FindFirstChildOfClass("Tool")
        if tool then
            -- Clonar para a mochila (Backpack) e para o personagem (se vivo)
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                tool.Parent = backpack
                print("Sucesso: Item " .. GEAR_ID .. " entregue a " .. player.Name)
            end
        end
        model:Destroy()
    else
        warn("Erro ao carregar ID " .. GEAR_ID .. ". Verifique se o ID existe ou se o LoadAsset permite este item.")
    end
end

-- Executa para quem rodou o script (LocalPlayer)
-- Se for um Script de Servidor, você pode mudar para um loop de jogadores
local lp = players.LocalPlayer
if lp then
    darGear(lp)
else
    -- Caso rode no servidor sem LocalPlayer, dá para todos:
    for _, p in pairs(players:GetPlayers()) do
        darGear(p)
    end
end
