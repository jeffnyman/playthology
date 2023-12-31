#charset "utf-8"
#include "playthology.h"

/*
This is the primary entry point function that is required for any TADS 3
program. This function is called by the system library, specifically the
_main.t module. That particular module, as opposed to the entire system
library, is included by default in all TADS 3 compiled programs. The only
way that isn't the case is if the program is compiled with a "-nodef"
option.
*/
main(args) {
  "Playthology Library\n";

  libContext.cliArgs = args;

  /*
  This part is interesting. I'm passing in a pointer to a function. This
  function must be defined on a particular class. That particular class
  must be one that the author is required to create an instance of in
  their project.
  */
  mainCommon(&begin);
}

/*
This is an entry point function that starts a story at a particular state,
as opposed to the beginning state. The restore state must be provided by a
"saved state" file, which essentially contains a snapshot of the virtual
machine memory when the player chose to save that state.
*/
mainRestore(args, restoreState) {
  libContext.cliArgs = args;

  mainCommon(&beginAfterRestore, restoreState);
}

/*
Any entry point functions can delegate to this common handler which will
make sure that the program can be started regardless of the entry point
function that was specifically called.
*/
mainCommon(func, [args]) {
  try {
    /*
    This storyStart is another interesting part. It doesn't actually exist
    in the context of the library. This is an object that the author must
    create as part of their project. This object must be an instance of a
    class that *is* in this library and that defines the `func` that was
    passed in. Although, given how TADS works, if the function does not
    exist on the object, nothing bad will happen.
    */
    storyStart.(func)(args...);
  } catch (QuittingException exc) {
    /*
    This indicates that the player has explicitly tried to quit the program.
    A return from this function will take the execution back to the entry
    point function. Since there should be no other logic in the entry point
    after calling this function, the program will return from that entry
    point, which effectively ends the program.
    */
  }
  
}

/*
This function matches the runGame() method in the standard TADS 3 library
implementations. 
*/
startStory() {
  /*
  When the story starts, the actor who will be performing the current
  command will be the player character. This must be the case since this
  is the starting action of the story, which cannot be directed to another
  actor, such as a non-player character.
  */
  gActor = gPlayerCharacter;

  /*
  The command loop must be started. This is the core operating logic of
  the story.
  */
  commandLoop();
}

commandLoop() {
  "Entering the command loop ...";

  local playerCommand;

  do {
    try {
     /*
      The first step is to read a command from the keyboard interface. This
      is a command that the player would have specified at the command line
      within the program.
      */
      playerCommand = inputHandler.readInputLine();

      playerCommand = CommandPreParser.runAll(playerCommand, Parser.scType());
      tadsSay(playerCommand); // REMOVE

      /*
      If the player command is nil, that means one of the command preparsers
      has fully dealt with the command. This means that the command loop can
      be continued.
      */
      if (playerCommand == nil) {
        continue;
      }

      /*
      This statement is crucial! This is where the command provided by the
      player is parsed and executed.
      */
      Parser.parse(playerCommand);
    } catch (TerminateCommandException exc) {
      /*
      This exception indicates a syntax error or semantic resolution error
      that renders the command meaningless or makes it impossible to proceed.
      */
    }
  } while (true);
}
