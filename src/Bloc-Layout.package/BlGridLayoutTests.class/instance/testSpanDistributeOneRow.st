tests - unit - spans
testSpanDistributeOneRow
	| childA childB childC |

	childA := self matchParent.
	childB := self matchParent.
	childC := self matchParent.
	
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 400.
	parent layout rowCount: 1.

	parent addChildren: { childA. childB. childC }.
	parent forceLayout.

	self assert: (childA constraints grid horizontal spec span) equals: (1 to: 2).
	self assert: (childA constraints grid vertical spec span) equals: (1 to: 2).
	
	self assert: (childB constraints grid horizontal spec span) equals: (2 to: 3).
	self assert: (childB constraints grid vertical spec span) equals: (1 to: 2).
	
	self assert: (childC constraints grid horizontal spec span) equals: (3 to: 4).
	self assert: (childC constraints grid vertical spec span) equals: (1 to: 2).