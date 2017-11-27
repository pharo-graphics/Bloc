geometry
globalPositionFor: anElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aFromPosition aToPosition aDirection aPerpendicular aMiddle aCurvatureOrigin aCurvatureCorner |

	self
		assert: [ self referenceAnchors size = 2 ]
		description: [ 'Perpendicular anchor requires two anchors to work properly' ].

	aFromPosition := self referenceAnchors first globalPosition asBlocVector.
	aToPosition := self referenceAnchors second globalPosition asBlocVector.

	aCurvatureOrigin := (anElement localPointToGlobal: 0@0) asBlocVector.
	aCurvatureCorner := (anElement localPointToGlobal: 0 @ self curvature) asBlocVector.
	
	aDirection := aToPosition - aFromPosition.
	aPerpendicular := aDirection normal negated * (aCurvatureCorner - aCurvatureOrigin) length.
	aMiddle := aFromPosition + (aDirection / 2.0).

	^ (aMiddle + aPerpendicular) asPoint