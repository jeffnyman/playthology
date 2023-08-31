#charset "utf-8"
#include "playthology.h"

/*
The purpose of this module is to define low-level functions that are used
for handling input and output. The presumed context here is the standard
user interface for the interpreter. This means using a local keyboard and
console via the tads-io function set which is built in to the interpreter.

Any of the functions in this module are designed primarily for internal use
within the library itself. The "pio" means "Playthology Input/Ouput" to
indicate this. An author writing a game would want to use the higher level
objects and functions that are defined in the input and output modules.

What this separation of concerns does is allow for subtituting in different
user interfaces. For example, the traditional console user interface could
be swapped with a browser-based interface.
*/

/*
This function calls the interpreter's console input timeout ability. The
inputLineTimeout() is defined as part ofs the tads-io function set and what
it does is read a line of text input from the user with an optional timeout
given in milliseconds. So what this library method does is essentially
delegate to that built-in function.
*/
pioInputLineTimeout(timeout) {
  return inputLineTimeout(timeout);
}
