name: Playthology Library
source: main
source: context
source: input
source: output
source: exceptions
source: parser
source: console

needmacro: LANGUAGE selects the language the library uses in messages and parsing
library: $(LANGUAGE)/$(LANGUAGE).tl
