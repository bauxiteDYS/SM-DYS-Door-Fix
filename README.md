# SM-DYS-Door-Fix
Sourcemod plugin for Dystopia that fixes the Source Engine bug for flying doors

## How to use
- Install the plugin and add the gamedata file to the appropriate paths, doors should not fly away anymore!
- Will work until the game gets any updates (so probably forever)


## Why the bug happens
- As far as I can tell in some situations (fast triggers + certain tickrates) `CBaseDoor::DoorGoUp( void )` and `CBaseDoor::DoorGoDown( void )` are called on the same tick
- This has an effect of causing the door to simply fly away for `m_flWait` time until they snap back to reality

## Credits  
Thanks to the people who helped me learn about how to finally fix a 20 year old bug in this game, and possibly all Source games released up to now, it's a big deal for Dystopia players especially as this game revolves around fast doors with fast re-trigger rates meaning the bug shows itself quite often, and has become part of the identity of the game.

Thanks to: Rain, Agiel, You're Pissed Off, SoftAsHell, MasterKatze, Snoopkirby, Alpha, Geist, Twincannon, Deathreus, Addie, Kenzzer, Bakugo, Brokenphilip, Nosoop, BT, MV, Psychonic.  
<sub>Yes, it's a huge deal for me, 2 decades of wondering why...</sub>

[<video src="[video/tf2_door_bug.mp4](https://github.com/bauxiteDYS/SM-DYS-Door-Fix/blob/main/video/tf2_door_bug.mp4)" width="640" height="360" controls></video>](https://github.com/bauxiteDYS/SM-DYS-Door-Fix/blob/main/video/tf2_door_bug.mp4)
