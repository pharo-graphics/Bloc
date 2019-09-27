Class {
	#name : #BlFocusSearchDirectionAbsolute,
	#superclass : #BlFocusSearchDirection,
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> beam: aFirstBlBounds beats: aSecondBlBounds in: aSourceBlBounds [
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
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> beamsOverlap: aBlBounds and: anotherBlBounds [
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"Return true if aDestinationBlBounds is located in direction of a provided source bounds
	according to my destination type, false otherwise"
	<return: #Boolean>

	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> isBetterCandidate: aFirstBlBounds then: aSecondBlBounds in: aSourceBlBounds [
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
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> isHorizontal [
	"Return true if direction is horizontal, false otherwise"
	<return: #Boolean>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceNormalized: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds
	or 0 if destination is not in the direction of a source"
	<return: #Number>
	
	^ 0 max: (self majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds)
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceToFarEdgeNormalized: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds
	or 1 if destination is not in the direction of a source.
	Note: we return 1 in order to prevent conflicts with #majorAxisDistanceNormalized:and:"
	<return: #Number>
	
	^ 1 max: (self majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds)
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ self subclassResponsibility
]

{ #category : #focus }
BlFocusSearchDirectionAbsolute >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [
	<return: #BlElement or: nil>
	| bestCandidateBounds tempBounds closestElement |
	
	bestCandidateBounds := aFocusFinder bestCandidateBounds.
	tempBounds := aFocusFinder temporaryBounds.
	
	bestCandidateBounds bounds: aFocusedBounds.
	self offsetCandidateBounds: bestCandidateBounds according: aFocusedBounds.
	
	closestElement := nil.
	
	aCollectionOfElements do: [ :anElement |
		"we are only interested in elements that are not root or given focused element"
		(anElement == aFocusedElement or: [ anElement == aFocusRootElement ])
			ifFalse: [
				anElement focusedBounds: tempBounds.
				aFocusRootElement localBoundsToMine: tempBounds fromChild: anElement.
				
				(self isBetterCandidate: tempBounds then: bestCandidateBounds in: aFocusedBounds)
					ifTrue: [ 
						bestCandidateBounds bounds: tempBounds.
						closestElement := anElement ] ] ].
			
	^ closestElement
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	self subclassResponsibility
]

{ #category : #geometry }
BlFocusSearchDirectionAbsolute >> weightedDistance: aMajorAxisDistance and: aMinorAxisDistance [
	"Compute and return a resulting weighted final distance according to
	the distance along major and minor axes.
	Note: In order to make major axis to have more influence on the final result
	we introduce a so called 'fudge-factor' to get fine tuned results
	https://en.wikipedia.org/wiki/Fudge_factor"
	<return: #Number>
	
	^ (13 * aMajorAxisDistance * aMajorAxisDistance) + (aMinorAxisDistance * aMinorAxisDistance)
]
