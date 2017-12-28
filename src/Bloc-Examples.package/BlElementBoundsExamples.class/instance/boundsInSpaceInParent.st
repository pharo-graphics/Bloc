examples
boundsInSpaceInParent
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace inParent asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace inParent referenceElement equals: child.

	self assert: parent bounds inSpace inParent asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace inParent referenceElement equals: parent.

	^ parent