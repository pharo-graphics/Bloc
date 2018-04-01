instance creation
emptySpace
	<gtExample>
	| aSpace |
	
	aSpace := BlSpace new.
	self assert: aSpace session equals: Smalltalk session.
	self assert: aSpace root hasChildren not.
	self assert: aSpace dirtyAreas isEmpty.
	self assert: aSpace extent equals: aSpace defaultExtent.
	self assert: aSpace height equals: aSpace defaultExtent y.
	self assert: aSpace width equals: aSpace defaultExtent x.
	self assert: aSpace position equals: 0@0.
	self assert: aSpace resizable.
	self assert: aSpace borderless not.
	self assert: aSpace fullscreen not.
	self assert: aSpace focused not.
	self assert: aSpace hasHostSpace not.
	self assert: aSpace hasDirtyAreas not.
	self assert: aSpace hasLayoutError not.
	self assert: aSpace isLayoutRequested.
	self assert: aSpace isVisible not.
	self assert: aSpace title isEmpty.

	^ aSpace