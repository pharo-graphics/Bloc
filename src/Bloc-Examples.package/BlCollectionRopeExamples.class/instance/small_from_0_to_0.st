examples - accessing
small_from_0_to_0
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 0 to: 0.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: #().
	
	^ aNewRope