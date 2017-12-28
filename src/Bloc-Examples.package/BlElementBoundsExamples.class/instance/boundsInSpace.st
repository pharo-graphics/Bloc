examples
boundsInSpace
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace referenceElement equals: child.

	self assert: parent bounds inSpace asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace referenceElement equals: parent.

	^ parent