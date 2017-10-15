layout
onLayout: aBounds
	| leftScale rightScale |
	super onLayout: aBounds.

	leftScale := (leftParentheses parent extent / leftParentheses extent) asFloatPoint.
	rightScale := (rightParentheses parent extent / rightParentheses extent) asFloatPoint.

	leftParentheses transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: leftScale x y: leftScale y z: 1);
		apply.

	rightParentheses transform
		origin: (BlAffineTransformationPositionOrigin position: 0@0);
		scaleBy: (BlVector x: rightScale x y: rightScale y z: 1);
		apply