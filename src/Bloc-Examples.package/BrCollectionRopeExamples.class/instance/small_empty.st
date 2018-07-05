examples - accessing
small_empty
	<gtExample>
	| aRope anEmpty |

	aRope := self smallCollection.
	anEmpty := aRope empty.
	
	self assert: anEmpty size equals: 0.
	self assert: anEmpty collection equals: #().

	^ anEmpty