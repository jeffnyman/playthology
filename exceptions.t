/*
This exception is thrown when the player has taken some explicit action
to quit the program. Framing this as an exception frames it not so much
as an "error" but rather as an exceptional situation.
*/
class QuittingException : Exception;

/*
This exception is very specific and is thrown when a command input is
attempting to be read but the program itself has effectively stopped
responding in its environment. This could be due to the immediate
absence of input mechanisms or to the program itself terminating.
*/
class EndOfLifeException : Exception;
