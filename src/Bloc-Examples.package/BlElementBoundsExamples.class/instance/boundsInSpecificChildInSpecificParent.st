examples
boundsInSpecificChildInSpecificParent
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inChild: child) inParent: child) === (child bounds inLocal)"
	self assert: ((child bounds inChild: child) inParent: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: ((child bounds inChild: child) inParent: child) referenceElement equals: child.

	"((parent bounds inChild: child) inParent: parent) === (parent bounds)"
	self assert: ((parent bounds inChild: child) inParent: parent) asRectangle equals: (0@0 extent: self parentExtent).
	
	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self assert: ((parent bounds inChild: child) inParent: parent) referenceElement equals: child.

	^ parent