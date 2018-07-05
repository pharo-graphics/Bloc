examples - accessing
small_size
	<gtExample>
	| aRope |
	
	aRope := self smallCollection.

	self assert: aRope size equals: 5.

	^ aRope