tests - layout
testCellSpacingVerical1
	| childA childB |

	childA := self matchParent.
	childB := self matchParent.
	parent constraints horizontal exact: 200.
	parent constraints vertical exact: 400.
	parent layout cellSpacing: 20.
	parent layout vertical.

	parent addChildren: { childA. childB }.
	parent forceLayout.

	self assert: childA extent equals: 160@170.
	self assert: childA position equals: 20@20.
	
	self assert: childB extent equals: 160@170.
	self assert: childB position equals: 20@210.
	
	self assert: parent extent equals: 200@400.
	self assert: parent position equals: 0@0.