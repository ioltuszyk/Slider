# Slider

![CMPUT396 Project](https://s22.postimg.org/6gqbjdoq9/slider_thumb.png)

Slider is a program that uses minimax to play games that involve the combination of tiles with matching values based on directional input. 

Different rulesets can be used and created using Lua and involve changing parameters in the Rules table. Each ruleset should override:
  - Rules.spawning, which determines the method of creating new children under State.Branch when the computer plays (randomly).
  - Rules.movement, which determines the method of creating new children under State.Branch when the user plays (heuristic).

The heuristic evaluation and tree generation is done in C++ and referenced by LuaJIT's FFI.

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
