layout
onLayout: aBounds
	super onLayout: aBounds.

	leftParentheses scaleBy: (leftParentheses parent extent / leftParentheses extent) asFloatPoint.
	rightParentheses scaleBy: (rightParentheses parent extent / rightParentheses extent) asFloatPoint.