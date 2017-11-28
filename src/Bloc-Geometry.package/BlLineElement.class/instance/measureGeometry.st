layout
measureGeometry
	| aDecoratedFromPoint aFromPoint aToPoint aDelta |

	aDecoratedFromPoint := self decoratedFromPosition.
	
	aFromPoint := self fromPosition.
	aToPoint := self toPosition.

	aDelta := aFromPoint min: aToPoint.
	
	self geometry from: aDecoratedFromPoint - aDelta to: aToPoint - aDelta