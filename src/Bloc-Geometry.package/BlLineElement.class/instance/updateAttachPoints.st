attach points
updateAttachPoints
	| aFromPoint aToPoint |

	aFromPoint := fromAnchor positionWithin: self.
	aToPoint := toAnchor positionWithin: self.

	fromAttach positionAt: aFromPoint.
	toAttach positionAt: aToPoint.

	self geometry from: aFromPoint.
	self geometry to: aToPoint.

	self boundsCache invalidateBoundsInLocal