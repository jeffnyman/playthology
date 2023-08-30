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
