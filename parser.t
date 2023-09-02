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

    try {
      //
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
