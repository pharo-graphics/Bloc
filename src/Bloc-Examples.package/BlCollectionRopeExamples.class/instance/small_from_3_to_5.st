examples - accessing
small_from_3_to_5
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 3 to: 5.
	
	self assert: aNewRope size equals: 3.
	self assert: aNewRope collection equals: 'llo'.
	
	^ aNewRope