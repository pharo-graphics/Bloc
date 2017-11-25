layout
measureGeometry
	| aFromPoint aToPoint aDelta |
	
	aFromPoint := self originPosition.
	aToPoint := self cornerPosition.
	aDelta := aFromPoint min: aToPoint.
	
	self geometry from: aFromPoint - aDelta to: aToPoint - aDelta