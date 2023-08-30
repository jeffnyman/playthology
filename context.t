#charset "utf-8"
#include "playthology.h"

/*
The libContext is referred to as libGlobal in the original TADS 3 libraries.
This is meant to signify global variables. But I feel that the operative
distinction is really one of context, where there are certain aspects of
the library available to all compilation units because they all share the
same context.
*/
libContext : object
  cliArgs = []
;

/*
This class is meant to be a core class that the author of a project creates
an instance of. Specifically, they will want a storyStart object that is an
instance of this class. This is related to the code in mainCommon() that
dynamically calls a begin() method on this instance. Rather than having the
author provide this method, however, this core class will provide it. In the
standard TADS 3 libraries the author has to create a gameMain object and
then define that as an instance of GameMainDef. I'm doing the same basic
logic but just using more domain relevant naming.
*/
class StoryGame : object
  begin() {
    "Story game has begun ...\n";
  }
;
