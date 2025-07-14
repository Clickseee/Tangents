local jumpscare_state = {
    active = false,
    timer = 0,
    images = {},
    current_image = 1,
    path = "Mods/Tangents/" 
}

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
        if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
            if pseudorandom('terror_tag') < 0.25 then
                return {
                    sound = 'tarot1',
                    func = function()
                        add_tag(Tag("tag_negative"))
                        play_sound('tngt_neverforget', 1.2)
                    end
                }
            end

            if pseudorandom('terror_scare') < 0.5 then
                G.E_MANAGER:add_event(Event({
                    delay = 1.5,
                    func = function()
                        jumpscare_state.current_image = pseudorandom(1, 5, pseudorandom('jumpscare_img'))
                        jumpscare_state.active = true
                        jumpscare_state.timer = 0.5
                        play_sound('tngt_jumpscare'..pseudorandom("fuckface",1, 5))
                        return true
                    end
                }))
            end
        end
    end
}

local updatehook = Game.update
function Game:update(dt)
    updatehook(self, dt)
    if jumpscare_state.active then
        jumpscare_state.timer = jumpscare_state.timer - dt
        if jumpscare_state.timer <= 0 then
            jumpscare_state.active = false
        end
    end
end


local drawhook = love.draw
function love.draw()
    drawhook()

    if jumpscare_state.active then
        
        if #jumpscare_state.images == 0 then
            for i = 1, 5 do
                local full_path = jumpscare_state.path .. "assets/customimages/jumpscare_" .. i .. ".png"
                if love.filesystem.getInfo(full_path) then
                    local file_data = love.filesystem.newFileData(full_path)
                    local tempimagedata = love.image.newImageData(file_data)
                    jumpscare_state.images[i] = love.graphics.newImage(tempimagedata)
                else
                    jumpscare_state.images[i] = love.graphics.newImage(1, 1)
                    print("Jumpscare image missing: " .. full_path)
                end
            end
        end

        local _xscale = love.graphics.getWidth() / 1920
        local _yscale = love.graphics.getHeight() / 1080
        local alpha = math.min(1, jumpscare_state.timer * 2)

        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.draw(
            jumpscare_state.images[jumpscare_state.current_image],
            0, 0, 0, _xscale, _yscale
        )
    end
end
