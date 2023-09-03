# Development Notes

I'll be keeping some notes as I develop this library since TADS 3 is a somewhat complicated system to work in when developing a library for it.

One of the biggest challenges is that as you read code, you can't actually tell where something is defined. You will be using classes or objects or functions that can be defined in the system library, in the standard includes, or in some specific library that you're providing. As far as I can see there's no real namespacing mechanism in terms of how logic is imported into different modules. Everything seems to just get referenced globally, which is extremely challenging to reason about.

Adding to the complication, the Adv3Lite library changed a lot of material from Adv3 but kept the same comments in place. So if you use Adv3 as the basis for your work, the comments are entirely non-helfpul in many cases and, in fact, don't reflect the code.

Yet another complication is that Adv3 library uses a lot of terminology in its comments that are not really covered in the TADS 3 documentation at all. Overall, there is an extreme lack of useful context in how the original library was constructed. Libraries like Adv3Lite, as mentioned above, really just took in these same comments -- even when they no longer applied due to code changes -- and simply perpetuated the obfuscation.

Yet another complication is there are very few coding standards in the TADS 3 libraries. So, for example, you'll see variable definitions defined sometimes at the top of a method, sometimes at the bottom, sometimes interspersed within the code and so on. Sometimes what you're dealing with is not actually a variable at a all but a property. But when just reading the code, that's not obvious without the full context. There's nothing that distinguishes one from the other in many cases.

You also have to deal with what are called "preinit" objects that you need to look for in each module. These often perform some bit of setup that is relevant to the context of the module in question.

In short, a lot of code archaeology is required if you want to build something on top of TADS 3. It makes it a challenge and fun -- and sometimes frustrating -- exercise.

----

A challenge for handling input is two-fold:

- TADS provides an "HTML mode."
- TADS can interleave command-line input and real-time input.

All of this is documented extremely poorly in the official TADS documentation.

----

A challenge in general is that the virtual machine of TADS 3 has a series of persistence mechanisms. These are around the features of saving, restoring and restarting a game. (Also included is the ability to undo an action.) The idea is that whole sets of objects can outlive a particular session of the virtual machine.

Just about everything is persistent but anything _not_ persistent is called transient. Transient objects essentially only last for the current session of the virtual machine but, crucially, they do not get changed during restore or undo operations, unlike persistent objects. 

----

A challenge for the parsing is that so much relies on existing objects or definitions that it's very difficult to untangle what needs to be in place, at a bare minimum, to support the parsing. The parser, arguably one of the most important parts of the library, seems to be the part that is documented the worst in terms of how it's actual mechanics tie in with the rest of the library. There are plenty of code comments but their value is marginal in many cases. They are good for seeing how to use the existing parser; less good for seeing how the parser was built and thus how to construct your own.

There is an interesting [TADS Parser Manual](http://www.tads.org/t2doc/doc/parser.htm) but that's for TADS 2, not TADS 3, and thus I'm not sure how useful it is. At least some of that seems to be covered, to much less of an extent, for TADS 3 in the [Command Execution Cycle](http://www.tads.org/t3doc/doc/techman/t3cycle.htm).


----

A design thought: I wonder if "preinit" objects should go in their own module. Given the way the TADS 3 resolution works, this shouldn't actually be a problem since any code should be able to read any other code no matter where it is. This would help keep this logic visible. This is similar to how I'm moving all exceptions to an exceptions module.
