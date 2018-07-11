examples
boundsInSpecificParentInSpecificChild
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"((child bounds inParent: parent) inChild: child) === (child bounds inLocal)"
	self assert: ((child bounds inParent: parent) inChild: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: ((child bounds inParent: parent) inChild: child) referenceElement equals: child.

	"((parent bounds inParent: parent) inChild: parent) === (parent bounds inLocal)"
	self assert: ((parent bounds inParent: parent) inChild: parent) asRectangle equals: (0@0 extent: self parentExtent).
	
	"the reason why reference element is `child` is because bounds in parent have a child as a reference element"
	self assert: ((parent bounds inParent: parent) inChild: parent) referenceElement equals: parent.

	^ parent