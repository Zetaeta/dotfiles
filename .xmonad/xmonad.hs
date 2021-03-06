import XMonad
-- LAYOUTS
import XMonad.Layout.Spacing
import XMonad.Layout.Fullscreen 
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Tabbed
import XMonad.Layout.ResizableTile
import XMonad.Layout.Circle
import XMonad.Layout.Simplest
import XMonad.Layout.BoringWindows

import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
-- WINDOW RULES
import XMonad.ManageHook
-- KEYBOARD & MOUSE CONFIG
import XMonad.Util.EZConfig
import XMonad.Actions.FloatKeys
import Graphics.X11.ExtraTypes.XF86
-- STATUS BAR
import XMonad.Hooks.DynamicLog hiding (xmobar, xmobarPP, xmobarColor, sjanssenPP, byorgeyPP)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Dmenu
--import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops hiding (fullscreenEventHook)
import System.IO (hPutStrLn)
--import XMonad.Operations
import qualified XMonad.StackSet as W
import qualified XMonad.Actions.FlexibleResize as FlexibleResize
import XMonad.Util.Run (spawnPipe)
import XMonad.Actions.CycleWS            -- nextWS, prevWS
import Data.List            -- clickable workspaces


--------------------------------------------------------------------------------------------------------------------
-- DECLARE WORKSPACES RULES
--------------------------------------------------------------------------------------------------------------------
--myLayout = onWorkspace (myWorkspaces !! 0) (avoidStruts (tiledSpace ||| tiled) ||| fullTile)
--        $ onWorkspace (myWorkspaces !! 1) (avoidStruts (tiledSpace ||| tiled ||| fullTile) ||| fullScreen)
--        $ onWorkspace (myWorkspaces !! 2) (avoidStruts (simplestFloat ||| tiledSpace ||| tiled ||| fullTile ||| fullScreen))
myLayout = windowNavigation $ avoidStruts ( subLayout [] (Simplest ||| layouts) $ boringWindows layouts )
    where
        layouts = tiledLayouts ||| fullScreen ||| simplestFloat
        tiledLayouts = tiledSpace ||| tiled ||| fullTile ||| Mirror tiledSpace ||| Mirror tiled ||| Mirror fullTile
--        wideTiled          = spacing 5 $ ResizableWide nmaster delta ratio [] 
        tiled          = spacing 5 $ ResizableTall nmaster delta ratio [] 
        tiledSpace      = spacing 60 $ ResizableTall nmaster delta ratio [] 
        fullScreen     = noBorders(fullscreenFull Full)
        fullTile     = ResizableTall nmaster delta ratio [] 
        borderlessTile    = noBorders(fullTile)
        -- Default number of windows in master pane
        nmaster = 1
        -- Percent of the screen to increment when resizing
        delta     = 5/100
        -- Default proportion of the screen taken up by main pane
        ratio     = toRational (2/(1 + sqrt 5 :: Double)) 


--------------------------------------------------------------------------------------------------------------------
-- WORKSPACE DEFINITIONS
--------------------------------------------------------------------------------------------------------------------
--myWorkspaces = clickable $ ["term"
--        ,"web"    
--        ,"float"    
--        ,"docs"    
--        ,"tunes"
--        ,"mail"]    
myWorkspaces = clickable $ ["I"
        ,"II"    
        ,"III"    
        ,"IV"    
        ,"V"
        ,"VI"]    
    where clickable l = [ "^ca(1,xdotool key alt+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                (i,ws) <- zip [1..] l,
                let n = i ]

--------------------------------------------------------------------------------------------------------------------
-- APPLICATION SPECIFIC RULES
--------------------------------------------------------------------------------------------------------------------
myManageHook = composeAll     [ resource =? "dmenu" --> doFloat
--                , resource =? "skype"     --> doFloat
                , resource =? "yakuake"     --> doFloat
                , resource =? "mplayer"    --> doFloat
                , resource =? "steam"    --> doFloat
                , resource =? "hl2_linux" --> doFloat
                , resource =? "feh"    --> doIgnore
                , resource =? "dzen2"    --> doIgnore
--                , resource =? "transmission"    --> doShift (myWorkspaces !! 2)
--                , resource =? "thunar"    --> doShift (myWorkspaces !! 2)
                , resource =? "chromium"--> doShift (myWorkspaces !! 1)
--                , resource =? "lowriter"--> doShift (myWorkspaces !! 3)
--                , resource =? "localc"--> doShift (myWorkspaces !! 3)
--                , resource =? "loimpress"--> doShift (myWorkspaces !! 3)
--                , resource =? "zathura"--> doShift (myWorkspaces !! 3)
--                , resource =? "ario"--> doShift (myWorkspaces !! 4)
--                , resource =? "ncmpcpp"--> doShift (myWorkspaces !! 4)
--                , resource =? "alsamixer"--> doShift (myWorkspaces !! 4)
--                , resource =? "mutt"--> doShift (myWorkspaces !! 5)
--                , resource =? "irssi"--> doShift (myWorkspaces !! 5)
--                , resource =? "centerim"--> doShift (myWorkspaces !! 5)
                , manageDocks]
newManageHook = myManageHook <+> manageHook defaultConfig 

--------------------------------------------------------------------------------------------------------------------
-- DZEN LOG RULES for workspace names, layout image, current program title
--------------------------------------------------------------------------------------------------------------------
myLogHook h = dynamicLogWithPP ( defaultPP
    {
          ppCurrent        = dzenColor color9 background .    pad
        , ppVisible        = dzenColor color6 background .     pad
        , ppHidden        = dzenColor color6 background .     pad
        , ppHiddenNoWindows    = dzenColor color0 background .    pad
        , ppWsSep        = ""
        , ppSep            = "    "
        , ppLayout        = wrap "^ca(1,xdotool key alt+space)" "^ca()" . dzenColor foreground background .
                (\x -> case x of
                    "Full"                ->    "^i(/home/daniel/.xmonad/dzen2/layout_full.xbm)"
                    "Spacing 5 ResizableTall"    ->    "^i(/home/daniel/.xmonad/dzen2/layout_tall.xbm)"
                    "ResizableTall"            ->    "^i(/home/daniel/.xmonad/dzen2/layout_tall.xbm)"
                    "SimplestFloat"            ->    "^i(/home/daniel/.xmonad/dzen2/mouse_01.xbm)"
                    "Circle"            ->    "^i(/home/daniel/.xmonad/dzen2/full.xbm)"
                    _                ->    "^i(/home/daniel/.xmonad/dzen2/grid.xbm)"
                ) 
--        , ppTitle    =   wrap "^ca(1,xdotool key alt+shift+x)^fg(#7e7175)^i(/home/daniel/.xmonad/dzen2/corner_left.xbm)^bg(#7e7175)^fg(#f92671)^fn(fkp)x^fn()" "^fg(#7e7175)^i(/home/daniel/.xmonad/dzen2/corner_right.xbm)^ca()" .  dzenColor foreground "#7e7175" . shorten 40 . pad        
        , ppTitle    =  wrap "^ca(1,xdotool key alt+shift+x)^fg(#D23D3D)^fn(fkp)x ^fn()" "^ca()" . dzenColor foreground background . shorten 40 . pad
        , ppOrder    =  \(ws:l:t:_) -> [ws,l, t]
        , ppOutput    =   hPutStrLn h
    } )


--------------------------------------------------------------------------------------------------------------------
-- Spawn pipes and menus on boot, set default settings
--------------------------------------------------------------------------------------------------------------------
myXmonadBar = "dzen2 -x '0' -y '0' -h '16' -w '500' -ta 'l' -fg '"++foreground++"' -bg '"++background++"' -fn "++myFont
myStatusBar = "conky -qc /home/daniel/.xmonad/.conky_dzen | dzen2 -x '500' -w '1900' -h '16' -ta 'r' -bg '"++background++"' -fg '"++foreground++"' -y '0' -fn "++myFont
mySystray = "stalonetray -bg '" ++ background ++ "' --geometry '10x1+2400' --max-geometry '10x1' -i 16"
--myConky = "conky -c /home/daniel/conkyrc"
--myStartMenu = "/home/daniel/.xmonad/start /home/daniel/.xmonad/start_apps"


main = do
    dzenLeftBar     <- spawnPipe myXmonadBar
    dzenRightBar    <- spawnPipe myStatusBar
    stalonetrayBar    <- spawnPipe mySystray
--    xmproc         <- spawnPipe "GTK2_RC_FILES=/home/daniel/.gtkdocky /usr/bin/docky"
--    xmproc         <- spawnPipe "tint2 -c /home/daniel/.config/tint2/xmonad.tint2rc"
--    conky         <- spawn myConky
--    dzenStartMenu    <- spawnPipe myStartMenu
    xmonad $ ewmh defaultConfig
        { terminal        = myTerminal
        , borderWidth        = 3
        , normalBorderColor     = background
        , focusedBorderColor      = color9
        , modMask         = mod1Mask
        , layoutHook         = smartBorders $ myLayout
        , workspaces         = myWorkspaces
        , manageHook        = newManageHook
        , handleEventHook     = fullscreenEventHook <+> docksEventHook
        , startupHook        = setWMName "LG3D"
        , logHook        = myLogHook dzenLeftBar -- >> fadeInactiveLogHook 0xdddddddd
        }

--------------------------------------------------------------------------------------------------------------------
-- Keyboard options
--------------------------------------------------------------------------------------------------------------------
        `additionalKeys`
        [((mod1Mask .|. shiftMask    , xK_b), spawn "chromium")
        ,((mod1Mask              , xK_b), spawn "dwb")
--        ,((mod1Mask .|. shiftMask    , xK_n), spawn "urxvtc -fn '-*-gohufont-medium-r-normal-*-12-*-*-*-*-*-*-*' -fb '-*-gohufont-medium-r-normal-*-12-*-*-*-*-*-*-*' -fi '-*-gohufont-medium-r-normal-*-12-*-*-*-*-*-*-*'")
        ,((mod1Mask             , xK_Return), spawn "konsole")
        ,((mod1Mask .|. shiftMask    , xK_n), spawn "xterm")
--        ,((mod1Mask .|. shiftMask   , xK_space), sendMessage NextLayout)
--        ,((mod1Mask .|. shiftMask    , xK_n), spawn "xterm")
--        ,((mod1Mask .|. shiftMask      , xK_t), spawn "urxvtc -e tmux")
        ,((mod4Mask              , xK_z), spawn "zathura")
        ,((mod4Mask              , xK_w), spawn "lowriter")
        ,((mod4Mask              , xK_c), spawn "localc")
        ,((mod4Mask              , xK_m), spawn "urxvtc -title mutt -name mutt -e muttb")
        ,((mod4Mask              , xK_i), spawn "urxvtc -title irssi -name irssi -e irssi")
        ,((mod4Mask              , xK_n), spawn "urxvtc -title ncmpcpp -name ncmpcpp -e ncmpcpp")
        ,((mod4Mask              , xK_a), spawn "urxvtc -title alsamixer -name alsamixer -e alsamixer")
        ,((mod4Mask              , xK_M), spawn "urxvtc -title centerim -name centerim -e centerim")
        ,((mod1Mask             , xK_r), spawn "/home/daniel/scripts/lens")
        ,((mod1Mask .|. shiftMask    , xK_r), spawn "/home/daniel/scripts/dmenu/spotlight")
        ,((mod1Mask            , xK_q), spawn "killall dzen2; killall conky; killall tint2; killall stalonetray; cd ~/.xmonad; ghc -threaded xmonad.hs; mv xmonad xmonad-x86_64-linux; xmonad --restart" )
        ,((mod1Mask .|. shiftMask    , xK_i), spawn "xcalib -invert -alter")
        ,((mod1Mask .|. shiftMask    , xK_x), kill)
        ,((mod1Mask .|. shiftMask    , xK_c), kill)
--        ,((mod1Mask .|. shiftMask    , xK_c), return())
        ,((mod1Mask              , xK_p), moveTo Prev NonEmptyWS)
        ,((mod1Mask              , xK_n), moveTo Next NonEmptyWS)
        ,((mod1Mask              , xK_c), moveTo Next EmptyWS)
--        ,((mod1Mask .|. shiftMask    , xK_l), sendMessage MirrorShrink)
--        ,((mod1Mask .|. shiftMask    , xK_h), sendMessage MirrorExpand)
        ,((mod1Mask .|. shiftMask    , xK_l), sendMessage Shrink)
        ,((mod1Mask .|. shiftMask    , xK_h), sendMessage Expand)
        ,((mod1Mask              , xK_a), withFocused (keysMoveWindow (-20,0)))
        ,((mod1Mask              , xK_d), withFocused (keysMoveWindow (0,-20)))
        ,((mod1Mask              , xK_s), withFocused (keysMoveWindow (0,20)))
        ,((mod1Mask              , xK_f), withFocused (keysMoveWindow (20,0)))
        ,((mod1Mask .|. shiftMask      , xK_a), withFocused (keysResizeWindow (-20,0) (0,0)))
        ,((mod1Mask .|. shiftMask      , xK_d), withFocused (keysResizeWindow (0,-20) (0,0)))
        ,((mod1Mask .|. shiftMask      , xK_s), withFocused (keysResizeWindow (0,20) (0,0)))
        ,((mod1Mask .|. shiftMask      , xK_f), withFocused (keysResizeWindow (20,0) (0,0)))

        ,((mod1Mask .|. controlMask, xK_q), spawn "konsole -e vim /home/daniel/.xmonad/xmonad.hs")

        -- SubLayout stuff
        ,((mod1Mask .|. controlMask, xK_h), sendMessage $ pullGroup L)
        ,((mod1Mask .|. controlMask, xK_l), sendMessage $ pullGroup R)
        ,((mod1Mask .|. controlMask, xK_k), sendMessage $ pullGroup U)
        ,((mod1Mask .|. controlMask, xK_j), sendMessage $ pullGroup D)

        ,((mod1Mask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
        ,((mod1Mask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))

        ,((mod1Mask .|. controlMask, xK_period), onGroup W.focusUp')
        ,((mod1Mask .|. controlMask, xK_comma), onGroup W.focusDown')

        ,((mod1Mask .|. controlMask, xK_space), toSubl NextLayout)
        ,((mod1Mask .|. shiftMask .|. controlMask, xK_space), toSubl FirstLayout)

        ,((mod1Mask .|. controlMask .|. shiftMask    , xK_l), toSubl Shrink)
        ,((mod1Mask .|. controlMask .|. shiftMask    , xK_h), toSubl Expand)
        
        ,((mod1Mask            , xK_0), spawn "xdotool key alt+6")
        ,((mod1Mask            , xK_9), spawn "xdotool key alt+5")
        ,((mod1Mask            , xK_8), spawn "xdotool key alt+4")
        ,((0                , xK_Super_L), spawn "menu ~/.xmonad/apps")
        ,((mod1Mask            , xK_Super_L), spawn "menu ~/.xmonad/configs")
        ,((mod1Mask              , xK_F1), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_music.sh")
        ,((mod1Mask              , xK_F2), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_date.sh")
        ,((mod1Mask              , xK_F3), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_network.sh")
        ,((mod1Mask              , xK_F4), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_vol.sh")
        ,((mod1Mask              , xK_F5), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_battery.sh")
        ,((mod1Mask              , xK_F6), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_hardware.sh")
        ,((mod1Mask              , xK_F7), spawn "~/.xmonad/sc ~/.xmonad/scripts/dzen_log.sh")
        ,((0                  , xK_Print), spawn "scrot & mplayer /usr/share/sounds/freedesktop/stereo/screen-capture.oga")
        ,((mod1Mask              , xK_Print), spawn "scrot -s & mplayer /usr/share/sounds/freedesktop/stereo/screen-capture.oga")
        ,((0                         , xF86XK_AudioLowerVolume), spawn "amixer set Master 2- & mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        ,((0                         , xF86XK_AudioRaiseVolume), spawn "amixer set Master 2+ & mplayer /usr/share/sounds/freedesktop/stereo/audio-volume-change.oga")
        ,((0                         , xF86XK_AudioMute), spawn "amixer set Master toggle")
        ,((0                         , xF86XK_Display), spawn "/home/daniel/scripts/project")
        ,((0                         , xF86XK_Sleep), spawn "pm-suspend")
        ,((0                         , xF86XK_AudioPlay), spawn "ncmpcpp toggle")
        ,((0                         , xF86XK_AudioNext), spawn "ncmpcpp next")
        ,((0                         , xF86XK_AudioPrev), spawn "ncmpcpp prev")
        ]
        `additionalMouseBindings`
        [((mod1Mask            , 6), (\_ -> moveTo Next NonEmptyWS))
        ,((mod1Mask            , 7), (\_ -> moveTo Prev NonEmptyWS))
        ,((mod1Mask            , 5), (\_ -> moveTo Prev NonEmptyWS))
        ,((mod1Mask            , 4), (\_ -> moveTo Next NonEmptyWS))
--        ,((0                , 2), (\w -> focus w >> windows W.swapMaster))
--        ,((0                , 3), (\w -> focus w >> FlexibleResize.mouseResizeWindow w))
        ]



-- Define constants

myTerminal     = "urxvtc"
myBitmapsDir    = "~/.xmonad/dzen2/"

--myFont         = "-*-tamsyn-medium-r-normal-*-12-87-*-*-*-*-*-*"
myFont        = "-*-terminus-medium-*-normal-*-9-*-*-*-*-*-*-*"
--myFont        = "-*-nu-*-*-*-*-*-*-*-*-*-*-*-*"
--myFont            = "-artwiz-lime-medium-r-normal-*-10-110-75-75-m-50-iso8859-*"
--myFont            = "-artwiz-limey-medium-r-normal-*-10-110-75-75-m-50-iso8859-*"
--myFont        = "-benis-lemon-medium-r-normal-*-10-110-75-75-m-50-iso8859-*"
--myFont        = "'sans:italic:bold:underline'"
--myFont        = "xft:droid sans mono:size=9"
--myFont        = "xft:Droxd Sans:size=12"
--myFont        = "-*-cure-*-*-*-*-*-*-*-*-*-*-*-*"



background= "#181512"
foreground= "#bea492"

color0= "#332d29"
color8= "#817267"

color1= "#8c644c"
color9= "#9f7155"

color2= "#c4be90"
color10= "#bec17e"

color3= "#bfba92"
color11= "#fafac0"

color4= "#646a6d"
color12= "#626e74"

color5= "#6d6871"
color13= "#756f7b"

color6= "#3b484a"
color14= "#444d4e"

color7= "#504339"
color15= "#9a875f"



--background=            "#262729"
--foreground=            "#f8f8f2"
--color0=                "#626262"
--color8=                "#626262"
--color1=                "#f92671"
--color9=                "#ff669d"
--color2=                "#a6e22e"
--color10=               "#beed5f"
--color3=                "#fd971f"
--color11=               "#e6db74"
--color4=                "#1692d0"
--color12=               "#66d9ef"
--color5=                "#9e6ffe"
--color13=               "#df92f6"
--color6=                "#5e7175"
--color14=               "#a3babf"
--color7=                "#ffffff"
--color15=               "#ffffff"
--cursorColor=           "#b5d2dd"
--
