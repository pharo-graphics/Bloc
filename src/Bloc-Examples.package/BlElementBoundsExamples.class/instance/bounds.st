examples
bounds
	"Element bounds consist of position and extent"
	<gtExample>
	| parent child |
	
	parent := self parentWithChild.
	child := parent children first.

	self assert: child bounds asRectangle equals: (self childPosition extent: self childExtent).
	self assert: parent bounds asRectangle equals: (self parentPosition extent: self parentExtent).
	
	^ parent