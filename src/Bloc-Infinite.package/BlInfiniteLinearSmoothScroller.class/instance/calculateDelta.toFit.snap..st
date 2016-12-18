physics
calculateDelta: aViewSize toFit: aBoxSize snap: aSnapPreference
	<return: #Number>
	"view start = aViewSize x
	view end = aViewSize y
	box start = aBoxSize x
	box end = aBoxSize y"

	aSnapPreference = SnapToStart
		ifTrue: [ ^ aBoxSize x - aViewSize x ].
	
	aSnapPreference = SnapToEnd
		ifTrue: [ ^ aBoxSize y - aViewSize y ].
	
	
	aSnapPreference = SnapToAny
		ifTrue: [ 
			| aDeltaStart aDeltaEnd |
			aDeltaStart := aBoxSize x - aViewSize x.
			aDeltaStart > 0
				ifTrue: [ ^ aDeltaStart ].
			aDeltaEnd := aBoxSize y - aViewSize y.
			aDeltaEnd < 0
				ifTrue: [ ^ aDeltaEnd ].
			^ 0 ].
	
	self error: 'Unknown snap preference: ', aSnapPreference asString.