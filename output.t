#charset "utf-8"
#include "playthology.h"

/*
This class provides the implementation of a stream-oriented mechanism that
displays text on an interface, such as the console. The idea of a "stream"
refers to sequential strings of characters.

This class is also a preinit style object which means that, during the
pre-initialization phase, the execute() method on each instance of this
class will be invoked. In terms of this base class, the execute() action
will essentially invoke the constructor.
*/
class OutputStream : PreinitObject
  /*
  In the context of a stream-oriented output mechanism, applying filters
  refers to the process of modifying, transforming, or refining the data
  that flows through the output stream. Filters are used to selectively
  process or alter the data before it reaches its final destination, which
  here would refer to the display interface. This list provides will store
  the active filters on a given stream. These filters will be stored in
  the order that they must be called. Since the goal is to have a list in
  a particular order, this list should be a Vector.
  */
  filterList = []

  execute() {
    construct();
  }

  construct() {
    /*
    This sets up a vector of ten elements. Output streams are transient
    in nature so the filter list -- which applies filters on the output
    stream -- must be transient as well.
    */
    filterList = new transient Vector(10);
  }

  /*
  Here a filter can be added to the filter list. Crucially any element
  added to this list must be an object of class OutputFilter or, if not
  that specific class, at least one that implements a applyFilter() method.
  Filters are arranged in a stack, which means the last filter added will
  be the first one called during an output operation. So this method is
  always adding a new filter to the top of the stack.
  */
  addOutputFilter(filter) {
    filterList.append(filter);
  }
;

/*
This is the output stream for the primary text area of the game. This
is the area where the player receives information about the story world
and gets updates to that story world based on their actions in it. This
object must be transient because the output stream is part of the user
interface being driven by the interpreter as part of the current session.
This interface is thus not impacted by save and restore operations.
*/
transient storyOutputStream : OutputStream
;

/*
This is the base class for applying a specific filter to an output stream.
The interface defines a filterText() method and that must be present on
any object that is derived from this class.
*/
class OutputFilter : object
  /*
  This method is what applies the specific filter. Since this is very
  specific to whatever the filter mechanism does, this method needs to be
  overridden in each filter instance. The return value should always be
  the result of filtering the text. The default implementation is simply
  to return the text as it was passed in.
  */
  applyFilter(outputStream, displayText) {
    return displayText;
  }
;

/*
This is the base case for handling paragraphs. This is derived from the
base output filtering class and the goal of this subclass is to filter
strings as they are sent to the display interface but specifically around
handling what are called "paragraph markers."
*/
class ParagraphHandler : OutputFilter
;

/*
This is the primary handler for story paragraphs. There is no direct
implementation required here. However, this subclass is defined as
being transient since it is relevant to any display context in the
current session, which should extend over save and restore operations.
*/
transient storyParagraphHandler : ParagraphHandler;
