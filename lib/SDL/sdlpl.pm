# sub sdlpl.pm
#
#	1.12 compatability layer
#
#	Copyright (C) 2002 David J. Goehrig
#

package SDL::sub sdlpl;
use SDL;

print STDERR "Using SDL::sub sdlpl 1.12 compatability layer\n";

sub sdl_sdl_perl_timer_callback      { SDL::sdl_perl_timer_callback          (@_) };
sub sdl_get_error                    { SDL::GetError                         () };
sub sdl_init_audio                   { SDL::INIT_AUDIO                       () };
sub sdl_init_video                   { SDL::INIT_VIDEO                       () };
sub sdl_init_cdrom                   { SDL::INIT_CDROM                       () };
sub sdl_init_everything              { SDL::INIT_EVERYTHING                  () };
sub sdl_init_noparachute             { SDL::INIT_NOPARACHUTE                 () };
sub sdl_init_joystick                { SDL::INIT_JOYSTICK                    () };
sub sdl_init                         { SDL::Init                             (@_) };
sub sdl_init_sub_system              { SDL::InitSubSystem                    (@_) };
sub sdl_quit_sub_system              { SDL::QuitSubSystem                    (@_) };
sub sdl_quit                         { SDL::Quit                             () };
sub sdl_was_init                     { SDL::WasInit                          (@_) };
sub sdl_delay                        { SDL::Delay                            (@_) };
sub sdl_get_ticks                    { SDL::GetTicks                         () };
sub sdl_set_timer                    { SDL::SetTimer                         (@_) };
sub sdl_add_timer                    { SDL::AddTimer                         (@_) };
sub sdl_perl_timer_callback          { SDL::PerlTimerCallback                () };
sub sdl_new_timer                    { SDL::NewTimer                         (@_) };
sub sdl_remove_timer                 { SDL::RemoveTimer                      (@_) };
sub sdl_cd_num_drives                { SDL::CDNumDrives                      () };
sub sdl_cd_name                      { SDL::CDName                           (@_) };
sub sdl_cd_open                      { SDL::CDOpen                           (@_) };
sub sdl_cd_track_listing             { SDL::CDTrackListing                   (@_) };
sub sdl_cd_track_id                  { SDL::CDTrackId                        (@_) };
sub sdl_cd_track_type                { SDL::CDTrackType                      (@_) };
sub sdl_cd_track_length              { SDL::CDTrackLength                    (@_) };
sub sdl_cd_track_offset              { SDL::CDTrackOffset                    (@_) };
sub sdl_cd_trayempty                 { SDL::CD_TRAYEMPTY                     () };
sub sdl_cd_playing                   { SDL::CD_PLAYING                       () };
sub sdl_cd_stopped                   { SDL::CD_STOPPED                       () };
sub sdl_cd_paused                    { SDL::CD_PAUSED                        () };
sub sdl_cd_error                     { SDL::CD_ERROR                         () };
sub sdl_cd_status                    { SDL::CDStatus                         (@_) };
sub sdl_cd_play_tracks               { SDL::CDPlayTracks                     (@_) };
sub sdl_cd_play                      { SDL::CDPlay                           (@_) };
sub sdl_cd_pause                     { SDL::CDPause                          (@_) };
sub sdl_cd_resume                    { SDL::CDResume                         (@_) };
sub sdl_cd_stop                      { SDL::CDStop                           (@_) };
sub sdl_cd_eject                     { SDL::CDEject                          (@_) };
sub sdl_cd_close                     { SDL::CDClose                          (@_) };
sub sdl_cd_num_tracks                { SDL::CDNumTracks                      (@_) };
sub sdl_cd_cur_track                 { SDL::CDCurTrack                       (@_) };
sub sdl_cd_cur_frame                 { SDL::CDCurFrame                       (@_) };
sub sdl_cd_track                     { SDL::CDTrack                          (@_) };
sub sdl_pump_events                  { SDL::PumpEvents                       () };
sub sdl_new_event                    { SDL::NewEvent                         () };
sub sdl_free_event                   { SDL::FreeEvent                        (@_) };
sub sdl_poll_event                   { SDL::PollEvent                        (@_) };
sub sdl_wait_event                   { SDL::WaitEvent                        (@_) };
sub sdl_event_state                  { SDL::EventState                       (@_) };
sub sdl_ignore                       { SDL::IGNORE                           () };
sub sdl_enable                       { SDL::ENABLE                           () };
sub sdl_query                        { SDL::QUERY                            () };
sub sdl_activeevent                  { SDL::ACTIVEEVENT                      () };
sub sdl_keydown                      { SDL::KEYDOWN                          () };
sub sdl_keyup                        { SDL::KEYUP                            () };
sub sdl_mousemotion                  { SDL::MOUSEMOTION                      () };
sub sdl_mousebuttondown              { SDL::MOUSEBUTTONDOWN                  () };
sub sdl_mousebuttonup                { SDL::MOUSEBUTTONUP                    () };
sub sdl_quit                         { SDL::QUIT                             () };
sub sdl_syswmevent                   { SDL::SYSWMEVENT                       () };
sub sdl_event_type                   { SDL::EventType                        (@_) };
sub sdl_active_event_gain            { SDL::ActiveEventGain                  (@_) };
sub sdl_active_event_state           { SDL::ActiveEventState                 (@_) };
sub sdl_appmousefocus                { SDL::APPMOUSEFOCUS                    () };
sub sdl_appinputfocus                { SDL::APPINPUTFOCUS                    () };
sub sdl_appactive                    { SDL::APPACTIVE                        () };
sub sdl_key_event_state              { SDL::KeyEventState                    (@_) };
sub sdl_sdlk_backspace               { SDL::SDLK_BACKSPACE                   () };
sub sdl_sdlk_tab                     { SDL::SDLK_TAB                         () };
sub sdl_sdlk_clear                   { SDL::SDLK_CLEAR                       () };
sub sdl_sdlk_return                  { SDL::SDLK_RETURN                      () };
sub sdl_sdlk_pause                   { SDL::SDLK_PAUSE                       () };
sub sdl_sdlk_escape                  { SDL::SDLK_ESCAPE                      () };
sub sdl_sdlk_space                   { SDL::SDLK_SPACE                       () };
sub sdl_sdlk_exclaim                 { SDL::SDLK_EXCLAIM                     () };
sub sdl_sdlk_quotedbl                { SDL::SDLK_QUOTEDBL                    () };
sub sdl_sdlk_hash                    { SDL::SDLK_HASH                        () };
sub sdl_sdlk_dollar                  { SDL::SDLK_DOLLAR                      () };
sub sdl_sdlk_ampersand               { SDL::SDLK_AMPERSAND                   () };
sub sdl_sdlk_quote                   { SDL::SDLK_QUOTE                       () };
sub sdl_sdlk_leftparen               { SDL::SDLK_LEFTPAREN                   () };
sub sdl_sdlk_rightparen              { SDL::SDLK_RIGHTPAREN                  () };
sub sdl_sdlk_asterisk                { SDL::SDLK_ASTERISK                    () };
sub sdl_sdlk_plus                    { SDL::SDLK_PLUS                        () };
sub sdl_sdlk_comma                   { SDL::SDLK_COMMA                       () };
sub sdl_sdlk_minus                   { SDL::SDLK_MINUS                       () };
sub sdl_sdlk_period                  { SDL::SDLK_PERIOD                      () };
sub sdl_sdlk_slash                   { SDL::SDLK_SLASH                       () };
sub sdl_sdlk_0                       { SDL::SDLK_0                           () };
sub sdl_sdlk_1                       { SDL::SDLK_1                           () };
sub sdl_sdlk_2                       { SDL::SDLK_2                           () };
sub sdl_sdlk_3                       { SDL::SDLK_3                           () };
sub sdl_sdlk_4                       { SDL::SDLK_4                           () };
sub sdl_sdlk_5                       { SDL::SDLK_5                           () };
sub sdl_sdlk_6                       { SDL::SDLK_6                           () };
sub sdl_sdlk_7                       { SDL::SDLK_7                           () };
sub sdl_sdlk_8                       { SDL::SDLK_8                           () };
sub sdl_sdlk_9                       { SDL::SDLK_9                           () };
sub sdl_sdlk_colon                   { SDL::SDLK_COLON                       () };
sub sdl_sdlk_semicolon               { SDL::SDLK_SEMICOLON                   () };
sub sdl_sdlk_less                    { SDL::SDLK_LESS                        () };
sub sdl_sdlk_equals                  { SDL::SDLK_EQUALS                      () };
sub sdl_sdlk_greater                 { SDL::SDLK_GREATER                     () };
sub sdl_sdlk_question                { SDL::SDLK_QUESTION                    () };
sub sdl_sdlk_at                      { SDL::SDLK_AT                          () };
sub sdl_sdlk_leftbracket             { SDL::SDLK_LEFTBRACKET                 () };
sub sdl_sdlk_backslash               { SDL::SDLK_BACKSLASH                   () };
sub sdl_sdlk_rightbracket            { SDL::SDLK_RIGHTBRACKET                () };
sub sdl_sdlk_caret                   { SDL::SDLK_CARET                       () };
sub sdl_sdlk_underscore              { SDL::SDLK_UNDERSCORE                  () };
sub sdl_sdlk_backquote               { SDL::SDLK_BACKQUOTE                   () };
sub sdl_sdlk_a                       { SDL::SDLK_a                           () };
sub sdl_sdlk_b                       { SDL::SDLK_b                           () };
sub sdl_sdlk_c                       { SDL::SDLK_c                           () };
sub sdl_sdlk_d                       { SDL::SDLK_d                           () };
sub sdl_sdlk_e                       { SDL::SDLK_e                           () };
sub sdl_sdlk_f                       { SDL::SDLK_f                           () };
sub sdl_sdlk_g                       { SDL::SDLK_g                           () };
sub sdl_sdlk_h                       { SDL::SDLK_h                           () };
sub sdl_sdlk_i                       { SDL::SDLK_i                           () };
sub sdl_sdlk_j                       { SDL::SDLK_j                           () };
sub sdl_sdlk_k                       { SDL::SDLK_k                           () };
sub sdl_sdlk_l                       { SDL::SDLK_l                           () };
sub sdl_sdlk_m                       { SDL::SDLK_m                           () };
sub sdl_sdlk_n                       { SDL::SDLK_n                           () };
sub sdl_sdlk_o                       { SDL::SDLK_o                           () };
sub sdl_sdlk_p                       { SDL::SDLK_p                           () };
sub sdl_sdlk_q                       { SDL::SDLK_q                           () };
sub sdl_sdlk_r                       { SDL::SDLK_r                           () };
sub sdl_sdlk_s                       { SDL::SDLK_s                           () };
sub sdl_sdlk_t                       { SDL::SDLK_t                           () };
sub sdl_sdlk_u                       { SDL::SDLK_u                           () };
sub sdl_sdlk_v                       { SDL::SDLK_v                           () };
sub sdl_sdlk_w                       { SDL::SDLK_w                           () };
sub sdl_sdlk_x                       { SDL::SDLK_x                           () };
sub sdl_sdlk_y                       { SDL::SDLK_y                           () };
sub sdl_sdlk_z                       { SDL::SDLK_z                           () };
sub sdl_sdlk_delete                  { SDL::SDLK_DELETE                      () };
sub sdl_sdlk_kp0                     { SDL::SDLK_KP0                         () };
sub sdl_sdlk_kp1                     { SDL::SDLK_KP1                         () };
sub sdl_sdlk_kp2                     { SDL::SDLK_KP2                         () };
sub sdl_sdlk_kp3                     { SDL::SDLK_KP3                         () };
sub sdl_sdlk_kp4                     { SDL::SDLK_KP4                         () };
sub sdl_sdlk_kp5                     { SDL::SDLK_KP5                         () };
sub sdl_sdlk_kp6                     { SDL::SDLK_KP6                         () };
sub sdl_sdlk_kp7                     { SDL::SDLK_KP7                         () };
sub sdl_sdlk_kp8                     { SDL::SDLK_KP8                         () };
sub sdl_sdlk_kp9                     { SDL::SDLK_KP9                         () };
sub sdl_sdlk_kp_period               { SDL::SDLK_KP_PERIOD                   () };
sub sdl_sdlk_kp_divide               { SDL::SDLK_KP_DIVIDE                   () };
sub sdl_sdlk_kp_multiply             { SDL::SDLK_KP_MULTIPLY                 () };
sub sdl_sdlk_kp_minus                { SDL::SDLK_KP_MINUS                    () };
sub sdl_sdlk_kp_plus                 { SDL::SDLK_KP_PLUS                     () };
sub sdl_sdlk_kp_enter                { SDL::SDLK_KP_ENTER                    () };
sub sdl_sdlk_kp_equals               { SDL::SDLK_KP_EQUALS                   () };
sub sdl_sdlk_up                      { SDL::SDLK_UP                          () };
sub sdl_sdlk_down                    { SDL::SDLK_DOWN                        () };
sub sdl_sdlk_right                   { SDL::SDLK_RIGHT                       () };
sub sdl_sdlk_left                    { SDL::SDLK_LEFT                        () };
sub sdl_sdlk_insert                  { SDL::SDLK_INSERT                      () };
sub sdl_sdlk_home                    { SDL::SDLK_HOME                        () };
sub sdl_sdlk_end                     { SDL::SDLK_END                         () };
sub sdl_sdlk_pageup                  { SDL::SDLK_PAGEUP                      () };
sub sdl_sdlk_pagedown                { SDL::SDLK_PAGEDOWN                    () };
sub sdl_sdlk_f1                      { SDL::SDLK_F1                          () };
sub sdl_sdlk_f2                      { SDL::SDLK_F2                          () };
sub sdl_sdlk_f3                      { SDL::SDLK_F3                          () };
sub sdl_sdlk_f4                      { SDL::SDLK_F4                          () };
sub sdl_sdlk_f5                      { SDL::SDLK_F5                          () };
sub sdl_sdlk_f6                      { SDL::SDLK_F6                          () };
sub sdl_sdlk_f7                      { SDL::SDLK_F7                          () };
sub sdl_sdlk_f8                      { SDL::SDLK_F8                          () };
sub sdl_sdlk_f9                      { SDL::SDLK_F9                          () };
sub sdl_sdlk_f10                     { SDL::SDLK_F10                         () };
sub sdl_sdlk_f11                     { SDL::SDLK_F11                         () };
sub sdl_sdlk_f12                     { SDL::SDLK_F12                         () };
sub sdl_sdlk_f13                     { SDL::SDLK_F13                         () };
sub sdl_sdlk_f14                     { SDL::SDLK_F14                         () };
sub sdl_sdlk_f15                     { SDL::SDLK_F15                         () };
sub sdl_sdlk_numlock                 { SDL::SDLK_NUMLOCK                     () };
sub sdl_sdlk_capslock                { SDL::SDLK_CAPSLOCK                    () };
sub sdl_sdlk_scrollock               { SDL::SDLK_SCROLLOCK                   () };
sub sdl_sdlk_rshift                  { SDL::SDLK_RSHIFT                      () };
sub sdl_sdlk_lshift                  { SDL::SDLK_LSHIFT                      () };
sub sdl_sdlk_rctrl                   { SDL::SDLK_RCTRL                       () };
sub sdl_sdlk_lctrl                   { SDL::SDLK_LCTRL                       () };
sub sdl_sdlk_ralt                    { SDL::SDLK_RALT                        () };
sub sdl_sdlk_lalt                    { SDL::SDLK_LALT                        () };
sub sdl_sdlk_rmeta                   { SDL::SDLK_RMETA                       () };
sub sdl_sdlk_lmeta                   { SDL::SDLK_LMETA                       () };
sub sdl_sdlk_lsuper                  { SDL::SDLK_LSUPER                      () };
sub sdl_sdlk_rsuper                  { SDL::SDLK_RSUPER                      () };
sub sdl_sdlk_mode                    { SDL::SDLK_MODE                        () };
sub sdl_sdlk_help                    { SDL::SDLK_HELP                        () };
sub sdl_sdlk_print                   { SDL::SDLK_PRINT                       () };
sub sdl_sdlk_sysreq                  { SDL::SDLK_SYSREQ                      () };
sub sdl_sdlk_break                   { SDL::SDLK_BREAK                       () };
sub sdl_sdlk_menu                    { SDL::SDLK_MENU                        () };
sub sdl_sdlk_power                   { SDL::SDLK_POWER                       () };
sub sdl_sdlk_euro                    { SDL::SDLK_EURO                        () };
sub sdl_kmod_none                    { SDL::KMOD_NONE                        () };
sub sdl_kmod_num                     { SDL::KMOD_NUM                         () };
sub sdl_kmod_caps                    { SDL::KMOD_CAPS                        () };
sub sdl_kmod_lctrl                   { SDL::KMOD_LCTRL                       () };
sub sdl_kmod_rctrl                   { SDL::KMOD_RCTRL                       () };
sub sdl_kmod_rshift                  { SDL::KMOD_RSHIFT                      () };
sub sdl_kmod_lshift                  { SDL::KMOD_LSHIFT                      () };
sub sdl_kmod_ralt                    { SDL::KMOD_RALT                        () };
sub sdl_kmod_lalt                    { SDL::KMOD_LALT                        () };
sub sdl_kmod_ctrl                    { SDL::KMOD_CTRL                        () };
sub sdl_kmod_shift                   { SDL::KMOD_SHIFT                       () };
sub sdl_kmod_alt                     { SDL::KMOD_ALT                         () };
sub sdl_key_event_sym                { SDL::KeyEventSym                      (@_) };
sub sdl_key_event_mod                { SDL::KeyEventMod                      (@_) };
sub sdl_key_event_unicode            { SDL::KeyEventUnicode                  (@_) };
sub sdl_key_event_scan_code          { SDL::KeyEventScanCode                 (@_) };
sub sdl_mouse_motion_state           { SDL::MouseMotionState                 (@_) };
sub sdl_mouse_motion_x               { SDL::MouseMotionX                     (@_) };
sub sdl_mouse_motion_y               { SDL::MouseMotionY                     (@_) };
sub sdl_mouse_motion_xrel            { SDL::MouseMotionXrel                  (@_) };
sub sdl_mouse_motion_yrel            { SDL::MouseMotionYrel                  (@_) };
sub sdl_mouse_button_state           { SDL::MouseButtonState                 (@_) };
sub sdl_mouse_button                 { SDL::MouseButton                      (@_) };
sub sdl_mouse_button_x               { SDL::MouseButtonX                     (@_) };
sub sdl_mouse_button_y               { SDL::MouseButtonY                     (@_) };
sub sdl_sys_wm_event_msg             { SDL::SysWMEventMsg                    (@_) };
sub sdl_enable_unicode               { SDL::EnableUnicode                    (@_) };
sub sdl_enable_key_repeat            { SDL::EnableKeyRepeat                  (@_) };
sub sdl_get_key_name                 { SDL::GetKeyName                       (@_) };
sub sdl_pressed                      { SDL::PRESSED                          () };
sub sdl_released                     { SDL::RELEASED                         () };
sub sdl_create_rgb_surface           { SDL::CreateRGBSurface                 (@_) };
sub sdl_create_rgb_surface_from      { SDL::CreateRGBSurfaceFrom             (@_) };
sub sdl_img_load                     { SDL::IMGLoad                          (@_) };
sub sdl_free_surface                 { SDL::FreeSurface                      (@_) };
sub sdl_surface_palette              { SDL::SurfacePalette                   (@_) };
sub sdl_surface_bits_per_pixel       { SDL::SurfaceBitsPerPixel              (@_) };
sub sdl_surface_bytes_per_pixel      { SDL::SurfaceBytesPerPixel             (@_) };
sub sdl_surface_rshift               { SDL::SurfaceRshift                    (@_) };
sub sdl_surface_gshift               { SDL::SurfaceGshift                    (@_) };
sub sdl_surface_bshift               { SDL::SurfaceBshift                    (@_) };
sub sdl_surface_ashift               { SDL::SurfaceAshift                    (@_) };
sub sdl_surface_rmask                { SDL::SurfaceRmask                     (@_) };
sub sdl_surface_gmask                { SDL::SurfaceGmask                     (@_) };
sub sdl_surface_bmask                { SDL::SurfaceBmask                     (@_) };
sub sdl_surface_amask                { SDL::SurfaceAmask                     (@_) };
sub sdl_surface_color_key            { SDL::SurfaceColorKey                  (@_) };
sub sdl_surface_alpha                { SDL::SurfaceAlpha                     (@_) };
sub sdl_surface_w                    { SDL::SurfaceW                         (@_) };
sub sdl_surface_h                    { SDL::SurfaceH                         (@_) };
sub sdl_surface_pitch                { SDL::SurfacePitch                     (@_) };
sub sdl_surface_pixels               { SDL::SurfacePixels                    (@_) };
sub sdl_surface_pixel                { SDL::SurfacePixel                     (@_) };
sub sdl_mustlock                     { SDL::MUSTLOCK                         (@_) };
sub sdl_surface_lock                 { SDL::SurfaceLock                      (@_) };
sub sdl_surface_unlock               { SDL::SurfaceUnlock                    (@_) };
sub sdl_get_video_surface            { SDL::GetVideoSurface                  () };
sub sdl_video_info                   { SDL::VideoInfo                        () };
sub sdl_new_rect                     { SDL::NewRect                          (@_) };
sub sdl_free_rect                    { SDL::FreeRect                         (@_) };
sub sdl_rect_x                       { SDL::RectX                            (@_) };
sub sdl_rect_y                       { SDL::RectY                            (@_) };
sub sdl_rect_w                       { SDL::RectW                            (@_) };
sub sdl_rect_h                       { SDL::RectH                            (@_) };
sub sdl_new_color                    { SDL::NewColor                         (@_) };
sub sdl_color_r                      { SDL::ColorR                           (@_) };
sub sdl_color_g                      { SDL::ColorG                           (@_) };
sub sdl_colog_b                      { SDL::CologB                           (@_) };
sub sdl_free_color                   { SDL::FreeColor                        (@_) };
sub sdl_new_palette                  { SDL::NewPalette                       (@_) };
sub sdl_palette_n_colors             { SDL::PaletteNColors                   (@_) };
sub sdl_palette_colors               { SDL::PaletteColors                    (@_) };
sub sdl_swsurface                    { SDL::SWSURFACE                        () };
sub sdl_hwsurface                    { SDL::HWSURFACE                        () };
sub sdl_anyformat                    { SDL::ANYFORMAT                        () };
sub sdl_hwpalette                    { SDL::HWPALETTE                        () };
sub sdl_doublebuf                    { SDL::DOUBLEBUF                        () };
sub sdl_fullscreen                   { SDL::FULLSCREEN                       () };
sub sdl_asyncblit                    { SDL::ASYNCBLIT                        () };
sub sdl_opengl                       { SDL::OPENGL                           () };
sub sdl_hwaccel                      { SDL::HWACCEL                          () };
sub sdl_video_mode_ok                { SDL::VideoModeOK                      (@_) };
sub sdl_set_video_mode               { SDL::SetVideoMode                     (@_) };
sub sdl_update_rects                 { SDL::UpdateRects                      (@_) };
sub sdl_flip                         { SDL::Flip                             (@_) };
sub sdl_set_colors                   { SDL::SetColors                        (@_) };
sub sdl_map_rgb                      { SDL::MapRGB                           (@_) };
sub sdl_map_rgba                     { SDL::MapRGBA                          (@_) };
sub sdl_get_rgb                      { SDL::GetRGB                           (@_) };
sub sdl_get_rgba                     { SDL::GetRGBA                          (@_) };
sub sdl_save_b_m_p                   { SDL::SaveBMP                          (@_) };
sub sdl_set_color_key                { SDL::SetColorKey                      (@_) };
sub sdl_srccolorkey                  { SDL::SRCCOLORKEY                      () };
sub sdl_rleaccel                     { SDL::RLEACCEL                         () };
sub sdl_srcalpha                     { SDL::SRCALPHA                         () };
sub sdl_set_alpha                    { SDL::SetAlpha                         (@_) };
sub sdl_display_format               { SDL::DisplayFormat                    (@_) };
sub sdl_blit_surface                 { SDL::BlitSurface                      (@_) };
sub sdl_fill_rect                    { SDL::FillRect                         (@_) };
sub sdl_wm_set_caption               { SDL::WMSetCaption                     (@_) };
sub sdl_wm_get_caption               { SDL::WMGetCaption                     () };
sub sdl_wm_set_icon                  { SDL::WMSetIcon                        (@_) };
sub sdl_warp_mouse                   { SDL::WarpMouse                        (@_) };
sub sdl_new_cursor                   { SDL::NewCursor                        (@_) };
sub sdl_free_cursor                  { SDL::FreeCursor                       (@_) };
sub sdl_set_cursor                   { SDL::SetCursor                        (@_) };
sub sdl_get_cursor                   { SDL::GetCursor                        () };
sub sdl_show_cursor                  { SDL::ShowCursor                       (@_) };
sub sdl_new_audio_spec               { SDL::NewAudioSpec                     (@_) };
sub sdl_free_audio_spec              { SDL::FreeAudioSpec                    (@_) };
sub sdl_audio_u8                     { SDL::AUDIO_U8                         () };
sub sdl_audio_s8                     { SDL::AUDIO_S8                         () };
sub sdl_audio_u16                    { SDL::AUDIO_U16                        () };
sub sdl_audio_s16                    { SDL::AUDIO_S16                        () };
sub sdl_audio_u16msb                 { SDL::AUDIO_U16MSB                     () };
sub sdl_audio_s16msb                 { SDL::AUDIO_S16MSB                     () };
sub sdl_new_audio_cvt                { SDL::NewAudioCVT                      (@_) };
sub sdl_free_audio_cvt               { SDL::FreeAudioCVT                     (@_) };
sub sdl_convert_audio_data           { SDL::ConvertAudioData                 (@_) };
sub sdl_open_audio                   { SDL::OpenAudio                        (@_) };
sub sdl_pause_audio                  { SDL::PauseAudio                       (@_) };
sub sdl_unlock_audio                 { SDL::UnlockAudio                      () };
sub sdl_close_audio                  { SDL::CloseAudio                       () };
sub sdl_free_wav                     { SDL::FreeWAV                          (@_) };
sub sdl_load_wav                     { SDL::LoadWAV                          (@_) };
sub sdl_mix_audio                    { SDL::MixAudio                         (@_) };
sub sdl_mix_max_volume               { SDL::MIX_MAX_VOLUME                   () };
sub sdl_mix_default_frequency        { SDL::MIX_DEFAULT_FREQUENCY            () };
sub sdl_mix_default_format           { SDL::MIX_DEFAULT_FORMAT               () };
sub sdl_mix_default_channels         { SDL::MIX_DEFAULT_CHANNELS             () };
sub sdl_mix_no_fading                { SDL::MIX_NO_FADING                    () };
sub sdl_mix_fading_out               { SDL::MIX_FADING_OUT                   () };
sub sdl_mix_fading_in                { SDL::MIX_FADING_IN                    () };
sub sdl_mix_open_audio               { SDL::MixOpenAudio                     (@_) };
sub sdl_mix_allocate_channels        { SDL::MixAllocateChannels              (@_) };
sub sdl_mix_query_spec               { SDL::MixQuerySpec                     () };
sub sdl_mix_load_wav                 { SDL::MixLoadWAV                       (@_) };
sub sdl_mix_load_music               { SDL::MixLoadMusic                     (@_) };
sub sdl_mix_quick_load_wav           { SDL::MixQuickLoadWAV                  (@_) };
sub sdl_mix_free_chunk               { SDL::MixFreeChunk                     (@_) };
sub sdl_mix_free_music               { SDL::MixFreeMusic                     (@_) };
sub sdl_mix_set_post_mix_callback    { SDL::MixSetPostMixCallback            (@_) };
sub sdl_mix_set_music_hook           { SDL::MixSetMusicHook                  (@_) };
sub sdl_mix_set_music_finished_hook  { SDL::MixSetMusicFinishedHook          (@_) };
sub sdl_mix_get_music_hook_data      { SDL::MixGetMusicHookData              () };
sub sdl_mix_reverse_channels         { SDL::MixReverseChannels               (@_) };
sub sdl_mix_group_channel            { SDL::MixGroupChannel                  (@_) };
sub sdl_mix_group_channels           { SDL::MixGroupChannels                 (@_) };
sub sdl_mix_group_available          { SDL::MixGroupAvailable                (@_) };
sub sdl_mix_group_count              { SDL::MixGroupCount                    (@_) };
sub sdl_mix_group_oldest             { SDL::MixGroupOldest                   (@_) };
sub sdl_mix_group_newer              { SDL::MixGroupNewer                    (@_) };
sub sdl_mix_play_channel             { SDL::MixPlayChannel                   (@_) };
sub sdl_mix_play_channel_timed       { SDL::MixPlayChannelTimed              (@_) };
sub sdl_mix_play_music               { SDL::MixPlayMusic                     (@_) };
sub sdl_mix_fade_in_channel          { SDL::MixFadeInChannel                 (@_) };
sub sdl_mix_fade_in_channel_timed    { SDL::MixFadeInChannelTimed            (@_) };
sub sdl_mix_fade_in_music            { SDL::MixFadeInMusic                   (@_) };
sub sdl_mix_volume                   { SDL::MixVolume                        (@_) };
sub sdl_mix_volume_chunk             { SDL::MixVolumeChunk                   (@_) };
sub sdl_mix_volume_music             { SDL::MixVolumeMusic                   (@_) };
sub sdl_mix_halt_channel             { SDL::MixHaltChannel                   (@_) };
sub sdl_mix_halt_group               { SDL::MixHaltGroup                     (@_) };
sub sdl_mix_halt_music               { SDL::MixHaltMusic                     () };
sub sdl_mix_expire_channel           { SDL::MixExpireChannel                 (@_) };
sub sdl_mix_fade_out_channel         { SDL::MixFadeOutChannel                (@_) };
sub sdl_mix_fade_out_group           { SDL::MixFadeOutGroup                  (@_) };
sub sdl_mix_fade_out_music           { SDL::MixFadeOutMusic                  (@_) };
sub sdl_mix_fading_music             { SDL::MixFadingMusic                   () };
sub sdl_mix_fading_channel           { SDL::MixFadingChannel                 (@_) };
sub sdl_mix_pause                    { SDL::MixPause                         (@_) };
sub sdl_mix_resume                   { SDL::MixResume                        (@_) };
sub sdl_mix_paused                   { SDL::MixPaused                        (@_) };
sub sdl_mix_pause_music              { SDL::MixPauseMusic                    () };
sub sdl_mix_resume_music             { SDL::MixResumeMusic                   () };
sub sdl_mix_rewind_music             { SDL::MixRewindMusic                   () };
sub sdl_mix_paused_music             { SDL::MixPausedMusic                   () };
sub sdl_mix_playing                  { SDL::MixPlaying                       (@_) };
sub sdl_mix_playing_music            { SDL::MixPlayingMusic                  () };
sub sdl_mix_close_audio              { SDL::MixCloseAudio                    () };
sub sdl_new_font                     { SDL::NewFont                          (@_) };
sub sdl_use_font                     { SDL::UseFont                          (@_) };
sub sdl_put_string                   { SDL::PutString                        (@_) };
sub sdl_text_width                   { SDL::TextWidth                        (@_) };
sub sdl_gl_red_size                  { SDL::GL_RED_SIZE                      () };
sub sdl_gl_green_size                { SDL::GL_GREEN_SIZE                    () };
sub sdl_gl_blue_size                 { SDL::GL_BLUE_SIZE                     () };
sub sdl_gl_alpha_size                { SDL::GL_ALPHA_SIZE                    () };
sub sdl_gl_accum_red_size            { SDL::GL_ACCUM_RED_SIZE                () };
sub sdl_gl_accum_green_size          { SDL::GL_ACCUM_GREEN_SIZE              () };
sub sdl_gl_accum_blue_size           { SDL::GL_ACCUM_BLUE_SIZE               () };
sub sdl_gl_accum_alpha_size          { SDL::GL_ACCUM_ALPHA_SIZE              () };
sub sdl_gl_buffer_size               { SDL::GL_BUFFER_SIZE                   () };
sub sdl_gl_depth_size                { SDL::GL_DEPTH_SIZE                    () };
sub sdl_gl_stencil_size              { SDL::GL_STENCIL_SIZE                  () };
sub sdl_gl_doublebuffer              { SDL::GL_DOUBLEBUFFER                  () };
sub sdl_gl_set_attribute             { SDL::GL_SetAttribute                  (@_) };
sub sdl_gl_get_attribute             { SDL::GL_GetAttribute                  (@_) };
sub sdl_gl_swap_buffers              { SDL::GL_SwapBuffers                   () };
sub sdl_big_endian                   { SDL::BigEndian                        () };
sub sdl_num_joysticks                { SDL::NumJoysticks                     () };
sub sdl_joystick_name                { SDL::JoystickName                     (@_) };
sub sdl_joystick_open                { SDL::JoystickOpen                     (@_) };
sub sdl_joystick_opened              { SDL::JoystickOpened                   (@_) };
sub sdl_joystick_index               { SDL::JoystickIndex                    (@_) };
sub sdl_joystick_num_axes            { SDL::JoystickNumAxes                  (@_) };
sub sdl_joystick_num_balls           { SDL::JoystickNumBalls                 (@_) };
sub sdl_joystick_num_hats            { SDL::JoystickNumHats                  (@_) };
sub sdl_joystick_num_buttons         { SDL::JoystickNumButtons               (@_) };
sub sdl_joystick_update              { SDL::JoystickUpdate                   () };
sub sdl_joystick_get_axis            { SDL::JoystickGetAxis                  (@_) };
sub sdl_joystick_get_hat             { SDL::JoystickGetHat                   (@_) };
sub sdl_joystick_get_button          { SDL::JoystickGetButton                (@_) };
sub sdl_joystick_get_ball            { SDL::JoystickGetBall                  (@_) };
sub sdl_joystick_close               { SDL::JoystickClose                    (@_) };

1;

=pod

=head1 NAME

SDL::sdlpl - SDL_perl version 1.12 compatability layer

=head1 DESCRIPTION

This module provides a compatability layer for the per-1.13 api.
The layer is currently incomplete.

=head1 AUTHOR

David J. Goehrig

=head1 SEE ALSO

SDL(3)

=cut
