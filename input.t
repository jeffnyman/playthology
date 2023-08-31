#charset "utf-8"
#include "playthology.h"

/*
This class was referred to as InputDef in the original TADS 3 libraries.
That wording appears to mean "input definition". I'm not sure if my name
is better but the idea is that when reading input from the player, that
input has a context, such as the prompt being displayed to the player.
This class serves as a base class for more specific classes.
*/
class InputContext : object
  /*
  The author may want to provide a specific function that handles how
  the prompt is displayed to the player. If this function is called,
  this variable holds a reference to it.
  */
  promptFunction = nil
;

/*
This class serves as an example of a more specific class for the input
context. The idea of this class being "basic" is essentially to do little
more than call the function pointer to the prompt function if one was
specified.
*/
class BasicInputContext : InputContext
  construct(promptFunction) {
    self.promptFunction = promptFunction;
  }
;
