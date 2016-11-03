measure
measuredBreadthWithMargin: anElement
	"Return measured Breadth of an element with breadth margin.
	Used during measuring pass.
	If anElement has resizing set to match parent
	return only margin, otherwise measured breadth plus margin.
	anElement must not be nil"
	<return: #Number>
	self assert: anElement isNotNil.
	
	^ ((self orientation breadthProperties: anElement) resizer isMatchParent
			ifFalse: [ self orientation measuredBreadth: anElement ]
			ifTrue: [ 0 ]) + (self orientation marginBreadth: anElement).