import fs from "fs"
import stream from "stream"
import events from "events"

const listVars = {
    Card: [
        'H_2', 'H_3', 'H_4', 'H_5', 'H_6', 'H_7',
        'H_8', 'H_9', 'H_T', 'H_J', 'H_Q', 'H_K',
        'H_A', 'C_2', 'C_3', 'C_4', 'C_5', 'C_6',
        'C_7', 'C_8', 'C_9', 'C_T', 'C_J', 'C_Q',
        'C_K', 'C_A', 'D_2', 'D_3', 'D_4', 'D_5',
        'D_6', 'D_7', 'D_8', 'D_9', 'D_T', 'D_J',
        'D_Q', 'D_K', 'D_A', 'S_2', 'S_3', 'S_4',
        'S_5', 'S_6', 'S_7', 'S_8', 'S_9', 'S_T',
        'S_J', 'S_Q', 'S_K', 'S_A'
    ],
    Blind: [
        'bl_small',       'bl_big',
        'bl_ox',          'bl_hook',
        'bl_mouth',       'bl_fish',
        'bl_club',        'bl_manacle',
        'bl_tooth',       'bl_wall',
        'bl_house',       'bl_mark',
        'bl_final_bell',  'bl_wheel',
        'bl_arm',         'bl_psychic',
        'bl_goad',        'bl_water',
        'bl_eye',         'bl_plant',
        'bl_needle',      'bl_head',
        'bl_final_leaf',  'bl_final_vessel',
        'bl_window',      'bl_serpent',
        'bl_pillar',      'bl_flint',
        'bl_final_acorn', 'bl_final_heart'
    ],
    Stake: [
        'stake_white',
        'stake_red',
        'stake_green',
        'stake_black',
        'stake_blue',
        'stake_purple',
        'stake_orange',
        'stake_gold'
    ],
    Tag: [
        'tag_uncommon',   'tag_rare',
        'tag_negative',   'tag_foil',
        'tag_holo',       'tag_polychrome',
        'tag_investment', 'tag_voucher',
        'tag_boss',       'tag_standard',
        'tag_charm',      'tag_meteor',
        'tag_buffoon',    'tag_handy',
        'tag_garbage',    'tag_ethereal',
        'tag_coupon',     'tag_double',
        'tag_juggle',     'tag_d_six',
        'tag_top_up',     'tag_skip',
        'tag_orbital',    'tag_economy'
    ],
    Seal: [ 'Gold', 'Red', 'Blue', 'Purple' ]
}
const listCenter = {
    Joker: [
        'j_joker',            'j_greedy_joker',     'j_lusty_joker',
        'j_wrathful_joker',   'j_gluttenous_joker', 'j_jolly',
        'j_zany',             'j_mad',              'j_crazy',
        'j_droll',            'j_sly',              'j_wily',
        'j_clever',           'j_devious',          'j_crafty',
        'j_half',             'j_stencil',          'j_four_fingers',
        'j_mime',             'j_credit_card',      'j_ceremonial',
        'j_banner',           'j_mystic_summit',    'j_marble',
        'j_loyalty_card',     'j_8_ball',           'j_misprint',
        'j_dusk',             'j_raised_fist',      'j_chaos',
        'j_fibonacci',        'j_steel_joker',      'j_scary_face',
        'j_abstract',         'j_delayed_grat',     'j_hack',
        'j_pareidolia',       'j_gros_michel',      'j_even_steven',
        'j_odd_todd',         'j_scholar',          'j_business',
        'j_supernova',        'j_ride_the_bus',     'j_space',
        'j_egg',              'j_burglar',          'j_blackboard',
        'j_runner',           'j_ice_cream',        'j_dna',
        'j_splash',           'j_blue_joker',       'j_sixth_sense',
        'j_constellation',    'j_hiker',            'j_faceless',
        'j_green_joker',      'j_superposition',    'j_todo_list',
        'j_cavendish',        'j_card_sharp',       'j_red_card',
        'j_madness',          'j_square',           'j_seance',
        'j_riff_raff',        'j_vampire',          'j_shortcut',
        'j_hologram',         'j_vagabond',         'j_baron',
        'j_cloud_9',          'j_rocket',           'j_obelisk',
        'j_midas_mask',       'j_luchador',         'j_photograph',
        'j_gift',             'j_turtle_bean',      'j_erosion',
        'j_reserved_parking', 'j_mail',             'j_to_the_moon',
        'j_hallucination',    'j_fortune_teller',   'j_juggler',
        'j_drunkard',         'j_stone',            'j_golden',
        'j_lucky_cat',        'j_baseball',         'j_bull',
        'j_diet_cola',        'j_trading',          'j_flash',
        'j_popcorn',          'j_trousers',         'j_ancient',
        'j_ramen',            'j_walkie_talkie',    'j_selzer',
        'j_castle',           'j_smiley',           'j_campfire',
        'j_ticket',           'j_mr_bones',         'j_acrobat',
        'j_sock_and_buskin',  'j_swashbuckler',     'j_troubadour',
        'j_certificate',      'j_smeared',          'j_throwback',
        'j_hanging_chad',     'j_rough_gem',        'j_bloodstone',
        'j_arrowhead',        'j_onyx_agate',       'j_glass',
        'j_ring_master',      'j_flower_pot',       'j_blueprint',
        'j_wee',              'j_merry_andy',       'j_oops',
        'j_idol',             'j_seeing_double',    'j_matador',
        'j_hit_the_road',     'j_duo',              'j_trio',
        'j_family',           'j_order',            'j_tribe',
        'j_stuntman',         'j_invisible',        'j_brainstorm',
        'j_satellite',        'j_shoot_the_moon',   'j_drivers_license',
        'j_cartomancer',      'j_astronomer',       'j_burnt',
        'j_bootstraps',       'j_caino',            'j_triboulet',
        'j_yorick',           'j_chicot',           'j_perkeo'
    ],
    Tarot: [
        'c_fool',             'c_magician',
        'c_high_priestess',   'c_empress',
        'c_emperor',          'c_heirophant',
        'c_lovers',           'c_chariot',
        'c_justice',          'c_hermit',
        'c_wheel_of_fortune', 'c_strength',
        'c_hanged_man',       'c_death',
        'c_temperance',       'c_devil',
        'c_tower',            'c_star',
        'c_moon',             'c_sun',
        'c_judgement',        'c_world'
    ],
    Planet: [
        'c_mercury', 'c_venus',
        'c_earth',   'c_mars',
        'c_jupiter', 'c_saturn',
        'c_uranus',  'c_neptune',
        'c_pluto',   'c_planet_x',
        'c_ceres',   'c_eris'
    ],
    Spectral: [
        'c_familiar',    'c_grim',
        'c_incantation', 'c_talisman',
        'c_aura',        'c_wraith',
        'c_sigil',       'c_ouija',
        'c_ectoplasm',   'c_immolate',
        'c_ankh',        'c_deja_vu',
        'c_hex',         'c_trance',
        'c_medium',      'c_cryptid',
        'c_soul',        'c_black_hole'
    ],
    Voucher: [
        'v_overstock_norm', 'v_clearance_sale',
        'v_hone',           'v_reroll_surplus',
        'v_crystal_ball',   'v_telescope',
        'v_grabber',        'v_wasteful',
        'v_tarot_merchant', 'v_planet_merchant',
        'v_seed_money',     'v_blank',
        'v_magic_trick',    'v_hieroglyph',
        'v_directors_cut',  'v_paint_brush',
        'v_overstock_plus', 'v_liquidation',
        'v_glow_up',        'v_reroll_glut',
        'v_omen_globe',     'v_observatory',
        'v_nacho_tong',     'v_recyclomancy',
        'v_tarot_tycoon',   'v_planet_tycoon',
        'v_money_tree',     'v_antimatter',
        'v_illusion',       'v_petroglyph',
        'v_retcon',         'v_palette'
    ],
    Back: [
        'b_red',       'b_blue',
        'b_yellow',    'b_green',
        'b_black',     'b_magic',
        'b_nebula',    'b_ghost',
        'b_abandoned', 'b_checkered',
        'b_zodiac',    'b_painted',
        'b_anaglyph',  'b_plasma',
        'b_erratic'
    ],
        EnhancedCard: [
        'm_bonus', 'm_mult',
        'm_wild',  'm_glass',
        'm_steel', 'm_stone',
        'm_gold',  'm_lucky'
    ],
    Edition: [ 'e_base', 'e_foil', 'e_holo', 'e_polychrome', 'e_negative' ],
    Booster: [
        'p_arcana_normal_1',    'p_arcana_normal_2',
        'p_arcana_normal_3',    'p_arcana_normal_4',
        'p_arcana_jumbo_1',     'p_arcana_jumbo_2',
        'p_arcana_mega_1',      'p_arcana_mega_2',
        'p_celestial_normal_1', 'p_celestial_normal_2',
        'p_celestial_normal_3', 'p_celestial_normal_4',
        'p_celestial_jumbo_1',  'p_celestial_jumbo_2',
        'p_celestial_mega_1',   'p_celestial_mega_2',
        'p_spectral_normal_1',  'p_spectral_normal_2',
        'p_spectral_jumbo_1',   'p_spectral_mega_1',
        'p_standard_normal_1',  'p_standard_normal_2',
        'p_standard_normal_3',  'p_standard_normal_4',
        'p_standard_jumbo_1',   'p_standard_jumbo_2',
        'p_standard_mega_1',    'p_standard_mega_2',
        'p_buffoon_normal_1',   'p_buffoon_normal_2',
        'p_buffoon_jumbo_1',    'p_buffoon_mega_1'
    ],
    JustPos: ['soul', 'undiscovered_joker', 'undiscovered_tarot']
}

function *strCommon() {
    for (const [name, keyList] of Object.entries(listVars)) {
        const className = `balatro.ItemList.${name}`
        const typeName = `balatro.Item.${name}`

        yield `--- @class ${className}: { [string]: ${typeName} }\n`
        for (const k of keyList) {
            yield `--- @field ${k} ${typeName}\n`
        }
        yield `\n`
    }
}

function *strCenters() {
    let classList = []
    for (const [name, keyList] of Object.entries(listCenter)) {
        const className = `balatro.ItemList.Centers.${name}`
        const typeName = `balatro.Item.${name}`
        classList.push(className)

        yield `--- @class ${className}\n`
        for (const k of keyList) {
            yield `--- @field ${k} ${typeName}\n`
        }
        yield `\n`
    }

    yield `--- Prefix identifiers:\n`
    yield `--- - \`j\`: Joker\n`
    yield `--- - \`c\`: Consumable (Tarot, Planet, Spectral)\n`
    yield `--- - \`v\`: Voucher\n`
    yield `--- - \`b\`: Back (Deck)\n`
    yield `--- - \`m\`: Enhanced Card\n`
    yield `--- - \`e\`: Joker Edition\n`
    yield `--- - \`p\`: Booster packs\n`

    yield `--- @class balatro.ItemCenters: ${classList}, { [string]: any }\n`

    yield `--- @field c_base balatro.Item.Default\n`
}

function *str() {
    yield* strCommon()
    yield* strCenters()
}

const fd = fs.createWriteStream("item_proto_list.lua")
fd.write("-- Autogenerated from mklist.js\n\n")

const gen = stream.Readable.from(str())
gen.pipe(fd, { end: false })
await events.once(gen, "end")

fd.close()
