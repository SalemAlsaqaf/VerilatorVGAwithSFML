// File: common_defines.svh
`ifndef COMMON_DEFINES_SVH
`define COMMON_DEFINES_SVH


typedef enum {
  SOUND_CREDIT,
  SOUND_LOADING,  //
  SOUND_READY,  //
  SOUND_WIN,  //
  SOUND_GAME_PLAY,  //
  SOUND_FAIL,  //
  SOUND_START,
  SOUND_EATING_PACDOT,
  SOUND_EATING_GHOST,
  SOUND_BLUE_GHOST_MODE,
  SOUND_FINISH
} sound_t;

typedef enum {
  GAME_MODE_LOADING,
  GAME_MODE_WELCOME_SCREEN,
  GAME_MODE_BLUE_GHOST_MODE,
  GAME_MODE_READY,
  GAME_MODE_GAME_PLAY,
  GAME_MODE_FAIL,
  GAME_MODE_WIN,  // :3
  GAME_MODE_FINISH
} game_mode_t;


`endif
