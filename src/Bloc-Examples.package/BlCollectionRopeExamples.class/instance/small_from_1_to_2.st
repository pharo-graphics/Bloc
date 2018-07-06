examples - accessing
small_from_1_to_2
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 2.
	
	self assert: aNewRope size equals: 2.
	self assert: aNewRope collection equals: 'He'.
	
	^ aNewRope