#charset "utf-8"
#include "playthology.h"

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

mainCommon(func, [args]) {
  /*
  This storyStart is another interesting part. It doesn't actually exist
  in the context of the library. This is an object that the author must
  create as part of their project. This object must be an instance of a
  class that *is* in this library and that defines the `func` that was
  passed in. Although, given how TADS works, if the function does not
  exist on the object, nothing bad will happen.
  */
  storyStart.(func)(args...);
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
}
