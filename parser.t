/*
This is a core class for the entire library in that it implements the core
parsing procedure. This means taking a command input from the player and
then determining what the command actually means. This provides the basis
for being able to execute the command.
*/
class Parser : object
  /*
  As part of parsing, we might need to do special token processing that will
  depend on the type of command. There are separate codes to indicate the
  type of command and these are defined as "sc" types, which are implemented
  as enumerations. This method needs to return one of the enumeration codes.
  The "sc" refers to "story command".
  */
  scType() {}
;
