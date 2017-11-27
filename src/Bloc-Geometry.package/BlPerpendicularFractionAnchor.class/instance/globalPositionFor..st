geometry
globalPositionFor: anElement
	"Compute and return a global position (in space) of this anchor"
	<return: #Point>
	| aFromPosition aToPosition aDirection aPerpendicular aMiddle |

	self
		assert: [ self referenceAnchors size = 2 ]
		description: [ 'Perpendicular anchor requires two anchors to work properly' ].

	aFromPosition := self referenceAnchors first globalPosition asBlocVector.
	aToPosition := self referenceAnchors second globalPosition asBlocVector.
	
	aDirection := aToPosition - aFromPosition.
	aPerpendicular := aDirection normal negated * aDirection length * self curvatureFraction.
	aMiddle := aFromPosition + (aDirection / 2.0).

	^ (aMiddle + aPerpendicular) asPoint