instance creation
smallCollection
	<gtExample>
	| aRope |

	aRope := BlCollectionRope collection: 'Hello'.
	
	self assert: aRope depth equals: 1.
	self assert: aRope size equals: 5.
	self assert: aRope collection equals: 'Hello'.
	self assert: aRope isLeaf.
	
	^ aRope