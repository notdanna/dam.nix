/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 5;
static const unsigned int snap      = 3;
static const int showbar            = 1;
static const int topbar             = 1;
static const int vertpad            = 15;
static const int sidepad            = 15;

static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=11" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=11";

static const char normbgcolor[]     = "#0B0A10";
static const char normbordercolor[] = "#444444";
static const char normfgcolor[]     = "#bbbbbb";
static const char selfgcolor[]      = "#eeeeee";
static const char selbordercolor[]  = "#78527b";
static const char selbgcolor[]      = "#78527b";
static const char *colors[][3] = {
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

static const char *tags[] = { "1", "2", "3", "4", "5", "6" };

static const Rule rules[] = {
	{ NULL, NULL, NULL, 0, 0, -1 },
};

static const float mfact        = 0.50;
static const int nmaster        = 1;
static const int resizehints    = 0;
static const int lockfullscreen = 1;

static const Layout layouts[] = {
	{ "[]=", tile    },
	{ "><>", NULL    },
	{ "[M]", monocle },
};

#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY, view,       {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY, toggleview, {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY, tag,        {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY, toggletag,  {.ui = 1 << TAG} },

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "st", "-e", "zsh", NULL };

static const Key keys[] = {
	{ MODKEY,            XK_a,          spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,  XK_Return,     spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,  XK_s,          spawn,          SHCMD("flameshot gui") },
	{ 0, XF86XK_AudioRaiseVolume,       spawn,          SHCMD("pamixer -i 5") },
	{ 0, XF86XK_AudioLowerVolume,       spawn,          SHCMD("pamixer -d 5") },
	{ 0, XF86XK_AudioMute,              spawn,          SHCMD("pamixer -t") },
	{ MODKEY,            XK_b,          togglebar,      {0} },
	{ MODKEY,            XK_j,          focusstack,     {.i = +1 } },
	{ MODKEY,            XK_k,          focusstack,     {.i = -1 } },
	{ MODKEY,            XK_i,          incnmaster,     {.i = +1 } },
	{ MODKEY,            XK_d,          incnmaster,     {.i = -1 } },
	{ MODKEY,            XK_h,          setmfact,       {.f = -0.05} },
	{ MODKEY,            XK_l,          setmfact,       {.f = +0.05} },
	{ MODKEY,            XK_Return,     zoom,           {0} },
	{ MODKEY,            XK_Tab,        view,           {0} },
	{ MODKEY,            XK_q,          killclient,     {0} },
	{ MODKEY|ShiftMask,  XK_c,          killclient,     {0} },
	{ MODKEY,            XK_t,          setlayout,      {.v = &layouts[0]} },
	{ MODKEY,            XK_f,          setlayout,      {.v = &layouts[1]} },
	{ MODKEY,            XK_m,          setlayout,      {.v = &layouts[2]} },
	{ MODKEY,            XK_space,      setlayout,      {0} },
	{ MODKEY,            XK_s,          togglefloating, {0} },
	{ MODKEY,            XK_0,          view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,  XK_0,          tag,            {.ui = ~0 } },
	{ MODKEY,            XK_comma,      focusmon,       {.i = -1 } },
	{ MODKEY,            XK_period,     focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,  XK_comma,      tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,  XK_period,     tagmon,         {.i = +1 } },
	TAGKEYS(             XK_1,                          0)
	TAGKEYS(             XK_2,                          1)
	TAGKEYS(             XK_3,                          2)
	TAGKEYS(             XK_4,                          3)
	TAGKEYS(             XK_5,                          4)
	TAGKEYS(             XK_6,                          5)
	{ MODKEY|ShiftMask,  XK_q,          quit,           {0} },
};

static const Button buttons[] = {
	{ ClkLtSymbol,  0,      Button1, setlayout,      {0} },
	{ ClkLtSymbol,  0,      Button3, setlayout,      {.v = &layouts[2]} },
	{ ClkStatusText,0,      Button2, spawn,          {.v = termcmd } },
	{ ClkClientWin, MODKEY, Button1, movemouse,      {0} },
	{ ClkClientWin, MODKEY, Button2, togglefloating, {0} },
	{ ClkClientWin, MODKEY, Button3, resizemouse,    {0} },
	{ ClkTagBar,    0,      Button1, view,           {0} },
	{ ClkTagBar,    0,      Button3, toggleview,     {0} },
	{ ClkTagBar,    MODKEY, Button1, tag,            {0} },
	{ ClkTagBar,    MODKEY, Button3, toggletag,      {0} },
};
