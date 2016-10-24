# Slider

![CMPUT396 Project](https://s22.postimg.org/6gqbjdoq9/slider_thumb.png)

Slider is a player that uses minimax search for a set of games that have a single goal - which they share: the combination of tiles with matching values based on directional input. 

The different rulesets for each version of the game are implemented using LuaJIT and involve:
  - A "spawner", which tracks the locations where the computer can place a piece after the player's move and randomly outputs a new state 
  - A "mover", which tracks what directional inputs are valid and outputs a new state based on input

The visuals of the program are delivered using HTML/CSS/TypeScript and are as follows:
  - The game board
  - The movement of tiles based on keyboard input
  - Sliders to decide parameters such as the speed at which visuals update and time available to generate the search tree
  - Controls to excute, pause, and reset the player
  - User-defined row and column sizes.

The heuristic evaluation and tree generation is done in C++. The latter is done according to the rules defined in the lua modules.

### Requirements

Slider is packaged with the following:

* [LuaJIT] - Just-in-time compiler for Lua
* [Bootstrap] - Front-end web framework
* [jQuery] - JavaScript library for client-side scripting

This project is open-source and available [on GitHub][slider].

### Installation

### Development

### Todo

### License

MIT

   [slider]: <https://github.com/ioltuszyk/Slider>
   [LuaJIT]: <http://luajit.org/>
   [Bootstrap]: <http://getbootstrap.com/>
   [jQuery]: <http://jquery.com>
