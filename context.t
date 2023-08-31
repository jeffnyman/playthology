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

  /*
  There must be some reference to a current player character since that is
  what the player of the story controls. However, the library cannot state
  what that reference is, so it's set to nil by default.
  */
  currentPlayerCharacter = nil

  /*
  The concept of the "current actor" refers to whatever actor-based object
  is performing the current command.
  */
  currentActor = nil
;

libPreinit : PreinitObject
  execute() {
    /*
    The global macro that holds a reference to a player character object
    is set to whatever the author has specified in their required storyStart
    as the protagonist object. The reference here is to a protagonist of the
    story, thus abstracting away a bit the notion of a player character.
    */
    gPlayerCharacter = storyStart.startingProtagonist;

    /*
    The following logic applies output filters to the primary story output
    stream.
    */
    storyOutputStream.applyFilter(storyParagraphHandler);
  }
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
  /*
  This is a reference to the object that will be the player character. The
  author must provide this reference as part of the startStory implementation.
  */
  startingProtagonist = nil

  /*
  This is a default implementation for how a story begins. An author can
  override this method if they want to customize how the story begins.
  */
  begin() {
    "Story game has begun ...\n";

    gActor = startingProtagonist;

    showIntro();

    startStory();

    showLeaving();
  }

  beginAfterResore() {
    "Story game has begun (from saved state) ...\n";
  }

  /*
  This method is used to show introduction content for the project. An
  empty method is defined here because projects will want to override this
  for introductory aspects specific to the project in question. In a story
  context, this would likely set up the initial situation for the player.
  */
  showIntro() {}

  /*
  This method is used to show a message as the player is leaving the
  story. However, this is not really an "in story" sort of message but
  rather a closing statement for the player. An empty method is defined
  in order to allow for the hook but any specific project will want to
  override this if there is a parting message for the player.
  */
  showLeaving() {}
;
