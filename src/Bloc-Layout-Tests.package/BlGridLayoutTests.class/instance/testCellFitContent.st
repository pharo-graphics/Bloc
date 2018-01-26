tests - layout
testCellFitContent
	| child subchild |

	parent constraintsDo: [ :c |
		c horizontal exact: 300.
		c vertical fitContent ].
	parent background: Color white.

	child := self matchWidthFitHeight.
	child layout: BlGridLayout vertical.
	child background: Color paleBlue.

	subchild := self exact: 200@100.
	subchild background: Color paleRed.

	child addChild: subchild.
	parent addChild: child.

	parent forceLayout.

	self assert: subchild extent equals: 200@100.
	self assert: subchild position equals: 0@0.

	self assert: child extent equals: 300@100.
	self assert: child position equals: 0@0.

	self assert: parent extent equals: 300@100.
	self assert: parent position equals: 0@0.

	^ parent