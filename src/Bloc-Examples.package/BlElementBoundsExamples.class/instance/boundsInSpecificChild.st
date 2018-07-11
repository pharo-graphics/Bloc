examples
boundsInSpecificChild
	<gtExample>
	| parent child |

	parent := self parentWithChild.
	child := parent children first.

	"(child bounds inChild: child) === (child bounds inLocal)"
	self assert: (child bounds inChild: child) asRectangle equals: (0@0 extent: self childExtent).
	self assert: (child bounds inChild: child) referenceElement equals: child.
	
	self assert: (parent bounds inChild: child) asRectangle equals: (self childPosition negated extent: self parentExtent).
	self assert: (parent bounds inChild: child) referenceElement equals: child.

	^ parent