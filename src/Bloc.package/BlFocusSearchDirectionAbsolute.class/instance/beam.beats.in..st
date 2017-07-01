testing
beam: aFirstBlBounds beats: aSecondBlBounds in: aSourceBlBounds
	"Return true if first bounds are better then second bounds based on
	wether they are in the beam of source bounds, false otherwise"
	<return: #Boolean>
	| firstInBeam secondInBeam |
	
	firstInBeam := self beamsOverlap: aSourceBlBounds and: aFirstBlBounds.
	secondInBeam := self beamsOverlap: aSourceBlBounds and: aSecondBlBounds.
	
	"Return false if first is not in beam or if second is"
	(secondInBeam or: [ firstInBeam not ])
		ifTrue: [ ^ false ].

	"at this point first is in beam, second is not"
	
	"if second bounds are not in the direction of the source,
	first bounds are better, return true"
	(self is: aSecondBlBounds inDirection: aSourceBlBounds)
		ifFalse: [ ^ true ].

	"In case of horizontal directions bounds in beam are definitely better"
	self isHorizontal
		ifTrue: [ ^ true ].

	"In case of vertical directions we should compare bounds based on distance along major axis"
	^ (self majorAxisDistanceNormalized: aFirstBlBounds and: aSourceBlBounds)
		< (self majorAxisDistanceToFarEdgeNormalized: aSecondBlBounds and: aSourceBlBounds)