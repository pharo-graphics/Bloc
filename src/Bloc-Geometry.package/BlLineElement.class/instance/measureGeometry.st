layout
measureGeometry
	| aDecoratedFromPoint aDecoratedToPoint aDelta |

	aDecoratedFromPoint := self decoratedFromPosition.
	aDecoratedToPoint := self decoratedToPosition.

	aDelta := self fromPosition min: self toPosition.

	self geometry from: aDecoratedFromPoint - aDelta to: aDecoratedToPoint - aDelta