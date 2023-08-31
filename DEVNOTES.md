# Development Notes

I'll be keeping some notes as I develop this library since TADS 3 is a somewhat complicated system to work in when developing a library for it.

One of the biggest challenges is that as you read code, you can't actually tell where something is defined. You will be using classes or objects or functions that can be defined in the system library, in the standard includes, or in some specific library that you're providing. As far as I can see there's no real namespacing mechanism in terms of how logic is imported into different modules. Everything seems to just get referenced globally, which is extremely challenging to reason about.

----

A challenge for handling input is two-fold:

- TADS provides an "HTML mode."
- TADS can interleave command-line input and real-time input.

All of this is documented extremely poorly in the official TADS documentation.

----

A challenge in general is that the virtual machine of TADS 3 has a series of persistence mechanisms. These are around the features of saving, restoring and restarting a game. (Also included is the ability to undo an action.) The idea is that whole sets of objects can outlive a particular session of the virtual machine.

Just about everything is persistent but anything _not_ persistent is called transient. Transient objects essentially only last for the current session of the virtual machine but, crucially, they do not get changed during restore or undo operations, unlike persistent objects. 
