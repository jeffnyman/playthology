#charset "utf-8"
#include "playthology.h"

/*
This class provides the implementation of a stream-oriented mechanism that
displays text on an interface, such as the console. The idea of a "stream"
refers to sequential strings of characters.

This class is also a preinit style object which means that, during the
pre-initialization phase, the execute() method on each instance of this
class will be invoked. In terms of this base class, the execute() action
will essentially invoke the constructor.
*/
class OutputStream : PreinitObject
  /*
  In the context of a stream-oriented output mechanism, applying filters
  refers to the process of modifying, transforming, or refining the data
  that flows through the output stream. Filters are used to selectively
  process or alter the data before it reaches its final destination, which
  here would refer to the display interface. This list provides will store
  the active filters on a given stream. These filters will be stored in
  the order that they must be called. Since the goal is to have a list in
  a particular order, this list should be a Vector.
  */
  filterList = []

  execute() {
    construct();
  }

  construct() {
    /*
    This sets up a vector of ten elements. Output streams are transient
    in nature so the filter list -- which applies filters on the output
    stream -- must be transient as well.
    */
    filterList = new transient Vector(10);
  }
;

/*
This is the output stream for the primary text area of the game. This
is the area where the player receives information about the story world
and gets updates to that story world based on their actions in it. This
object must be transient because the output stream is part of the user
interface being driven by the interpreter as part of the current session.
This interface is thus not impacted by save and restore operations.
*/
transient storyOutputStream : OutputStream
;
