# Slider

![CMPUT396 Project](https://s22.postimg.org/6gqbjdoq9/slider_thumb.png)

Slider is a player that uses minimax search for a set of games that have a single goal - which they share: the combination of tiles with matching values based on directional input. 

The different rulesets for each version of the game are implemented using LuaJIT and involve:
  - A "spawner", which tracks the locations where the computer can place a piece after the player's move and randomly outputs a new state 
  - A "mover", which tracks what directional inputs are valid and outputs a new state based on input

The heuristic evaluation and tree generation is done in C++. The latter is done according to the rules defined in the lua modules.

Developer documentation will be provided at a later date.

### Requirements

Slider is packaged with the following:

* [LuaJIT] - Just-in-time compiler for Lua

This project is open-source and available [on GitHub][slider].

### Installation

### Development

### Todo

Game states, lua libraries.

### License

MIT

   [slider]: <https://github.com/ioltuszyk/Slider>
   [LuaJIT]: <http://luajit.org/>
