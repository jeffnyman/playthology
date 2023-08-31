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
    /*
    There needs to be a loop that keeps executing until the command has
    been fully read.
    */
    for (;;) {
      inputLineStart(context);
    }
  }

  inputLineStart(context) {}
;

/*
This is the base class for pre-parsing that is performed on any input
command. All preparsers have to be registered. Only registered preparers
will actually execute.

This class is also a preinit style object which means that, during the
pre-initialization phase, the execute() method on each instance of this
class will be invoked. In this case, the base preparser registers itself.
*/
class CommandPreParser : PreinitObject
  /*
  The registered list is a class property that contains a list of all the
  registered preparsers. This must be defined as static because it should
  not change after the program has started running.
  */
  registeredList = static new Vector(10)

  execute() {
    CommandPreParser.registerPreParser(self);
  }

  registerPreParser(parser) {
    if (registeredList.indexOf(parser) == nil) {
      registeredList.append(parser);
    }
  }

  /*
  This is a class method and it's purpose is to run all of the registered
  preparsers. Any given command input can have multiple preparsers run
  against it and, in each case, this method should return the result of
  successively calling each preparser on the command input.
  */
  runAll(commandInput, parserType) {}
;
