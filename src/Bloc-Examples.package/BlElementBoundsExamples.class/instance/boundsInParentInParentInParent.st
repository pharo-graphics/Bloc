examples
boundsInParentInParentInParent
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self
		assert: child bounds inParent inParent inParent asRectangle
		equals: ((self childPosition + self parentPosition) extent: self childExtent).
	self assert: child bounds inParent inParent inParent referenceElement equals: parent.

	self
		assert: parent bounds inParent inParent inParent asRectangle
		equals: (self parentPosition extent: self parentExtent).
	self assert: parent bounds inParent inParent inParent referenceElement equals: parent.

	^ parent