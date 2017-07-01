testing
isBetterCandidate: aFirstBlBounds then: aSecondBlBounds in: aSourceBlBounds
	"Return true if first bounds is a better candidate then seconds bounds for focus search
	in this direction from a source bounds, false otherwise"
	<return: #Boolean>
	
	"if first is not even a candidate, second is considered to be better"
	(self is: aFirstBlBounds candidate: aSourceBlBounds)
		ifFalse: [ ^ false ].
	
	"at this point first bounds is a candidate. if secons
	is not a candidate we let first be better"
	(self is: aSecondBlBounds candidate: aSourceBlBounds)
		ifFalse: [ ^ true ].
	
	"first is considered to be better by beams"
	(self beam: aFirstBlBounds beats: aSecondBlBounds in: aSourceBlBounds)
		ifTrue: [ ^ true ].
	
	"second is better by beams"
	(self beam: aSecondBlBounds beats: aFirstBlBounds in: aSourceBlBounds)
		ifTrue: [ ^ false ].
	
	"compare by distance, the smaller distance is better"
	^ (self
		weightedDistance: (self majorAxisDistanceNormalized: aFirstBlBounds and: aSourceBlBounds)
		and: (self minorAxisDistance: aFirstBlBounds and: aSourceBlBounds))
			< (self
				weightedDistance: (self majorAxisDistanceNormalized: aSecondBlBounds and: aSourceBlBounds)
				and: (self minorAxisDistance: aSecondBlBounds and: aSourceBlBounds))