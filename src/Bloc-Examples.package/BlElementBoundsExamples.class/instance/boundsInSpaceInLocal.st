examples
boundsInSpaceInLocal
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inSpace inLocal asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inSpace inLocal referenceElement equals: child.

	self assert: parent bounds inSpace inLocal asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inSpace inLocal referenceElement equals: parent.

	^ parent