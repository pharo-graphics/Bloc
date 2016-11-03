tests
testTwoExactChildrenInFitContent
	"Parent resizes to fit children"
	| childA childB |
	childA := self exact: 200@100.
	childB := self exact: 100@200.
	parent constraints horizontal fitContent.
	parent constraints vertical fitContent.
	
	parent addChildren: { childA . childB }.
	
	parent forceLayout.
	
	self assert: childA extent equals: 200@100.
	self assert: childA position equals: 0@0.
	
	self assert: childB extent equals: 100@200.
	self assert: childB position equals: 200@0.
	
	self assert: parent extent equals: 300@200.
	self assert: parent position equals: 0@0