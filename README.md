# arc-memorymgt-swift

## Automatic Reference Counting (ARC)
   ARC is used in swift to keep track of strong references to instances of classes and 
   increases or decrease their reference count accordingly when you assign or unassign 
   instances of classes to constants and variables.

## Weak references and unowned references 
   For a class instance to be deallocated with ARC, it need to be free of all strong 
   references.
   
   Weak reference is used when you know that a reference is allowed to become nil.
   
   Unowned reference is used when your are certain thst the refernce has a longer lifecycle
   and will nver become nil.
