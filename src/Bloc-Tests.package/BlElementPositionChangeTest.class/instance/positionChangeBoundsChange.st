tests
positionChangeBoundsChange
	<gtExample>
	| element |
	
	element := self element.
	element background: Color blue.
	element size: 100@100.
	element relocate: 0@0.
	element forceLayout.
	
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element boundsInParent equals: (0@0 extent: 100@100).
	
	"As soon as we change position bounds should change too"
	element position: 30@30 extent: element extent.
	
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element boundsInParent equals: (30@30 extent: 100@100).
	
	"change position and extent at the same time"
	element position: 50@50 extent: 150@150.
	
	self assert: element boundsInLocal equals: (0@0 extent: 150@150).
	self assert: element boundsInParent equals: (50@50 extent: 150@150).

	"layout recomputation resets position and extent to originally requested values"
	element requestLayout.
	element forceLayout.
	self assert: element boundsInLocal equals: (0@0 extent: 100@100).
	self assert: element boundsInParent equals: (0@0 extent: 100@100).

	^ element