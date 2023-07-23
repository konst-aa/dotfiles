-- https://thinkingeek.com/2011/11/21/simple-guide-configure-xmonad-dzen2-conky/
{- ORMOLU_DISABLE -}
import Control.Monad

import XMonad
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run

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

import qualified XMonad.StackSet as W
{- ORMOLU_ENABLE -}

myTerminal = "kitty"

myWorkSpaces = ["1:term", "2:web", "3:chat", "4:music", "5", "6", "7", "8", "9"]

myStartupHook = do
  startupHook def
  spawn "setxkbmap -device $(bash ~/.config/xmonad/device_id.sh \"Macally SLIMKEYC USB Keyboard.id\") -option altwin:swap_lalt_lwin,ctrl:ralt_rctrl"
  spawn "autorandr -c && feh --bg-fill ~/dotfiles/desktop-images/upscaled-shimmer-myr.jpg"

myBitmapsDir = "/home/konst/.config/xmonad/dzen2"

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
            workspaces = myWorkSpaces,
            manageHook = myManageHook,
            startupHook = myStartupHook,
            logHook =
              myLogHook
                <+> dynamicLogWithPP
                  xmobarPP
                    { ppOutput = \x -> hPutStrLn xmobar0 x >> hPutStrLn xmobar1 x
                    }
          }
        `additionalKeys` myKeys

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
    myFloats = ["VirtualBox", "steam"]
    myFulls = ["Dead Cells"]

    -- resources
    myIgnores = ["desktop", "desktop_window", "notify-osd", "stalonetray", "trayer"]

-- myStatusBar = "conky -c .conkyrc | dzen2 x 400"

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

-- :D
altMask = mod1Mask

metaMask = mod4Mask

myWorkspaceKeys = [xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9]

-- https://www.reddit.com/r/xmonad/comments/g2dqvc/comment/fnmc6dd/?utm_source=share&utm_medium=web2x&context=3
myKeys =
  [ ((m, k), windows $ f i)
    | (i, k) <- zip myWorkSpaces myWorkspaceKeys,
      (m, f) <-
        [ (metaMask, liftM2 (.) W.greedyView W.shift),
          (metaMask .|. shiftMask, W.shift)
        ]
  ]
    ++ [
         -- https://askubuntu.com/a/1453626
         ((altMask, xK_0), spawn "setxkbmap -layout us"),
         ((altMask, xK_r), spawn "setxkbmap -layout ru -variant phonetic_mac"),
         ((altMask .|. shiftMask, xK_f), spawn "flameshot gui"),
         ((altMask, xK_f), spawn "firefox"),
         ((altMask, xK_s), spawn "firefox --new-tab search.nixos.org"),
         ((altMask, xK_c), spawn "firefox --new-tab calendar.google.com"),
         ((altMask, xK_1), loadWorkspace "1:term" [("kitty", "kitty")]),
         ((altMask, xK_2), loadWorkspace "2:web" [("firefox", "firefox")]),
         ((altMask, xK_3), loadWorkspace "3:chat" [("Discord", "discord")]),
         ((altMask, xK_4), loadWorkspace "4:music" [("Spotify", "spotify")]),
         ((metaMask, xK_F1), spawn myToggleMute),
         ((metaMask, xK_F2), spawn myVolumeDown),
         ((metaMask, xK_F3), spawn myVolumeUp),
         ((metaMask, xK_F5), spawn myDisplayBrightnessUp),
         ((metaMask, xK_F6), spawn myDisplayBrightnessDown)
       ]
