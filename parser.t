#charset "utf-8"
#include "playthology.h"

/*
This is a core class for the entire library in that it implements the core
parsing procedure. This means taking a command input from the player and
then determining what the command actually means. This provides the basis
for being able to execute the command.
*/
class Parser : object
  /*
  This method is the bread and butter of this class in that it's responsible
  for parsing and executing a command.
  */
  parse(command) {
    local tokens;

    try {
      /*
      The command tokenizer is coming from the language-specific library that
      Playthology includes. This object hooks into the tokenizing aspects
      provided by the built-in TADS 3 Tokenizer class.
      */
      tokens = commandTokenizer.tokenize(command);

      /*
      The getTokType is provided by the built-in tokens library and returns a
      token enum value describing the type of the token. In this case, the
      tokPunct refers to punctuation marks so the goal of this next bit of
      logic is to remove any terminal punctuation from the command.
      */
      while (tokens.length > 0 && getTokType(tokens[tokens.length]) == tokPunct) {
        tokens = tokens.removeElement(tokens.length);
      }
    } catch (TokErrorNoMatch exc) {
      return;
    }

    /*
    The assumption during the start of the parsing phase is that we're
    dealing with the first command.
    */
    local firstCommand = true;

    /*
    This try loop is what is actually going to parse the tokens.
    */
    try {
      /*
      If there are no tokens, that means an empty command.
      */
      if (tokens.length() == 0) {
        return;
      }

      /*
      At this point it's necessary to parse each predicate in the command
      line. This has to be done until there are no more tokens. If we're
      starting with the beginning of an entirely new command, then the
      command line is definitely the start of a sentence. This means we
      can parse with the firstCommandPhrase.
      */
      for (local root = firstCommandPhrase ; tokens.length() != 0;) {
        //
      }
    } catch (ParseError exc) {
      //
    }
  }

  /*
  As part of parsing, we might need to do special token processing that will
  depend on the type of command. There are separate codes to indicate the
  type of command and these are defined as "sc" types, which are implemented
  as enumerations. This method needs to return one of the enumeration codes.
  The "sc" refers to "story command".
  */
  scType() {
    return scStandard;
  }
;

/*
This is the root class for any grammar productions.
*/
class Production : object
;

/*
A production is an element of a grammar that is composed of smaller parts.
A Production class is provided that allows for representing the concept of
grammer production rules. A command production is a subclass of that class
that acts as a grammar rule for an entire command.
*/
class CommandProduction : Production
;
