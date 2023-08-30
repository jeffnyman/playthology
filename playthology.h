#charset "utf-8"

#ifndef PLAYTHOLOGY_H
#define PLAYTHOLOGY_H

/*
The following function macro is used to always allow the object representing
the player character to be identified. Having the macro serves two purposes.
One purpose is that this allows the author to have an easy reference to the
object. The other purpose is tied to the fact that the object representing
the player character can change at the discretion of the author. The actual
reference to this object is held by the library context.
*/
#define gPlayerCharacter (libContext.currentPlayerCharacter)

#endif
