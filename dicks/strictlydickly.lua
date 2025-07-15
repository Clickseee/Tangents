local jumpscare_system = {
    active = false,
    timer = 0,
    enabled = true,
    current_image = 1,
    path = "Mods/Tangents/",
    loaded_images = {}
}
local function load_jumpscare_image(index)
    if jumpscare_system.loaded_images[index] then
        return jumpscare_system.loaded_images[index]
    end

    local filename = "jumpscare_"..index..".png"
    local full_path = jumpscare_system.path.."customimages/"..filename

    -- Verify file exists
    if not love.filesystem.getInfo(full_path) then
        print("[Terror Deck] Missing image:", filename)
        return nil
    end
    local success, img = pcall(function()
        local file_data = love.filesystem.newFileData(full_path)
        local img_data = love.image.newImageData(file_data)
        return love.graphics.newImage(img_data)
    end)

    if success and img then
        jumpscare_system.loaded_images[index] = img 
        return img
    else
        print("[Terror Deck] Failed to load image:", filename, "Error:", img)
        return nil
    end
end

SMODS.Back {
    key = "elon",
    loc_txt = {
        name = "Elon Dihh Deck",
        text = {
            "Start with {C:money}$250{}",
            "and a {C:dark_edition}Negative{} {C:attention}Mail-in Rebate{} Joker"
        }
    },
    unlocked = true,
    discovered = true,
    atlas = "dicks",
    pos = { x = 1, y = 1 },
    config = { dollars = 250 },

    apply = function(self)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.add_card({
                    key = "j_mail",
                    edition = "e_negative",
                    area = G.jokers,
                    discovered = true
                })
                return true
            end
        }))
    end
}

SMODS.Back {
    key = "pyro",
    loc_txt = {
        name = "Slop Deck",
        text = {
            "After defeating a blind:",
            "Spawn 1 common {C:attention}Joker{}",
            "and 1 random {C:attention}consumable{}"
        }
    },
    unlocked = true,
    discovered = true,
    atlas = "dicks",
    pos = { x = 0, y = 1 },
    calculate = function(self, back, context)
        if context.end_of_round and not context.repetition and not context.individual then
            if not G.GAME.blind.disabled then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        local joker_pool = {}
                        for _, joker in pairs(G.P_CENTERS) do
                            if joker.set == "Joker" and joker.rarity == 1 then
                                table.insert(joker_pool, joker.key)
                            end
                        end

                        if #joker_pool > 0 then
                            local joker_key = pseudorandom_element(joker_pool, pseudoseed('welcomebacktosloplive'))
                            SMODS.add_card({
                                set = "Joker",
                                rarity = "Common"
                            })
                        end

                        local consumable_types = { 'Tarot', 'Planet', 'Spectral' }
                        local chosen_type = pseudorandom_element(consumable_types, pseudoseed('thanksforsloppingby'))

                        SMODS.add_card({
                            set = chosen_type,
                            area = G.consumeables,
                            from_card = nil,
                            discovered = true
                        })

                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Back {
    key = "terror",
    loc_txt = {
        name = "Easy Deck",
        text = {
            "Start with",
            "a {C:attention}Rare Joker{} {C:dark_edition}(Eternal Negative)",
            "{C:green}1{} in {C:green}4{} chance",
            "for {C:attention}Negative Tag{} after blind"
        }
    },
    pos = { x = 2, y = 1 },
    atlas = 'dicks',
    unlocked = true,
    discovered = true,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                SMODS.add_card({
                    key = "j_tngt_flasbangout",
                    edition = "e_negative",
                    stickers = { "eternal" },
                    area = G.jokers,
                    discovered = true
                })
                return true
            end
        }))

        if not G.GAME.jumpscare_system then
            G.GAME.jumpscare_system = {
                active = false,
                timer = 0,
                images = {},
                current_image = 1,
                path = "Mods/Tangents/"
            }
        end
    end,

    calculate = function(self, back, context)
        if context.end_of_round and not context.blueprint then
            if pseudorandom('terror_tag') < 0.25 then
                pcall(function()
                    return {
                        message = "YO WAI-",
                        colour = G.C.PURPLE,
                        sound = 'tarot1',
                        func = function()
                            add_tag(Tag("tag_negative"))
                            play_sound('tngt_neverforget', 1.2)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.playing_card:juice_up(0.8, 0.5)
                                    return true
                                end
                            }))
                        end
                    }
                end)
            end

            if jumpscare_system.enabled and pseudorandom('terror_scare') < 0.5 then
                pcall(function()
                    G.E_MANAGER:add_event(Event({
                        delay = 1.5,
                        func = function()
                            jumpscare_system.current_image = pseudorandom(1, 5, pseudorandom('jumpscare_img'))
                            jumpscare_system.active = true
                            jumpscare_system.timer = 0.5
                        ,
                            pcall(function()
                                play_sound('holo1', 1.5, 0.8)
                            end)
                            
                            return true
                        end
                    }))
                end)
            end
        end
    end,

    locked_loc_vars = function(self, info_queue, back)
        return { vars = { "Complete a run with the Black Deck at stake level 3+" } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'win_deck' and get_deck_win_stake('b_black') >= 3
    end
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if jumpscare_system.active then
        jumpscare_system.timer = jumpscare_system.timer - dt
        if jumpscare_system.timer <= 0 then
            jumpscare_system.active = false
        end
    end
end
local drawhook = love.draw
function love.draw()
    drawhook()

    if jumpscare_system.active and jumpscare_system.enabled then
        local img = load_jumpscare_image(jumpscare_system.current_image)
        
        if img then
            local _xscale = love.graphics.getWidth() / 1920
            local _yscale = love.graphics.getHeight() / 1080
            local alpha = math.min(1, jumpscare_system.timer * 2)
            
            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(img, 0, 0, 0, _xscale, _yscale)
        else
            jumpscare_system.enabled = false
            jumpscare_system.active = false
            print("[Terror Deck] Jumpscare system disabled due to image load failure")
        end
    end
end
