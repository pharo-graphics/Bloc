examples - accessing
small_from_1_to_1
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 1.
	
	self assert: aNewRope size equals: 1.
	self assert: aNewRope collection equals: 'H'.
	
	^ aNewRope