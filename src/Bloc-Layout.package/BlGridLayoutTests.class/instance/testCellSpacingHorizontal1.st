tests - layout
testCellSpacingHorizontal1
	| childA childB |

	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 400.
	parent constraints vertical exact: 200.
	parent layout cellSpacing: 20.
	parent layout horizontal.

	parent addChildren: { childA. childB }.
	parent forceLayout.

	self assert: childA extent equals: 170@160.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 170@160.
	self assert: childB position equals: 210@20.
	
	self assert: parent extent equals: 400@200.
	self assert: parent position equals: 0@0.