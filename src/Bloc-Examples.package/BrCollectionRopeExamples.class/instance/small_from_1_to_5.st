examples - accessing
small_from_1_to_5
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope from: 1 to: 5.
	
	self assert: aNewRope == aRope.
	
	^ aNewRope