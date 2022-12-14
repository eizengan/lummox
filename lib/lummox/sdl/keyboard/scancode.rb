# frozen_string_literal: true

require "ffi"

# rubocop:disable Metrics/ModuleLength, Naming/VariableNumber

module Lummox::SDL::Keyboard
  Scancode = Lummox::SDL.enum(
    FFI::Type::INT,
    :scancode_unknown,             0,
    :scancode_a,                   4,
    :scancode_b,                   5,
    :scancode_c,                   6,
    :scancode_d,                   7,
    :scancode_e,                   8,
    :scancode_f,                   9,
    :scancode_g,                   10,
    :scancode_h,                   11,
    :scancode_i,                   12,
    :scancode_j,                   13,
    :scancode_k,                   14,
    :scancode_l,                   15,
    :scancode_m,                   16,
    :scancode_n,                   17,
    :scancode_o,                   18,
    :scancode_p,                   19,
    :scancode_q,                   20,
    :scancode_r,                   21,
    :scancode_s,                   22,
    :scancode_t,                   23,
    :scancode_u,                   24,
    :scancode_v,                   25,
    :scancode_w,                   26,
    :scancode_x,                   27,
    :scancode_y,                   28,
    :scancode_z,                   29,
    :scancode_1,                   30,
    :scancode_2,                   31,
    :scancode_3,                   32,
    :scancode_4,                   33,
    :scancode_5,                   34,
    :scancode_6,                   35,
    :scancode_7,                   36,
    :scancode_8,                   37,
    :scancode_9,                   38,
    :scancode_0,                   39,
    :scancode_return,              40,
    :scancode_escape,              41,
    :scancode_backspace,           42,
    :scancode_tab,                 43,
    :scancode_space,               44,
    :scancode_minus,               45,
    :scancode_equals,              46,
    :scancode_left_bracket,        47,
    :scancode_right_bracket,       48,
    :scancode_backslash,           49,
    :scancode_non_us_hash,         50,
    :scancode_semicolon,           51,
    :scancode_apostrophe,          52,
    :scancode_grave,               53,
    :scancode_comma,               54,
    :scancode_period,              55,
    :scancode_slash,               56,
    :scancode_caps_lock,           57,
    :scancode_f1,                  58,
    :scancode_f2,                  59,
    :scancode_f3,                  60,
    :scancode_f4,                  61,
    :scancode_f5,                  62,
    :scancode_f6,                  63,
    :scancode_f7,                  64,
    :scancode_f8,                  65,
    :scancode_f9,                  66,
    :scancode_f10,                 67,
    :scancode_f11,                 68,
    :scancode_f12,                 69,
    :scancode_print_screen,        70,
    :scancode_scroll_lock,         71,
    :scancode_pause,               72,
    :scancode_insert,              73,
    :scancode_home,                74,
    :scancode_pageup,              75,
    :scancode_delete,              76,
    :scancode_end,                 77,
    :scancode_page_down,           78,
    :scancode_right,               79,
    :scancode_left,                80,
    :scancode_down,                81,
    :scancode_up,                  82,
    :scancode_num_lock_clear,      83,
    :scancode_kp_divide,           84,
    :scancode_kp_multiply,         85,
    :scancode_kp_minus,            86,
    :scancode_kp_plus,             87,
    :scancode_kp_enter,            88,
    :scancode_kp_1,                89,
    :scancode_kp_2,                90,
    :scancode_kp_3,                91,
    :scancode_kp_4,                92,
    :scancode_kp_5,                93,
    :scancode_kp_6,                94,
    :scancode_kp_7,                95,
    :scancode_kp_8,                96,
    :scancode_kp_9,                97,
    :scancode_kp_0,                98,
    :scancode_kp_period,           99,
    :scancode_non_us_backslash,    100,
    :scancode_application,         101,
    :scancode_power,               102,
    :scancode_kp_equals,           103,
    :scancode_f13,                 104,
    :scancode_f14,                 105,
    :scancode_f15,                 106,
    :scancode_f16,                 107,
    :scancode_f17,                 108,
    :scancode_f18,                 109,
    :scancode_f19,                 110,
    :scancode_f20,                 111,
    :scancode_f21,                 112,
    :scancode_f22,                 113,
    :scancode_f23,                 114,
    :scancode_f24,                 115,
    :scancode_execute,             116,
    :scancode_help,                117,
    :scancode_menu,                118,
    :scancode_select,              119,
    :scancode_stop,                120,
    :scancode_again,               121,
    :scancode_undo,                122,
    :scancode_cut,                 123,
    :scancode_copy,                124,
    :scancode_paste,               125,
    :scancode_find,                126,
    :scancode_mute,                127,
    :scancode_volume_up,           128,
    :scancode_volume_down,         129,
    :scancode_kp_comma,            133,
    :scancode_kp_equals_as400,     134,
    :scancode_international_1,     135,
    :scancode_international_2,     136,
    :scancode_international_3,     137,
    :scancode_international_4,     138,
    :scancode_international_5,     139,
    :scancode_international_6,     140,
    :scancode_international_7,     141,
    :scancode_international_8,     142,
    :scancode_international_9,     143,
    :scancode_lang_1,              144,
    :scancode_lang_2,              145,
    :scancode_lang_3,              146,
    :scancode_lang_4,              147,
    :scancode_lang_5,              148,
    :scancode_lang_6,              149,
    :scancode_lang_7,              150,
    :scancode_lang_8,              151,
    :scancode_lang_9,              152,
    :scancode_alt_erase,           153,
    :scancode_sys_req,             154,
    :scancode_cancel,              155,
    :scancode_clear,               156,
    :scancode_prior,               157,
    :scancode_return_2,            158,
    :scancode_separator,           159,
    :scancode_out,                 160,
    :scancode_oper,                161,
    :scancode_clear_again,         162,
    :scancode_cr_sel,              163,
    :scancode_ex_sel,              164,
    :scancode_kp_00,               176,
    :scancode_kp_000,              177,
    :scancode_thousands_separator, 178,
    :scancode_decimal_separator,   179,
    :scancode_currency_unit,       180,
    :scancode_currency_subunit,    181,
    :scancode_kp_left_paren,       182,
    :scancode_kp_right_paren,      183,
    :scancode_kp_left_brace,       184,
    :scancode_kp_right_brace,      185,
    :scancode_kp_tab,              186,
    :scancode_kp_backspace,        187,
    :scancode_kp_a,                188,
    :scancode_kp_b,                189,
    :scancode_kp_c,                190,
    :scancode_kp_d,                191,
    :scancode_kp_e,                192,
    :scancode_kp_f,                193,
    :scancode_kp_xor,              194,
    :scancode_kp_power,            195,
    :scancode_kp_percent,          196,
    :scancode_kp_less,             197,
    :scancode_kp_greater,          198,
    :scancode_kp_ampersand,        199,
    :scancode_kp_dbl_ampersand,    200,
    :scancode_kp_vertical_bar,     201,
    :scancode_kp_dbl_vertical_bar, 202,
    :scancode_kp_colon,            203,
    :scancode_kp_hash,             204,
    :scancode_kp_space,            205,
    :scancode_kp_at,               206,
    :scancode_kp_exclam,           207,
    :scancode_kp_mem_store,        208,
    :scancode_kp_mem_recall,       209,
    :scancode_kp_mem_clear,        210,
    :scancode_kp_mem_add,          211,
    :scancode_kp_mem_subtract,     212,
    :scancode_kp_mem_multiply,     213,
    :scancode_kp_mem_divide,       214,
    :scancode_kp_plus_minus,       215,
    :scancode_kp_clear,            216,
    :scancode_kp_clear_entry,      217,
    :scancode_kp_binary,           218,
    :scancode_kp_octal,            219,
    :scancode_kp_decimal,          220,
    :scancode_kp_hexadecimal,      221,
    :scancode_lctrl,               224,
    :scancode_lshift,              225,
    :scancode_lalt,                226,
    :scancode_lgui,                227,
    :scancode_rctrl,               228,
    :scancode_rshift,              229,
    :scancode_ralt,                230,
    :scancode_rgui,                231,
    :scancode_mode,                257,
    :scancode_audio_next,          258,
    :scancode_audio_prev,          259,
    :scancode_audio_stop,          260,
    :scancode_audio_play,          261,
    :scancode_audio_mute,          262,
    :scancode_media_select,        263,
    :scancode_www,                 264,
    :scancode_mail,                265,
    :scancode_calculator,          266,
    :scancode_computer,            267,
    :scancode_ac_search,           268,
    :scancode_ac_home,             269,
    :scancode_ac_back,             270,
    :scancode_ac_forward,          271,
    :scancode_ac_stop,             272,
    :scancode_ac_refresh,          273,
    :scancode_ac_bookmarks,        274,
    :scancode_brightness_down,     275,
    :scancode_brightness_up,       276,
    :scancode_display_switch,      277,
    :scancode_kbd_illum_toggle,    278,
    :scancode_kbd_illum_down,      279,
    :scancode_kbd_illum_up,        280,
    :scancode_eject,               281,
    :scancode_sleep,               282,
    :scancode_app_1,               283,
    :scancode_app_2,               284,
    :scancode_audio_rewind,        285,
    :scancode_audio_fastforward,   286,
    :scancode_soft_left,           287,
    :scancode_soft_right,          288,
    :scancode_call,                289,
    :scancode_end_call,            290,
    :num_scancodes,                512
  ).freeze
end

# rubocop:enable all
