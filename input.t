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

/*
In the TADS 3 libraries this object is called the "inputManager" whereas
I refer to it as a more of a "handler." Manager implies a higher-level of
control or coordination than what is done here. Handler, on the other hand,
suggests a more focused and specific role of processing.
*/
inputHandler : object
  /*
  This does exactly what the name of the method sounds like: it reads a
  line of input from the keyboard interface. The promptFunction can either
  be the pointer to a function to invoke or it can be a value string that
  contains the actual prompt to display.
  */
  readInputLine(promptFunction?) {
    return readInputLineContext(new BasicInputContext(promptFunction));
  }

  /*
  The idea of this method is to be a contextually-specific input line
  reader. This is called from a more generic input line reader. The
  context here would be a specific class that provides an input context.
  */
  readInputLineContext(context) {
    // IMPLEMENT
  }
;
