examples - accessing
small_depth
	<gtExample>
	| aRope |
	
	aRope := self smallCollection.

	self assert: aRope depth equals: 1.

	^ aRope