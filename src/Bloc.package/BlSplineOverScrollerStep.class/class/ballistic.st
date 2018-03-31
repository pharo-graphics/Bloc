accessing
ballistic
	^ ballistic ifNil: [ ballistic := BlSplineOverScrollerBallisticStep new ]