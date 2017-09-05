attach points
updateAttachPoints
	| aFromPoint aToPoint aFromAttachPosition aToAttachPosition angle |

	aFromPoint := fromAnchor positionWithin: self.
	aToPoint := toAnchor positionWithin: self.
	
	aFromAttachPosition := (aFromPoint - (fromAttach extent / 2.0)).
	aToAttachPosition := (aToPoint - (toAttach extent / 2.0)).
	
	fromAttach position: aFromAttachPosition.
	toAttach position: aToAttachPosition.

	self geometry from: aFromPoint.
	self geometry to: aToPoint.

	angle := 1@0 angleWith: (aFromPoint - aToPoint) normalized.
	fromAttach rotateByDegrees: angle radiansToDegrees center: fromAttach boundsInLocal center.
	toAttach rotateByDegrees: angle radiansToDegrees center: toAttach boundsInLocal center