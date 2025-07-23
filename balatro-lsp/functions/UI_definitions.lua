--- @meta

function create_UIBox_debug_tools() end
function create_UIBox_notify_alert(_achievement, _type) end
function create_UIBox_online_high_scores() end
function create_UIBox_high_scores_filling(_resp) end
function create_UIBox_highlight(rect) end
function create_UIBox_character_button(args) end
function create_card_for_shop(area) end
function create_shop_card_ui(card, type, area) end
function attention_text(args) end
function create_UIBox_buttons() end
function desc_from_rows(desc_nodes, empty, maxw) end
function transparent_multiline_text(desc_nodes) end
function info_tip_from_rows(desc_nodes, name) end
function overlay_infotip(text_rows) end
function name_from_rows(name_nodes, background_colour) end
function get_badge_colour(key) end
function create_badge(_string, _badge_col, _text_col, scaling) end
function create_UIBox_detailed_tooltip(_center) end
function create_popup_UIBox_tooltip(tooltip) end
function create_UIBox_HUD_blind() end
function add_tag(_tag) end
function create_UIBox_HUD() end
function create_UIBox_blind_select() end
function create_UIBox_blind_tag(blind_choice, run_info) end
function create_UIBox_blind_choice(type, run_info) end
function create_UIBox_round_evaluation() end
function create_UIBox_arcana_pack() end
function create_UIBox_spectral_pack() end
function create_UIBox_standard_pack() end
function create_UIBox_buffoon_pack() end
function create_UIBox_celestial_pack() end
function create_UIBox_card_alert(args) end
function create_slider(args) end
function create_toggle(args) end
function create_option_cycle(args) end
function create_tabs(args) end
function create_text_input(args) end
function create_keyboard_input(args) end
function create_keyboard_button(key, binding) end
function create_dynatext_pips(args) end
function create_UIBox_options() end
function create_UIBox_settings() end
function create_UIBox_test_framework(variables) end
function create_UIBox_usage(args) end
function create_UIBox_customize_deck() end
function create_UIBox_high_scores() end
function create_progress_box(_profile_progress, smaller) end
function create_UIBox_high_scores_row(score) end
function create_UIBox_win() end
function create_UIBox_exit_CTA() end
function create_UIBox_small_cta() end
function create_UIBox_demo_video_CTA() end
function create_UIBox_game_over() end
function create_UIBox_round_scores_row(score, text_colour) end
function create_UIBox_hand_tip(handname) end
function create_UIBox_current_hand_row(handname, simple) end
function create_UIBox_current_hands(simple) end
function tally_sprite(pos, value, tooltip) end
function create_UIBox_your_collection() end
function create_UIBox_your_collection_jokers() end
function create_UIBox_your_collection_tarots() end
function create_UIBox_your_collection_boosters() end
function create_UIBox_your_collection_planets() end
function create_UIBox_your_collection_spectrals() end
function create_UIBox_your_collection_vouchers(exit) end
function create_UIBox_your_collection_seals(exit) end
function create_UIBox_your_collection_enhancements(exit) end
function create_UIBox_your_collection_editions() end
function create_UIBox_your_collection_decks() end
function create_UIBox_your_collection_tags() end
function create_UIBox_your_collection_blinds(exit) end
function create_UIBox_blind_popup(blind, discovered, vars) end
function create_UIBox_card_unlock(card_center) end
function create_UIBox_deck_unlock(deck_center) end
function create_button_binding_pip(args) end
function create_UIBox_profile_button() end
function create_UIBox_main_menu_buttons() end
function create_UIBox_main_menu_competittion_name() end
function create_UIBox_highlight(rect) end
function create_UIBox_generic_options(args) end
function UIBox_dyn_container(inner_table, horizontal, colour_override, background_override, flipped, padding) end
function simple_text_container(_loc, args) end
function UIBox_button(args) end

--- @class balatro.CreateTooltipParam
--- @field title? string
--- @field text? ( string | { ref_table: any, ref_value: any } )[]
--- @field filler? { func: fun(), args?: any }

--- @class balatro.Game
--- @field UIDEF balatro.Functions.Uidef

--- @class balatro.Functions.Uidef
--- @field use_and_sell_buttons fun(card)
--- @field card_focus_ui fun(card)
--- @field card_focus_button fun(args)
--- @field speech_bubble fun(text_key, loc_vars)
--- @field deck_preview fun(args)
--- @field shop fun()
--- @field card_h_popup fun(card)
--- @field settings_tab fun(tab)
--- @field usage_tabs fun()
--- @field custom_deck_tab fun(_suit)
--- @field deck_info fun(_show_remaining)
--- @field run_info fun()
--- @field current_blinds fun()
--- @field deck_stake_column fun(_deck_key)
--- @field current_stake fun()
--- @field view_deck fun(unplayed_only)
--- @field used_vouchers fun()
--- @field multiline_credit_text fun(_lines)
--- @field viewed_collab_option fun(_new_option)
--- @field credits fun()
--- @field challenges fun(from_game_over)
--- @field daily_overview fun()
--- @field run_setup fun(from_game_over)
--- @field profile_select fun()
--- @field profile_option fun(_profile)
--- @field stake_description fun(_stake)
--- @field stake_option fun(_type)
--- @field viewed_stake_option fun()
--- @field challenge_list fun(from_game_over)
--- @field challenge_list_page fun(_page)
--- @field challenge_description fun(_id, daily, is_row)
--- @field challenge_description_tab fun(args)
--- @field run_setup_option fun(type)
--- @field language_selector fun()