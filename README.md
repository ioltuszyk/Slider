# Slider

![CMPUT396 Project](https://s22.postimg.org/6gqbjdoq9/slider_thumb.png)

Slider is a program that uses an alpha-beta search tree to play games that involve the combination of tiles with matching values based on directional input. 

Different rulesets can be used and created using Lua and involve changing parameters in the State class. Each ruleset should override:
  - State:Spawn, which determines the method of creating new children under State.Tree when the computer plays.
  - State:Branch, which determines the method of creating new children under State.Tree when the user plays.

The heuristic evaluation and tree generation is done in C++

Developer documentation will be provided at a later date.

### Requirements

Slider is packaged with the following:

* [LuaJIT]

This project is open-source and available [on GitHub][slider].

### Installation

The required files are included in the source and library directories,

### Todo

Generate alpha-beta tree, propagation of heuristic value, enhance multithreading capabilities, optimize heuristic evaluation

### License

MIT

   [slider]: <https://github.com/ioltuszyk/Slider>
   [LuaJIT]: <http://luajit.org/>
