"
From the Oxford Dictionary:
Stencil - a thin sheet of card, plastic, or metal with a pattern or letters cut out of it, used to produce the cut design on the surface below by the application of ink or paint through the holes.

In Bloc I play a role of an abstract factory to create predefined visual elements. The two scenarios where stencils should be used are:

1. When lazy element creation is needed, e.g. a variable number of tabs in a view.
2. When the element being created depends on run time information, e.g. the structure or content of the data to be displayed.

The idea behind a stencil as concept is to help developers reduce the use of block closures used with scripting API. The reason for that is the fact that block closures can not be recompiled while in a debugger, which makes system less debuggable and live programmable.

The only essential Stencil API is `=#create`= method, developers should implement it in their stencil subclasses. Note, that `=#create`= has zero arguments which by default makes Stencil stateless. It is also possible to implement a statefull Stencil. Let us formalise the both types:

 Stateless Stencil - A stencil that does not have any parameters and the result of #create method is always identical. Two stateless stencils are equal then and only then when their type is the same.

 Stateful Stencil - A parametrizable stencil whose result of a #create method depends on configuration. Two stencils of the same type configured differently are not considered to be equal.

While subclassing is being the preferable way of creating Stencils we still want to provide the support of block closures that play a role of a stencil. Any Valuable object can be converted to so the ValuableStencil by sending `=#asStencil`= convertion method to the object that implements it.

For example the following code creates a Stateless stencil that creates a simple visual element out of BlockClosure:
```
| aStencil anElement |
aStencil := [ BlElement new background: Color gray ] asStencil.
anElement := aStencil create.
```

Users can additionally provide Stencil arguments to achive a Stateful Stencil:

```
| aStencil anElement |
aStencil := [ :aColor | BlElement new background: aColor ] asStencil.
aStencil arguments: { Color gray }.
anElement := aStencil create.
```

"
Class {
	#name : 'BlStencil',
	#superclass : 'Object',
	#category : 'Bloc-Stencil',
	#package : 'Bloc',
	#tag : 'Stencil'
}

{ #category : 'instance creation' }
BlStencil class >> asStencil [
	<return: #BlStencil>

	^ self new
]

{ #category : 'converting' }
BlStencil >> asElement [
	<return: #BlElement>

	^ self create asElement
]

{ #category : 'converting' }
BlStencil >> asStencil [

	^ self 
]

{ #category : 'api - instantiation' }
BlStencil >> create [
	<return: #Object>

	^ self subclassResponsibility
]
