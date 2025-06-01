-- https://thinkingeek.com/2011/11/21/simple-guide-configure-xmonad-dzen2-conky/
{- ORMOLU_DISABLE -}
import Control.Monad
import qualified Data.Map as Map

import XMonad
import XMonad.Util.EZConfig (additionalKeys, removeKeys)
import XMonad.Util.Run
import System.Exit

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicLog

import XMonad.Layout.Fullscreen
import XMonad.Layout.Spacing
import XMonad.Layout.PerScreen

import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
{- ORMOLU_ENABLE -}

myTerminal = "kitty"

myWorkspaces = ["1:web", "2:term", "3:vscode", "4:chat", "5:music", "6", "7", "8", "9"]

myStartupHook :: X ()
myStartupHook = do
  startupHook def
  spawn "setxkbmap -device $(~/.config/xmonad/device-id.sh \"Macally SLIMKEYC USB Keyboard.id\") -option altwin:swap_lalt_lwin,ctrl:ralt_rctrl"
  spawn "autorandr --detected | head -n 1 | xargs ~/.config/xmonad/caveman.sh && feh --bg-fill ~/dotfiles/desktop-images/2-crisco1UP.png"
  myLoadWorkspace "1:web"


main :: IO ()
main = do
  blugon <- spawnPipe "blugon"
  xmobar0 <- spawnPipe "xmobar -x 0"
  xmobar1 <- spawnPipe "xmobar -x 1"
  xmonad $
    ewmhFullscreen $
      docks
        def
          { terminal = myTerminal,
            focusedBorderColor = "#318CE7",
            borderWidth = 3,
            layoutHook = myLayoutHook,
            workspaces = myWorkspaces,
            manageHook = myManageHook,
            startupHook = myStartupHook,
            logHook =
              myLogHook
                <+> dynamicLogWithPP
                  xmobarPP
                    { ppOutput = \x -> hPutStrLn xmobar0 x >> hPutStrLn xmobar1 x
                    }
          }
          `removeKeys` myRemove 
          `additionalKeys` myKeys

myRemove = [(altMask .|. shiftMask, xK_q)]

myLayoutHook = avoidStruts $ ifWider 2000 (smartSpacingWithEdge 8 start) start
  where
    start = layoutHook def

myLogHook = logHook def

myManageHook :: ManageHook
myManageHook =
  composeAll . concat $
    [ [resource =? r --> doIgnore | r <- myIgnores], -- ignore desktop
      [className =? c --> doCenterFloat | c <- myFloats], -- float my floats
      -- [name =? n --> doCenterFloat | n <- myNames], -- float my names
      [isFullscreen --> doFullFloat]
    ]
  where
    -- classnames
    myDev = ["kitty"]
    myWebs = ["firefox"]
    myChat = ["discord"]
    myMusic = ["spotify"]
    myFloats = ["VirtualBox", "steam", "Android Studio"]
    myFulls = ["Dead Cells"]

    -- resources
    myIgnores = ["desktop", "desktop_window", "notify-osd", "stalonetray", "trayer"]


myVolumeUp = "amixer sset Master 10%+"

myVolumeDown = "amixer sset Master 10%-"

myToggleMute = "amixer sset Master toggle"

-- WIP
myDisplayBrightnessUp = "xbacklight -inc 10"

myDisplayBrightnessDown = "xbacklight -dec 10"

-- with the help of Morrow from the haskell discord and these 2 posts
-- https://stackoverflow.com/questions/45908110/start-applications-on-specific-workspace-if-not-yet-started-there
-- https://superuser.com/questions/596704/find-a-window-in-current-workspace-and-apply-some-action-to-it/852152#852152
getClassName :: Window -> X String
getClassName w = withDisplay $ \d -> fmap resClass $ io $ getClassHint d w

isNotOpen :: String -> X Bool
isNotOpen cn = do
  windows <- gets (W.index . windowset)
  cns <- mapM getClassName windows
  pure $ cn `notElem` cns

loadWorkspace :: String -> [(String, String)] -> X ()
loadWorkspace workspace commands = do
  windows $ W.greedyView workspace
  filteredCommands >>= mapM_ (spawn . snd)
  where
    filteredCommands :: X [(String, String)]
    filteredCommands = filterM (isNotOpen . fst) commands

myLoadWorkspace :: String -> X ()
myLoadWorkspace = (Map.!) $ Map.mapWithKey loadWorkspace windows 
  where
    windows = Map.fromList $ zip myWorkspaces [
              [("firefox", "firefox")],
              [("kitty", "kitty")],
              [("Code", "code")],
              [("Discord", "discord")],
              [("Spotify", "spotify")]
              ]

-- :D
altMask = mod1Mask

metaMask = mod4Mask

myWorkspaceKeys = [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9]

-- https://www.reddit.com/r/xmonad/comments/g2dqvc/comment/fnmc6dd/?utm_source=share&utm_medium=web2x&context=3
myKeys =
  [ ((m, k), windows $ f i)
    | (i, k) <- zip myWorkspaces myWorkspaceKeys,
      (m, f) <-
        [ (altMask .|. shiftMask, W.shift --liftM2 (.) W.greedyView W.shift
          )
          --(metaMask .|. shiftMask, W.shift)
        ]
  ]
    ++ [
         -- https://askubuntu.com/a/1453626
         ((altMask, xK_0), spawn "setxkbmap -layout us"),
         ((altMask, xK_r), spawn "setxkbmap -layout ru -variant phonetic_mac"),
         ((altMask, xK_s), spawn "flameshot gui"),
         ((altMask, xK_f), spawn "firefox"),
         ((0, xF86XK_AudioRaiseVolume), spawn "pamixer --increase 5"),
         ((0, xF86XK_AudioLowerVolume), spawn "pamixer --decrease 5"),
         ((0, xF86XK_AudioMute), spawn "pamixer --toggle-mute"),
         ((altMask, xK_c), spawn "firefox --new-tab calendar.google.com"),
         ((altMask, xK_1), myLoadWorkspace "1:web"),
         ((altMask, xK_2), myLoadWorkspace "2:term"),
         ((altMask, xK_3), myLoadWorkspace "3:vscode"),
         ((altMask, xK_4), myLoadWorkspace "4:chat"),
         ((altMask, xK_5), myLoadWorkspace "5:music"),
         ((altMask .|. shiftMask, xK_q), kill),
         ((metaMask .|. shiftMask, xK_q), io exitSuccess),
         ((metaMask, xK_F1), spawn myToggleMute),
         ((metaMask, xK_F2), spawn myVolumeDown),
         ((metaMask, xK_F3), spawn myVolumeUp),
         ((metaMask, xK_F5), spawn myDisplayBrightnessUp),
         ((metaMask, xK_F6), spawn myDisplayBrightnessDown)
       ]
