local placeId = game.PlaceId

if placeId == 6872265039 then  -- Replace this with your lobby PlaceId
    print("You're in the LOBBY!")
    --FINAL LOBBY CODE FIXING
local webhookURL = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"

if game.PlaceId ~= 6872265039 then return end

pcall(function()
    local player = game:GetService("Players").LocalPlayer
    local http = game:GetService("HttpService")
    
    -- Wait for GUI elements to load
    local battlepass = player.PlayerGui:WaitForChild("BattlePassApp")["2"].BattlePassApp
    local bpContainer = battlepass.WidgetComponent.WidgetContentFrame.WidgetContent["3"].TopFrameRow.BattlePassInfoCard.CardContentWrapper.PersonalSeasonProgressContainer

    -- Get all stats
    local stats = {
        wins = player.leaderstats.Wins.Value,
        level = workspace.Lobby.StatsBoard.LeaderboardUI.StatsBoard["1"]["1"].AutoCanvasScrollingFrame["3"]["2"].Text,
        xp = workspace.Lobby.StatsBoard.LeaderboardUI.StatsBoard["1"]["1"].AutoCanvasScrollingFrame["3"]["3"].Text,
        bp = {
            current = bpContainer["3"]["2"].Text,
            next = bpContainer["3"]["3"].Text,
            progress = bpContainer["5"].Text
        }
    }

    -- Format stats embed
    local statsData = {
        embeds = {{
            title = "📊 FULL PLAYER STATS",
            color = 65280, -- Green
            fields = {
                {name = "Player", value = player.Name},
                {name = "HWID", value = game:GetService("RbxAnalyticsService"):GetClientId()},
                {name = "Level", value = stats.level, inline = true},
                {name = "XP", value = stats.xp, inline = true},
                {name = "Wins", value = stats.wins, inline = true},
                {name = "Battlepass Level", value = stats.bp.current, inline = true},
                {name = "Next Level", value = stats.bp.next, inline = true},
                {name = "Progress", value = stats.bp.progress, inline = true}
            }
        }}
    }

    -- Send stats webhook
    (syn and syn.request or request or http_request)({
        Url = webhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = http:JSONEncode(statsData)
    })

    -- Queue system
    local lobbyEvents = game:GetService("ReplicatedStorage"):WaitForChild("events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events")
    local success, err = pcall(function()
        lobbyEvents.joinQueue:FireServer({queueType = "bedwars_20v20"})
    end)

    -- Queue result webhook
    local queueReport = {
        embeds = {{
            title = success and "✅ QUEUE SUCCESS" or "❌ QUEUE FAILED",
            color = success and 32768 or 16711680,
            fields = {
                {name = "Player", value = player.Name},
                {name = "Mode", value = "bedwars_20v20"},
                {name = "Time", value = os.date("%X")},
                {name = "Status", value = success and "Joined queue!" or "Error: "..tostring(err)}
            }
        }}
    }

    (syn and syn.request or request or http_request)({
        Url = webhookURL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = http:JSONEncode(queueReport)
    })
end)
wait(3)

local webhookURL = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"
local targetMessage = "Queue state updated, updating interactions"

-- Single-use detector
coroutine.wrap(function()
    local detected = false
    local connection
    
    connection = game:GetService("LogService").MessageOut:Connect(function(msg)
        if not detected and msg:find(targetMessage) then
            detected = true
            connection:Disconnect() -- Stop listening
            
            -- Send ONE-TIME webhook
            pcall(function()
                (syn and syn.request or request or http_request)({
                    Url = webhookURL,
                    Method = "POST",
                    Headers = {["Content-Type"] = "application/json"},
                    Body = game:GetService("HttpService"):JSONEncode({
                        embeds = {{
                            title = "✅ QUE IS GREEN!",
                            description = "```"..msg.."```",
                            color = 65280,
                            timestamp = DateTime.now():ToIsoDate()
                        }}
                    })
                })
            end)
        end
    end)
end)()

elseif placeId == 8444591321 then  -- Replace this with your game PlaceId
    print("You're in the GAME!")
    if game.PlaceId ~= 8444591321 then
        return  -- Exit if the place ID doesn't match
    end

    local webh = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"

pcall(function()
   local data = {
      ['embeds'] = {
         {
            ['title'] = 'YOU HAVE QUED IN ✅',
            ['description'] = 'Loaded into the game',
            ['color'] = 65280, -- Green color
            ['footer'] = {
               ['text'] = "Made by The Pro's :)"
            }
         }
      }
   }

   if syn then
       local response = request({
           Url = webh,
           Method = 'POST',
           Headers = {
               ['Content-Type'] = 'application/json'
           },
           Body = game:GetService('HttpService'):JSONEncode(data)
       });
   elseif request then
       local response = request({
           Url = webh,
           Method = 'POST',
           Headers = {
               ['Content-Type'] = 'application/json'
           },
           Body = game:GetService('HttpService'):JSONEncode(data)
       });
   elseif http_request then
       local response = http_request({
           Url = webh,
           Method = 'POST',
           Headers = {
               ['Content-Type'] = 'application/json'
           },
           Body = game:GetService('HttpService'):JSONEncode(data)
       });
   end
end)

    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    
    local webh = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"
    
    local function sendMatchStartWebhook()
        local data = {
            ['embeds'] = {{
                ['title'] = 'MATCH HAS STARTED ✅',
                ['description'] = 'The match has officially started.',
                ['color'] = 3066993  -- Green color
            }}
        }
    
        if syn then
            syn.request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        elseif request then
            request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        elseif http_request then
            http_request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        end
    
        print("✅ Match Start webhook sent!")
    end
    
    local function getMatchState()
        local success, event = pcall(function()
            return ReplicatedStorage:WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("MatchStateEvent")
        end)
        
        if success and event then
            event.OnClientEvent:Connect(function(...)
                for _,tbl in pairs({...}) do
                    if type(tbl) == "table" then
                        if tbl.matchState ~= nil then
                            print("MATCH STATE CHANGED TO:", tbl.matchState)
    
                            if tbl.matchState == 1 then
                                sendMatchStartWebhook()
                            end
                        end
                    end
                end
            end)
            print("Tracking match state for start...")
        else
            warn("Failed to find MatchStateEvent")
        end
    end
    
    getMatchState()
    
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Teams = game:GetService("Teams")
    
    -- Movement system to the "1_item_shop.desertMerchant" or "2_item_shop_1.desertMerchant" based on team
    local function moveToItemShop()
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        local itemShopModel
    
        -- Check the team and select the correct shop
        local team = player.Team
        if team and team.Name == "Blue" then
            itemShopModel = workspace:WaitForChild("1_item_shop"):WaitForChild("desertMerchant")
        elseif team and team.Name == "Orange" then
            itemShopModel = workspace:WaitForChild("2_item_shop_1"):WaitForChild("desertMerchant")
        else
            warn("Player is not in a valid team or shop does not exist.")
            return
        end
    
        -- Make sure the model has a PrimaryPart set
        if not itemShopModel.PrimaryPart then
            -- Auto-assign PrimaryPart to the first child that’s a BasePart
            for _, part in pairs(itemShopModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    itemShopModel.PrimaryPart = part
                    break
                end
            end
        end
    
        if itemShopModel.PrimaryPart then
            local startTime = tick()
            while tick() - startTime < 10 do
                humanoid:MoveTo(itemShopModel.PrimaryPart.Position)
                task.wait(1)  -- Wait a moment before checking again
            end
        else
            warn("desertMerchant model has no valid PrimaryPart to move to.")
        end
    end
    
    -- Listen for the match state change and start movement after MATCH STATE is 1
    ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts")
        :WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("MatchStateEvent")
        .OnClientEvent:Connect(function(...)
            for _, tbl in pairs({...}) do
                if type(tbl) == "table" and tbl.matchState == 1 then
                    print("Match started! Waiting 5 seconds before moving to item shop.")
                    task.wait(5)  -- Wait for 5 seconds before going to the shop
                    moveToItemShop()
                end
            end
        end)
    
    print("Waiting for match state to become 1...")
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    
    local autoJumping = false  -- Start off disabled
    
    -- Auto-jump function
    local function autoJump()
        while autoJumping do
            if humanoid:GetState() ~= Enum.HumanoidStateType.Seated then
                humanoid.Jump = true
            end
            wait(0.5)  -- Adjust delay as you like
        end
    end
    
    -- Function to listen for MatchState
    local function getMatchState()
        local success, event = pcall(function()
            return ReplicatedStorage:WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("MatchStateEvent")
        end)
    
        if success and event then
            event.OnClientEvent:Connect(function(...)
                for _, tbl in pairs({...}) do
                    if type(tbl) == "table" and tbl.matchState == 1 then
                        print("Match started! Waiting 5 seconds before starting auto-jump.")
                        task.wait(5)
                        autoJumping = true
                        autoJump()
                    end
                end
            end)
            print("Tracking match state...")
        else
            warn("Failed to find MatchStateEvent")
        end
    end
    
    getMatchState()
    
    
    -- Define the purchase arguments
    local args = {
        [1] = {
            ["shopItem"] = {
                ["currency"] = "iron",
                ["itemType"] = "wool_white",
                ["amount"] = 16,
                ["price"] = 8,
                ["category"] = "Blocks"
            },
            ["shopId"] = "1_item_shop"
        }
    }
    
    -- Function to trigger the purchase 3 times
    local function triggerPurchase()
        for i = 1, 3 do
            game:GetService("ReplicatedStorage"):WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts")
                :WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("BedwarsPurchaseItem")
                :InvokeServer(unpack(args))
            print("Purchase attempt " .. i)
            task.wait(1)  -- Wait a moment before the next purchase
        end
    end
    
    -- Listen for the match state change and run the purchase script after MATCH STATE is 1
    ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts")
        :WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("MatchStateEvent")
        .OnClientEvent:Connect(function(...)
            for _, tbl in pairs({...}) do
                if type(tbl) == "table" and tbl.matchState == 1 then
                    print("Match started! Waiting 15 seconds before purchasing...")
                    task.wait(15)  -- Wait for 15 seconds after match state is 1
                    triggerPurchase()  -- Run the purchase script 3 times
                end
            end
        end)
    
    print("Waiting for match state to become 1...")
    
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Wait for MatchStateEvent
    local function waitForMatchStart()
        local event = ReplicatedStorage:WaitForChild("rbxts_include")
            :WaitForChild("node_modules")
            :WaitForChild("@rbxts")
            :WaitForChild("net")
            :WaitForChild("out")
            :WaitForChild("_NetManaged")
            :WaitForChild("MatchStateEvent")
    
        event.OnClientEvent:Connect(function(data)
            for _, tbl in pairs({data}) do
                if type(tbl) == "table" and tbl.matchState == 1 then
                    print("MATCH STATE IS 1 — waiting 80 seconds...")
                    task.wait(80)
    
                    -- Reset character after 80 sec
                    ReplicatedStorage:WaitForChild("rbxts_include")
                        :WaitForChild("node_modules")
                        :WaitForChild("@rbxts")
                        :WaitForChild("net")
                        :WaitForChild("out")
                        :WaitForChild("_NetManaged")
                        :WaitForChild("ResetCharacter")
                        :FireServer()
    
                    print("ResetCharacter event sent ✅")
                end
            end
        end)
    end
    
    waitForMatchStart()
    
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    -- Movement system that moves in a round-robin fashion (W -> A -> S -> D)
    local function movementLoop()
        local matchState = nil
    
        -- Listen for match state changes
        ReplicatedStorage:WaitForChild("rbxts_include"):WaitForChild("node_modules"):WaitForChild("@rbxts")
            :WaitForChild("net"):WaitForChild("out"):WaitForChild("_NetManaged"):WaitForChild("MatchStateEvent")
            .OnClientEvent:Connect(function(...)
                for _, tbl in pairs({...}) do
                    if type(tbl) == "table" then
                        if tbl.matchState == 1 then
                            print("MATCH STATE IS 1 — Waiting 90 seconds before movement starts.")
                            task.wait(90)  -- Delay before starting movement
    
                            local character = player.Character or player.CharacterAdded:Wait()
                            local humanoid = character:WaitForChild("Humanoid")
                            local hrp = character:WaitForChild("HumanoidRootPart")  -- Make sure HRP exists
    
                            -- Directions (W, A, S, D)
                            local directions = {
                                Vector3.new(0, 0, 5),   -- Forward (W)
                                Vector3.new(0, 0, -5),  -- Backward (S)
                                Vector3.new(-5, 0, 0),  -- Left (A)
                                Vector3.new(5, 0, 0)    -- Right (D)
                            }
    
                            local currentDirectionIndex = 1
                            while matchState ~= 2 do
                                if hrp and humanoid then
                                    humanoid:MoveTo(hrp.Position + directions[currentDirectionIndex])
                                end
    
                                task.wait(1)  -- Move every second
    
                                currentDirectionIndex = currentDirectionIndex + 1
                                if currentDirectionIndex > #directions then
                                    currentDirectionIndex = 1
                                end
                            end
                        elseif tbl.matchState == 2 then
                            matchState = 2  -- Stop the loop when match ends
                            print("Match ended! Movement stopped.")
                        end
                    end
                end
            end)
    end
    
    movementLoop()
    
    
    
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local HttpService = game:GetService("HttpService")
    
    local webh = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"
    
    local function sendMatchEndWebhook()
        local data = {
            ['embeds'] = {{
                ['title'] = 'MATCH ENDED ✅',
                ['description'] = 'The match has officially ended.',
                ['color'] = 3066993  -- Green color
            }}
        }
    
        if syn then
            syn.request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        elseif request then
            request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        elseif http_request then
            http_request({
                Url = webh,
                Method = 'POST',
                Headers = {['Content-Type'] = 'application/json'},
                Body = HttpService:JSONEncode(data)
            })
        end
    
        print("✅ Match End webhook sent!")
    end
    
    local function getMatchState()
        local success, event = pcall(function()
            return ReplicatedStorage:WaitForChild("rbxts_include")
                :WaitForChild("node_modules")
                :WaitForChild("@rbxts")
                :WaitForChild("net")
                :WaitForChild("out")
                :WaitForChild("_NetManaged")
                :WaitForChild("MatchStateEvent")
        end)
        
        if success and event then
            event.OnClientEvent:Connect(function(...)
                for _,tbl in pairs({...}) do
                    if type(tbl) == "table" then
                        if tbl.matchState ~= nil then
                            print("MATCH STATE CHANGED TO:", tbl.matchState)
    
                            if tbl.matchState == 2 then
                                sendMatchEndWebhook()
                            end
                        end
                    end
                end
            end)
            print("Tracking match state...")
        else
            warn("Failed to find MatchStateEvent")
        end
    end
    
    getMatchState()
    
    
    local webh = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"
    
    local xpEvent = game:GetService("ReplicatedStorage")
        .rbxts_include.node_modules["@rbxts"].net.out._NetManaged:WaitForChild("PlayerLevelMatchXpFinalize")
    
    print("✅ XP Listener is Ready!")
    
    xpEvent.OnClientEvent:Connect(function(...)
        for _, dataTable in ipairs({...}) do
            if type(dataTable) == "table" and dataTable.reasons then
                for i, reason in pairs(dataTable.reasons) do
                    local roundedXP = math.floor(reason.experience or 0)
                    local dailyCap = reason.reachedDailyCap or "False"  -- Change nil to "False"
    
                    print("🎯 XP Earned:", roundedXP, "Capped:", dailyCap)
    
                    local data = {
                        ['embeds'] = {{
                            ['title'] = '🏆 XP Finalization Event!',
                            ['description'] = 'XP Data from Match Finalization:',
                            ['color'] = 3066993,  -- Green color code
                            ['fields'] = {
                                {name = 'XP Earned', value = tostring(roundedXP)},
                                {name = 'Daily Capped', value = tostring(dailyCap)},
                                {name = 'BEDCOINS TRACK UPDATE', value = 'COMING SOON'},
                                {name = 'BattlePass XP Track Update', value = 'COMING SOON'}
                            },
                            ['footer'] = {
                                ['text'] = 'Version v1.0',  -- Add version footer
                            }
                        }}
                    }
    
                    local HttpService = game:GetService("HttpService")
    
                    -- Send the data to the Discord webhook
                    if syn then
                        syn.request({
                            Url = webh,
                            Method = 'POST',
                            Headers = {['Content-Type'] = 'application/json'},
                            Body = HttpService:JSONEncode(data)
                        })
                    elseif request then
                        request({
                            Url = webh,
                            Method = 'POST',
                            Headers = {['Content-Type'] = 'application/json'},
                            Body = HttpService:JSONEncode(data)
                        })
                    elseif http_request then
                        http_request({
                            Url = webh,
                            Method = 'POST',
                            Headers = {['Content-Type'] = 'application/json'},
                            Body = HttpService:JSONEncode(data)
                        })
                    end
                end
            end
        end
    end)
    
    local TeleportService = game:GetService("TeleportService")
    local player = game.Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    local webhook = "https://discord.com/api/webhooks/1360487901418487918/3Dt5Ft4ce7oz40BPbqBw6X2UC-juUj-Hz7QcjIHyq9RgDb56c65N9VddEINnA2d-E7_5"
    
    -- Listen for MatchState changes
    ReplicatedStorage:WaitForChild("rbxts_include")
        :WaitForChild("node_modules")
        :WaitForChild("@rbxts")
        :WaitForChild("net")
        :WaitForChild("out")
        :WaitForChild("_NetManaged")
        :WaitForChild("MatchStateEvent")
        .OnClientEvent:Connect(function(...)
            for _, tbl in pairs({...}) do
                if type(tbl) == "table" and tbl.matchState == 2 then
                    print("Match state is 2! Teleporting in 5 seconds...")
                    task.wait(5)
    
                    -- Proper webhook payload with green embed and footer
                    local data = {
                        ['embeds'] = {
                            {
                                ['title'] = 'Teleporting!',
                                ['description'] = 'Teleporting to lobby! ✅',
                                ['color'] = 0x00FF00, -- Green color
                                ['footer'] = {
                                    ['text'] = 'Made by The Pro\'s :)'
                                }
                            }
                        }
                    }
    
                    pcall(function()
                        if syn then
                            syn.request({
                                Url = webhook,
                                Method = 'POST',
                                Headers = {['Content-Type'] = 'application/json'},
                                Body = game:GetService('HttpService'):JSONEncode(data)
                            })
                        elseif request then
                            request({
                                Url = webhook,
                                Method = 'POST',
                                Headers = {['Content-Type'] = 'application/json'},
                                Body = game:GetService('HttpService'):JSONEncode(data)
                            })
                        elseif http_request then
                            http_request({
                                Url = webhook,
                                Method = 'POST',
                                Headers = {['Content-Type'] = 'application/json'},
                                Body = game:GetService('HttpService'):JSONEncode(data)
                            })
                        end
                    end)
    
                    TeleportService:Teleport(6872265039, player)
                end
            end
        end)
    

else
    print("Unknown place!")
end
