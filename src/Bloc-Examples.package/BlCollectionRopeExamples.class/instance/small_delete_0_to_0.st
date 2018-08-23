examples - deletion
small_delete_0_to_0
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 0 to: 0.
	
	self assert: aNewRope size equals: 5.
	self assert: aNewRope collection equals: 'Hello'.
	
	^ aNewRope