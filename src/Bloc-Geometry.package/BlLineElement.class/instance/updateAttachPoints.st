attach points
updateAttachPoints
	| aFromPoint aToPoint aFromAttachPosition aToAttachPosition |

	aFromPoint := fromAnchor positionWithin: self.
	aToPoint := toAnchor positionWithin: self.
	
	aFromAttachPosition := (aFromPoint - (fromAttach extent / 2.0)).
	aToAttachPosition := (aToPoint - (toAttach extent / 2.0)).
	
	fromAttach position: aFromAttachPosition.
	toAttach position: aToAttachPosition.

	self geometry from: aFromPoint.
	self geometry to: aToPoint