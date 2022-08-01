-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")


-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("sn-Matheus", cRP)
vSERVER = Tunnel.getInterface("sn-Matheus")



local locais = {
    [1] = { ['x'] = -773.20196533203, ['y'] = 5581.5795898438, ['z'] = 33.485683441162, ['grau'] = 212.14138793945 },
    [2] = { ['x'] = -772.51470947266, ['y'] = 5574.2827148438, ['z'] = 33.485683441162, ['grau'] = 184.8939666748 },
    [3] = { ['x'] = -779.22711181641, ['y'] = 5577.3232421875, ['z'] = 33.485683441162, ['grau'] = 207.62008666992 },
    [4] = { ['x'] = -778.04504394531, ['y'] = 5580.28125, ['z'] = 33.485687255859, ['grau'] = 172.60916137695 },
    [5] = { ['x'] = -772.65795898438, ['y'] = 5584.0776367188, ['z'] = 33.485687255859, ['grau'] = 332.82040405273 }
}



Citizen.CreateThread(function()
    while true do -- Loop infinito enquanto for true
        local time = 1000 -- velocidade do blip/neste caso milisegundos
        local ped = PlayerPedId() -- pega Id do player
        local coords = GetEntityCoords(ped) -- pega a coordenada do player
        for k, v in pairs(locais) do
            local distance = #(coords - vector3(v.x,v.y,v.z)) -- calcula coordenada - o valor da varia X
            if distance < 10 then -- Verifica a distancia caso seja menor que 10 metros aparecerá o blip caso contrário não
                DrawMarker(36, v.x, v.y, v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.15, 2.07, 1.44, 255, 239, 234, 100, 0, 0, 0, 1)
                time = 1
                if distance < 2 then -- se a distancia for entre 2 metros ativa a funcao de IsControlJustPressed
                    draw3dtext(v.x, v.y, v.z, "Pressione ~r~E~w~")
                    if IsControlJustPressed(0, 38) then
                        SetNuiFocus(true,true)
                        SendNUIMessage({ action = true})
                    end
                end
            end
        end
        Wait(time)
    end
end)

RegisterNUICallback("fechar",function(data)
    SetNuiFocus(false,false)
end)





function draw3dtext(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    SetTextFont(4)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 100)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
    local factor = (string.len(text)) / 300
    DrawRect(_x, _y + 0.0125, 0.01 + factor, 0.03, 0, 0, 0, 100)
end
