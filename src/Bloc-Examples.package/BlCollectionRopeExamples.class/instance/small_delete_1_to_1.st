examples - deletion
small_delete_1_to_1
	<gtExample>
	| aRope aNewRope |
	
	aRope := self smallCollection.
	aNewRope := aRope delete: 1 to: 1.
	
	self assert: aNewRope size equals: 4.
	self assert: aNewRope collection equals: 'ello' asArray.
	
	^ aNewRope