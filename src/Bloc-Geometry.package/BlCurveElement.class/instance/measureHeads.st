layout
measureHeads
	| aFromPoint aToPoint aDelta |

	aFromPoint := self fromPosition.
	aToPoint := self toPosition.
	aDelta := aFromPoint min: aToPoint.

	fromHead measuredBounds position: (aFromPoint - aDelta) - (0 @ self fromHeadBreadth / 2.0).
	
	"now we need to rotate the head"
	fromHead transformDo: [ :aTransform |
		| anAngle |
		anAngle := (1@0) angleWith: self fromDirection negated asPoint.
		
		aTransform
			origin: BlAffineTransformationLeftCenterOrigin new;
			rotateBy: anAngle radiansToDegrees ].