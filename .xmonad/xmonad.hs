import System.IO
import System.Exit
import System.Environment

import XMonad

import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt

import XMonad.Operations

import XMonad.Actions.CycleWS
import XMonad.Actions.Warp
import XMonad.Actions.FloatKeys

import XMonad.Util.Run

import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.NoBorders -- (smartBorders, noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.Reflect (reflectHoriz)
import XMonad.Layout.IM
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid
import XMonad.Layout.Gaps
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.IndependentScreens

import Data.Maybe (fromJust)
import Data.Ratio ((%))

import qualified XMonad.StackSet as W
import qualified Data.Map as M

-------------------------
-- COLORS
-------------------------
colorBlack      = "#0d0d0e"
colorDarkGray   = "#2d2d2e" 
colorGray       = "#4f4f4f" 
colorLightGray  = "#808080"
colorWhite      = "#dedede"
colorBlue       = "#5174e1"
colorGreen      = "#007a4f" 
colorPurple     = "#6016cd"
colorYellow     = "#e1be51"
colorRed        = "#7a002b"
colorCyan       = "#0085b0" 

-------------------------
-- CONFIG
-------------------------
fonts' :: [String]
fonts' = [ "xft:UnifrakturCook:size=14:antialias=true:style=Light"
         , "FantasqueSansMono Nerd Font Mono:size=12:antialias=true"
         , "xft:Symbola:size=16:style=Regular"
         , "Sazanami Mincho:size=14:style=Regular" 
         ]

workSpaces' :: [String]
workSpaces' = ["Ⅰ ", "Ⅱ ", "Ⅲ ", "Ⅳ ", "Ⅴ ", "Ⅵ ", "Ⅶ ", "Ⅷ ", "Ⅸ ", "Ⅹ "]
-- workSpaces' = [show x | x <- [0..9]]
-- workSpaces' = [ "0:十", "1:一", "2:二", "3:三", "4:四"
--               , "5:五", "6:六", "7:七", "8:八", "9:九" ]
-- workSpaces' = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X"]

spacing' :: Integer
spacing' = 10

borderWidth' :: Dimension
borderWidth' = 2

-------------------------
-- QUIRKS
-------------------------
manageHook' :: ManageHook 
manageHook' = composeAll (([ className =? c --> doCenterFloat | c <- floats']) 
                       ++ ([ resource =? r --> doIgnore | r <- ignores']))
                where
                    ignores' = ["stalonetray", "trayer"]
                    floats'  = [ "Sxiv"
                               , "Dragon-drag-and-drop"
                               , "Catclock"
                               , "matplotlib"
                               , "Matplotlib"
                               , "r_x11" 
                               , "R_x11" 
                               , "gnuplot_qt"
                               , "Gnuplot"
                               , "TopLevelShell"
                               , "Julia"
                               , "gksqt"
                               , "Steam"
                               , "Pinentry-gtk-2"
                               , "xfreerdp"
                               ]

-------------------------
-- STATUSBAR
-------------------------
xmobarPP' :: Handle -> PP
xmobarPP' h = xmobarPP { ppCurrent = xmobarColor colorBlack colorLightGray 
                                   . wrap "<fc=#808080,#0d0d0e><fn=1>\xe0be</fn></fc><fn=2>" 
                                          "</fn><fc=#808080,#0d0d0e><fn=1>\xe0b8</fn></fc>"
                       , ppVisible = xmobarColor colorDarkGray colorGray 
                                   . wrap "<fc=#4f4f4f,#0d0d0e><fn=1>\xe0be</fn></fc><fn=2>"
                                          "</fn><fc=#4f4f4f,#0d0d0e><fn=1>\xe0b8</fn></fc>"
                       , ppHidden  = xmobarColor colorLightGray colorDarkGray
                                   . wrap "<fc=#2d2d2e,#0d0d0e><fn=1>\xe0be</fn></fc><fn=2>"
                                          "</fn><fc=#2d2d2e,#0d0d0e><fn=1>\xe0b8</fn></fc>"
                       , ppSep     = xmobarColor colorWhite "" "<fn=1> \xe0b9 </fn>" 
                       , ppTitle   = xmobarColor colorWhite "" 
                                   . shorten 60
                       , ppUrgent  = xmobarColor colorWhite colorRed
                       , ppOutput  = hPutStrLn h
                       , ppLayout  = namedLayout
                       --, ppExtras = [ppWindow]
                       , ppOrder = \(ws : l : t : ex ) -> [ws, l] ++ ex ++ [t]
                       }

namedLayout :: String -> String
namedLayout "Spacing Tall"          = xmobarColor colorRed       "" "<fn=1>\xe3ce</fn>"
namedLayout "Spacing Full"          = xmobarColor colorPurple    "" "<fn=1>\xe39b</fn>"
namedLayout "Spacing Simple Float"  = xmobarColor colorGreen     "" "<fn=1>\xe3dc</fn>"
namedLayout "Spacing ResizableTall" = xmobarColor colorBlue      "" "<fn=1>\xe3dc</fn>"
namedLayout anything                = xmobarColor colorLightGray "" "<fn=1>\xf61a</fn>"

-------------------------
-- LAYTOUT
-------------------------
layoutHook' = avoidStruts $ spacingRaw False (Border spacing' spacing' 
                                                     spacing' spacing') 
                                       True (Border spacing' spacing' 
                                                    spacing' spacing') 
                                       True
                          $ smartBorders
                          (tiled' ||| float' ||| full' ||| tall')
            where 
                tiled' = Tall 1 (2/100) (5/8) 
                full' = noBorders Full 
                float' = simpleFloat 
                tall' = ResizableTall 1 (2/100) (1/2) []

-------------------------
-- PROMPT
-------------------------
promptFont'        = "xft:" ++ (fonts' !! 2)
promptBorderWidth' = 2
promptHeight'      = 30

defaultPromptConfig' :: XPConfig
defaultPromptConfig' = def { font              = promptFont'
                           , bgColor           = colorBlack
                           , fgColor           = colorWhite
                           , bgHLight          = colorGray
                           , fgHLight          = colorRed
                           , promptBorderWidth = promptBorderWidth'
                           , height            = promptHeight'
                           , historyFilter     = deleteConsecutive
                           }

dangerPromptConfig' :: XPConfig
dangerPromptConfig' = def { font              = promptFont'
                          , bgColor           = colorRed
                          , fgColor           = colorWhite
                          , bgHLight          = colorRed
                          , fgHLight          = colorLightGray
                          , promptBorderWidth = promptBorderWidth'
                          , height            = promptHeight'
                          , position          = Top
                          , historyFilter     = deleteConsecutive
                          }

-------------------------
-- DEFAULT APPLICATIONS
-------------------------
dbusSession :: String
dbusSession = "dbus-launch --exit-with-session"

statusBar' :: String
statusBar' = "xmobar " ++ homeDir ++ "/" ++ confDir ++ "/.xmobarrc"
    where 
        homeDir = "$HOME"
        confDir = ".xmonad"

terminal'         = "term"
screenLock'       = "screenlock"
launcher'         = "dmenu_exec"
passmenu'         = "pass.sh"
remoteConnection' = "consrv.sh"
initScreen'       = "output.sh"
grabScreen'       = "grabscreen.sh"
grabSection'      = "grabsection.sh"

-------------------------
-- KEY BINDINGS
-------------------------
modMask' :: KeyMask
modMask' = mod4Mask

keys' conf@ XConfig {XMonad.modMask = modMask} = M.fromList $
    [ ((modMask .|. shiftMask, xK_Escape) , confirmPrompt dangerPromptConfig' "exit" $ io exitSuccess)
    , ((modMask .|. shiftMask, xK_r)      , restart "xmonad" True)
    -- Applications:
    , ((modMask, xK_Return)               , spawn $ XMonad.terminal conf)
    , ((modMask, xK_Escape)               , spawn screenLock') 
    , ((modMask, xK_p)                    , spawn launcher')
    , ((modMask .|. shiftMask, xK_p)      , spawn passmenu')
    , ((modMask , xK_Print)               , spawn grabScreen')
    , ((modMask .|. shiftMask, xK_Print)  , spawn grabSection')
    , ((modMask, xK_r)                    , spawn remoteConnection')
    , ((modMask, xK_o)                    , spawn initScreen')
    -- Window Managing:
    , ((modMask .|. shiftMask, xK_c)      , kill)
    , ((modMask, xK_space)                , sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space)  , setLayout $ XMonad.layoutHook conf)
    , ((modMask, xK_n)                    , refresh)
    -- Movement:
    , ((modMask .|. shiftMask, xK_Return) , windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_m)      , windows W.focusMaster)
    , ((modMask, xK_j)                    , windows W.focusDown)
    , ((modMask, xK_k)                    , windows W.focusUp)
    , ((modMask .|. shiftMask, xK_j)      , windows W.swapDown)
    , ((modMask .|. shiftMask, xK_k)      , windows W.swapUp)
    , ((modMask, xK_h)                    , sendMessage Shrink)
    , ((modMask, xK_l)                    , sendMessage Expand)
    , ((modMask, xK_t)                    , withFocused $ windows . W.sink)
    , ((modMask, xK_f)                    , withFocused float)
    , ((modMask, xK_i)                    , sendMessage (IncMasterN 1))
    , ((modMask, xK_d)                    , sendMessage (IncMasterN (-1)))
    , ((modMask, xK_period)               , nextScreen)
    , ((modMask, xK_comma)                , prevScreen)
    , ((modMask .|. shiftMask, xK_period) , shiftNextScreen)
    , ((modMask .|. shiftMask, xK_comma)  , shiftPrevScreen)
    , ((modMask .|. controlMask, xK_k)    , withFocused $ keysMoveWindow (0, -10))
    , ((modMask .|. controlMask, xK_j)    , withFocused $ keysMoveWindow (0, 10))
    , ((modMask .|. controlMask, xK_h)    , withFocused $ keysMoveWindow (-10, 0))
    , ((modMask .|. controlMask, xK_l)    , withFocused $ keysMoveWindow (10, 0))
    , ((modMask .|. controlMask .|. shiftMask, xK_k), withFocused $ keysResizeWindow (0, -10) (0, 0))
    , ((modMask .|. controlMask .|. shiftMask, xK_j), withFocused $ keysResizeWindow (0, 10) (0, 0))
    , ((modMask .|. controlMask .|. shiftMask, xK_h), withFocused $ keysResizeWindow (-10, 0) (0, 0))
    , ((modMask .|. controlMask .|. shiftMask, xK_l), withFocused $ keysResizeWindow (10, 0) (0, 0))
    ] ++ 
    [((m .|. modMask, k)                  , windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

-------------------------
-- MOUSE BINDINGS
-------------------------
focusFollowsMouse' :: Bool
focusFollowsMouse' = False

mouseBindings' XConfig {XMonad.modMask = modMask} = M.fromList 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w) 
    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), \w -> focus w >> windows W.swapMaster) 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), \w -> focus w >> mouseResizeWindow w) 
    ]

-- Mouse Cursor Follow Focus
pointerFollowsFocus :: Rational -> Rational -> X ()
pointerFollowsFocus h v = do
    dpy <- asks display
    root <- asks theRoot
    withFocused $ \w -> do
        wa <- io $ getWindowAttributes dpy w
        (sameRoot,_,w',_,_,_,_,_) <- io $ queryPointer dpy root
        if sameRoot && w == w' then
            return ()
        else
            io $ warpPointer dpy none w 0 0 0 0
                (fraction h (wa_width wa)) (fraction v (wa_height wa))
                where fraction x y = floor (x * fromIntegral y)

-------------------------
-- MAIN
-------------------------
main :: IO () 
main = do
    n <- countScreens
    statusBars <- mapM (\i -> spawnPipe $ statusBar' ++ " -x " ++ show i) [0..n-1]
    xmonad $ docks $ ewmh $ def
        { terminal           = terminal'
        , modMask            = modMask'
        , focusFollowsMouse  = focusFollowsMouse'
        , keys               = keys'
        , mouseBindings      = mouseBindings'
        , workspaces         = workSpaces'
        , layoutHook         = layoutHook'
        , manageHook         = manageHook'
        , logHook            = mapM_ (dynamicLogWithPP . xmobarPP') statusBars
        , handleEventHook    = docksEventHook <+> fullscreenEventHook
        , normalBorderColor  = colorDarkGray
        , focusedBorderColor = colorLightGray
        , borderWidth        = borderWidth'
        }
