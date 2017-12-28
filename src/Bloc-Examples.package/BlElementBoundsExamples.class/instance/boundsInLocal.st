examples
boundsInLocal
	"Bounds in local always have position 0@0"
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds inLocal asRectangle equals: (0@0 extent: self childExtent).
	self assert: parent bounds inLocal asRectangle equals: (0@0 extent: self parentExtent).

	^ parent