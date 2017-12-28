examples
boundsInParent
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inParent asRectangle equals: (self childPosition extent: self childExtent).
	self assert: child bounds inParent referenceElement equals: child.

	self assert: parent bounds inParent asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent referenceElement equals: parent.

	^ parent