examples
boundsInLocalInLocal
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal inLocal asRectangle equals: (0@0 extent: self childExtent).
	self assert: parent bounds inLocal inLocal asRectangle equals: (0@0 extent: self parentExtent).

	^ parent