examples
boundsInLocalInSpace
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal inSpace asRectangle equals: (self childPosition + self parentPosition extent: self childExtent).
	self assert: child bounds inLocal inSpace referenceElement equals: child.

	self assert: parent bounds inLocal inSpace asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inLocal inSpace referenceElement equals: parent.

	^ parent