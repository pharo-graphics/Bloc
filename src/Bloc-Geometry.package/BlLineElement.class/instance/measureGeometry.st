layout
measureGeometry
	| aFromPoint aToPoint aDelta |
	
	aFromPoint := self fromPosition.
	aToPoint := self toPosition.
	aDelta := aFromPoint min: aToPoint.
	
	self geometry from: aFromPoint - aDelta to: aToPoint - aDelta