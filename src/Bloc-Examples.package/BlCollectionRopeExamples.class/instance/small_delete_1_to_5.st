examples - deletion
small_delete_1_to_5
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 1 to: 5.
	
	self assert: aNewRope size equals: 0.
	self assert: aNewRope collection equals: #().
	
	^ aNewRope