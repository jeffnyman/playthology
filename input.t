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
      local result;
      local timeout;

      inputLineStart(context);

      /*
      Here a call is made to Playthology's specific handler for input line
      timeouts. It's worth noting that there is no default timeout so in the
      case where the timeout is nil, this call will act like the standard
      untimed input line handler.
      */
      result = pioInputLineTimeout(timeout);
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
  There can be multiple registered preparsers. Given this, there must be
  some kind of execution order. The idea is that the smaller values go
  first. What this property does is say what the starting execution
  number is. The logic will then run any preparsers in ascending order
  of this value.
  */
  runOrder = 100

  /*
  The registered list is a class property that contains a list of all the
  registered preparsers. This must be defined as static because it should
  not change after the program has started running.
  */
  registeredList = static new Vector(10)

  /*
  This is a class property that indicates if the registered list of
  preparsers has been sorted or not. When a new preparser is added, the
  list will be unsorted. When an execution method is called to run the
  preparsers, that will check for a sorted list and sort it if needed.
  */
  registeredListSorted = nil

  /*
  Registered preparsers can be marked as inactive. They all start as
  active by default, however.
  */
  isActive = true

  execute() {
    CommandPreParser.registerPreParser(self);
  }

  registerPreParser(parser) {
    if (registeredList.indexOf(parser) == nil) {
      registeredListSorted = nil;
      registeredList.append(parser);
    }
  }

  /*
  This is a class method and it's purpose is to run all of the registered
  preparsers. Any given command input can have multiple preparsers run
  against it and, in each case, this method should return the result of
  successively calling each preparser on the command input.
  */
  runAll(commandInput, parserType) {
    /*
    If the list of preparsers hasn't been sorted already, the initial
    logic here will sort the list in ascending order.
    */
    if (!registeredListSorted) {
      registeredList.sort(SortAsc, { x, y : x.runOrder - y.runOrder });
      registeredListSorted = true;
    }

    /*
    Now the preparsers must be interated through, calling their specific
    parsing method.
    */
    foreach (local preParser in registeredList) {
      if (preParser.isActive) {
        commandInput = preParser.performParsing(commandInput, parserType);
      }

      /*
      If the resulting command input is nil, this is an indication that the
      command input has been fully handled in terms of any preparsing
      operations for the given preparser. This means the command input in
      question needs no more preparsing. Keep in mind that this is checked
      for each preparser being executed.
      */
      if (commandInput == nil) {
        return nil;
      }
    }

    /*
    The returned result is the command input after any relevant preparsing
    operations have been performed.
    */
    return commandInput;
  }

  /*
  This is the core method of any preparser instance. Each instance should
  thus override this method to define any specific preparsing operations.
  The parser type is an "sc" (story command) enumeration that provides
  context for the type of command being dealt with.

  The default operation is to just return the original command input with
  no changes.
  */
  performParsing(commandInput, parserType) {
    return commandInput;
  }
;
