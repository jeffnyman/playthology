#charset "utf-8"

#ifndef PLAYTHOLOGY_H
#define PLAYTHOLOGY_H

#include <tads.h>
#include <tok.h>

/*
The following function macro is used to always allow the object representing
the player character to be identified. Having the macro serves two purposes.
One purpose is that this allows the author to have an easy reference to the
object. The other purpose is tied to the fact that the object representing
the player character can change at the discretion of the author. The actual
reference to this object is held by the library context.
*/
#define gPlayerCharacter (libContext.currentPlayerCharacter)

/*
The following function macro is used to reference the specific actor that is
performing the current command. That may very well be the player character
but it can be any non-player character as well.
*/
#define gActor (libContext.currentActor)

/*
There are certain story commands, prefixed with "sc", that are important to
the parsing process.

scStandard: parsing a standard command line.
*/
enum scStandard;

/*
The idea of a "verb rule" is that it starts the definition of a verb grammar
rule. The tag is a name that identifies the particular rule since there will
be many verb rules. Having a tagged name for each verb rule allows the author
to use the TADS 3 replace and modify mechanisms.
*/
#define VerbRule(tag) grammar predicate(tag);

#endif
