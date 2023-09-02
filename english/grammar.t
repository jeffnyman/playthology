#charset "utf-8"
#include "playthology.h"

/*
A grammar rule is defined using the grammar keyword and the first part of
his specifies the production name. A tag, given in parentheses, can also be
provided although this is optional. The tag is a way to allow identical
production names to be distinguished.

After the name and tag, a rules element is provided. This refers to one or
more syntax rules that have to be associated with the production that is
being defined.
*/

/*
This is the root grammar rule for the first command that is provided by
the user on the command line.
*/
grammar firstCommandPhrase(commandOnly)
  : commandPhrase -> cmd_
  : CommandProduction
;

/*
In grammar and syntax, a conjunction is a part of speech that is used to
connect words, phrases, or clauses. Conjunctions are used to show the
relationship between the elements they connect. A command phrase thus
must be aware of these conjunctions.
*/
grammar commandPhrase(specificConjuction) :
  predicate -> cmd_
  | predicate -> cmd_ commandOnlyConjunction -> conj_ *
  : CommandProduction
;

/*
Characters like ".", "!", and "?" are not actually considered conjunctions.
They're punctuation marks used to indicate the end of a sentence or to convey
specific meanings within a sentence. The reason they're treated differently
here is because they can connect multiple commands.
*/
grammar commandOnlyConjunction(sentenceEnding):
  '.'
  | '!'
  | '?'
  : Production
;

grammar commandOnlyConjunction(nonSentenceEnding):
  'then'
  | 'and' 'then'
  | ',' 'then'
  | ',' 'and' 'then'
  | ';'
  : Production
;
