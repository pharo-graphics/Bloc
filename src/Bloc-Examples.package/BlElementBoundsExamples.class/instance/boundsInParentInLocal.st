examples
boundsInParentInLocal
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inParent inLocal asRectangle equals: (self childPosition extent: self childExtent).
	self assert: child bounds inParent inLocal referenceElement equals: child.

	self assert: parent bounds inParent inLocal asRectangle equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent inLocal referenceElement equals: parent.

	^ parent