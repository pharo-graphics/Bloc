examples
boundsInSpecificParent
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	self assert: (child bounds inParent: parent) asRectangle equals: (self childPosition extent: self childExtent).
	self assert: (child bounds inParent: parent) referenceElement equals: child.

	"(parent bounds inParent: parent) === (parent bounds inLocal)"
	self assert: (parent bounds inParent: parent) asRectangle equals: (0@0 extent: self parentExtent).
	self assert: (parent bounds inParent: parent) referenceElement equals: parent.

	^ parent