vector functions
rotateBy: anAngleInRadians about: aCenterPoint 
	"Even though Point.theta is measured CW, this rotates with the more conventional CCW interpretateion of angle."
	| p r theta |
	p := self asPoint - aCenterPoint.
	r := p r.
	theta := anAngleInRadians asFloat - p theta.
	self x: (aCenterPoint x asFloat + (r * theta cos)) y: (aCenterPoint y asFloat - (r * theta sin))