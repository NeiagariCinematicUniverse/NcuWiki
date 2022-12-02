# Exepctions

## Intro
VulcainPL offers a built-in Exception gesture. In reality, it strongly recommends using it, as the Exception is a primitive type with quite special characteristics.

## What is an exception?
First off, let's start with what they're not. Exceptions are not classes. This is shown by the fact that when you create a brand new exception, it starts with an e instead of a c. This may seem anodyne, but it matters in the way that technically speaking, when the Vulcain code is translated to C++ code before compilation, c will automatically be considered as a sub-class of Object, while e will be a sub-class of Exception.

Now let's talk more in details about what they actually are. The Exception class (from Vulcain's Base package) effectively is a class when it comes to C++. It has three attributes which are the following:
- name, string: The name of the Exception. By default, it is set to the name of the Exception class when instanciated. Though it is changeable throughout the lifespan of the object, it is considered a bad practice to change it at different heights in the stack.
- message, string: This just contains a little message about the exception. It's there to help, but it's not mandatory.
- code, long: This is the value of the exception. As you may know (or not), when throwing exceptions in C++, we throw a long value. Not an exception. Well, this is the value that will be thrown in reality. It allows the identification of the exception, and is thus essential. By convention, there are codes that are reserved by the language itself, spreaded among "classes". These are indexed below. <- INSERT LINK HERE

## How does it work?
So, basically, Exceptions have three values : a name, a message and a code.
And I don't know much more than that yet.

## Reserved codes
As discussed earlier, there are several classes of Exceptions, and here is the list:
- FunctionExceptions, 1xxx: Exceptions thrown when an error concerning input or output of a function is catched.
- RuntimeExceptions, 2xxx: Exceptions thrown during runtime. By default, these exceptions are caught by the main function and get printed to the user.
- IOExceptions, 3xxx: Exceptions thrown when trying to realise an impossible input/output instruction.
- ParsingException, 4xxx: Exception thrown when unable to parse successfuly.

### FunctionExceptions:
Here is the list of codes for the FunctionExceptions.

| Code | Exception name                     | Description                                                           |
|------|------------------------------------|-----------------------------------------------------------------------|
| 1000 | ValueExcpectedException            | Thrown if a value was null while not expected to.                     |
| 1001 | IncorrectValueException            | Thrown if a given value wasn't in a defined range.                    |
| 1002 | SignException                      | Thrown when signed/unsigned values are mixed together incorrectly.    |
| 1003 | LengthException                    | Thrown if a length has been evaluated as incorrect.                   |
| 1004 | SizeException                      | Similar to LengthException, just a different label.                   |
| 1005 | RangeException                     | Thrown when trying to access a zone out of range for example.         |

### RuntimeExceptions:
Here is the list of codes for the FunctionExceptions.
```

```

### IOExceptions:
Here is the list of codes for the FunctionExceptions.
```

```

### ParsingExceptions:
Here is the list of codes for the FunctionExceptions.
```

```
