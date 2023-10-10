# Multiply and Surrender
## Video URL: https://www.youtube.com/watch?v=4HLJKxu1BUo
 A Prototype cloning themed 2d platformer game made in Godot for CS50

Throughout the entirity of CS50x, we've been relentlessly taught be Professor David J. Malan, that the **Divide and Conquer** is one of the best algorithms to do just about anything. 
This game, as the name may suggest, is a parody to that teaching.
The goal of the game is to retrieve the CS50 duck that has been stolen.


The basic features of the game, are like any other. But the special feature "**cloning and decloning**" is the unique concept that I came up with, and one that opens up a whole new realm of
puzzles and other possibilities. 

The Basic Control of the game are as follows,

+ Enter (when in a dialogue/tutorial) : Next line.
+ Arrow Keys : Basic Movement
+ Spacebar: Jump
+ Spacebar (when in air): Double Jump
+ Spacebar (when on wall): Wall jump,  [Please note that wall jumping also resets double jump, thus you can double jump again]
+ Shift or Z: Dash , [Pressing spacebar middash cancels the dash]
+ Holding down C (when the clonebar on the top right is full): Create a clone to distract enemies or solve puzzles.
+ CTRL: Destroy the current clone and go back to the previous clone. [Only works if there are at least two player characters in the scene]
+ Trying to move towards a wall while falling results in grapping the wall, thus a lower falling speed.

For this game, only 3 clones are allowed at a time, but this can be changed with a simple number shifting in the state.gd file in the directory /Scripts/StateMachine/state.gd

As there is no way to attack the enemies, please use the cloning feature to distract enemies.

![image](https://github.com/Arima57/Multiply-and-Surrender/assets/139682255/69ca67c9-ac70-4b3f-847a-cd87b64c277b)

Also use remember to use the clones to solve various puzzles.

![image](https://github.com/Arima57/Multiply-and-Surrender/assets/139682255/5c492174-53f8-48cb-8196-10de48402a13)



If anyone is going to be taking a look at the code, please use Godot instead of a standard IDE, as there a couple of built-in scripts (scripts that I built inside .tscn files)

Credits for the assets that have obtained from external sources (itch.io and craftpix) that require mention have been added alongside the files themselves and will also be updated below.

That's it, thanks for playing.





Assetpacks:

+ Hooded Protagonist: Penzilla - itch.io
+ Vagabond: Pixramen - itch.io
+ Tilesets and background: Craftpix
+ Forest parallax background assets: edermunizz - itch.io
+ Wolfpack: moonscript
  Please, remind me if I missed any mentions by chance.


Gratitude towards Professor David J. Malan, Carter Zenke, Brian Yu and every CS50 staff.
Special Credits to @CodingQuests for helping me kickstart with the Amazing Tutorials.
Special Thanks to other members of Studio RimeLight who were there to encourage me.

And thanks to everyone who took interest in the project.
