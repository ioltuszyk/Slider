# Slider

![CMPUT396 Project](https://s22.postimg.org/6gqbjdoq9/slider_thumb.png)

Slider is a C++/Lua program that uses expectimax search to play games that involve the combination of tiles with matching values based on directional input. 

Different rulesets can be used and created using Lua and involve changing parameters in the State class. Each ruleset should override:
  - State:Spawn, which determines the method of creating new children under State.Tree when the computer plays.
  - State:Branch, which determines the method of creating new children under State.Tree when the user plays.

Developer documentation will be provided at a later date.

### Requirements

Slider is packaged with the following:

* [LuaJIT]

This project is open-source and available [on GitHub][slider].

### Installation

The required files are included in the source and library directories.

### Todo

Enhance multithreading capabilities, better memory management, and optimize heuristic evaluation

### License

MIT

   [slider]: <https://github.com/ioltuszyk/Slider>
   [LuaJIT]: <http://luajit.org/>
