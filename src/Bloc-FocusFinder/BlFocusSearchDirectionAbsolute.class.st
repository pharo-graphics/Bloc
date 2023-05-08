Class {
	#name : #BlFocusSearchDirectionAbsolute,
	#superclass : #BlFocusSearchDirection,
	#category : #'Bloc-FocusFinder-Directions'
}

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> beam: aFirstBlBounds beats: aSecondBlBounds in: aSourceBlBounds [
	"Return true if first bounds are better then second bounds based on
	wether they are in the beam of source bounds, false otherwise."

	| firstInBeam secondInBeam aFirstDistance aSecondDistance |

	firstInBeam := self beamsOverlap: aSourceBlBounds and: aFirstBlBounds.
	secondInBeam := self beamsOverlap: aSourceBlBounds and: aSecondBlBounds.
	
	(firstInBeam and: [ secondInBeam ])
		ifFalse: [
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
				ifTrue: [ ^ true ] ].
			
	aFirstDistance := self majorAxisDistanceNormalized: aFirstBlBounds and: aSourceBlBounds.
	aSecondDistance := self majorAxisDistanceNormalized: aSecondBlBounds and: aSourceBlBounds.
	
	(firstInBeam and: [ secondInBeam not ])
		ifTrue: [ ^ aFirstDistance <= aSecondDistance ].

	"In case of vertical directions we should compare bounds based on distance along major axis"
	^ aFirstDistance < aSecondDistance
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> beamsOverlap: aBlBounds and: anotherBlBounds [
	
	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise."

	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"Return true if aDestinationBlBounds is located in direction of a provided source bounds
	according to my destination type, false otherwise."

	^ self subclassResponsibility
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> isBetterCandidate: aFirstBlBounds then: aSecondBlBounds in: aSourceBlBounds [
	"Return true if first bounds is a better candidate then seconds bounds for focus search
	in this direction from a source bounds, false otherwise."

	| aFirstMajorDistance aSecondMajorDistance isMajorSmaller isWeightedSmaller nearest |
	
	self flag: 'Complicated solution...'.
	
	"Transcript show: 'isBetterCandidate: ', aFirstBlBounds asString, ' THAN: ', aSecondBlBounds asString, ' IN: ', aSourceBlBounds asString; cr.	"
	"if first is not even a candidate, second is considered to be better"
	(self is: aFirstBlBounds candidate: aSourceBlBounds)
		ifFalse: [ "Transcript show: '	first not candidate'; cr." ^ false ].
		


	"at this point first bounds is a candidate. if secons
	is not a candidate we let first be better"
	(self is: aSecondBlBounds candidate: aSourceBlBounds)
		ifFalse: [" Transcript show: '	second not candidate'; cr." ^ true ].
		

	
	"first is considered to be better by beams"
	(self beam: aFirstBlBounds beats: aSecondBlBounds in: aSourceBlBounds)
		ifTrue: [ "Transcript show: '	first beam best'; cr." ^ true ].


	
	"second is better by beams"
	(self beam: aSecondBlBounds beats: aFirstBlBounds in: aSourceBlBounds)
		ifTrue: [ "Transcript show: '	second beam best'; cr."  ^ false ].

	aFirstMajorDistance := self majorAxisDistanceNormalized: aFirstBlBounds and: aSourceBlBounds.
	aSecondMajorDistance := self majorAxisDistanceNormalized: aSecondBlBounds and: aSourceBlBounds.
	
	isMajorSmaller := aFirstMajorDistance < aSecondMajorDistance.
	
	self flag: 'Directly return here, seem ok at least in Album. avoid using weighted distance which does not work in Album'.
	true ifTrue: [^ isMajorSmaller].
	
	"Transcript show: '	isMajorSmaller ', isMajorSmaller asString; cr. "
	
	isWeightedSmaller := (self
		weightedDistance: aFirstMajorDistance
		and: (self minorAxisDistance: aFirstBlBounds and: aSourceBlBounds))
			< (self
				weightedDistance: aSecondMajorDistance
				and: (self minorAxisDistance: aSecondBlBounds and: aSourceBlBounds)).

	"Transcript show: '	isWeightedSmaller ', isMajorSmaller asString; cr. "
	
	"if major comparison is in sync with weighted we trust the value"
	isMajorSmaller = isWeightedSmaller
		ifTrue: [" Transcript show: '	truested ', isMajorSmaller asString; cr.  "^ isMajorSmaller ].
	
	"otherwise we use nearest edge comparison"
	
	"Transcript show: '	aFirstMajorDistance ', aFirstMajorDistance asString, ' aFirstBlBounds ', aFirstBlBounds asString, ' aSecondBlBounds ', aSecondBlBounds asString, ' aSourceBlBounds ', aSourceBlBounds asString; cr."
	nearest :=  (self
		weightedDistance: aFirstMajorDistance
		and: (self minorAxisDistanceToNearEdge: aFirstBlBounds and: aSourceBlBounds))
			< (self
				weightedDistance: aSecondMajorDistance
				and: (self minorAxisDistanceToNearEdge: aSecondBlBounds and: aSourceBlBounds)).
				
	 "Transcript show: '	nearest ', nearest asString; cr."
		
	 ^ nearest
]

{ #category : #testing }
BlFocusSearchDirectionAbsolute >> isHorizontal [
	"Return true if direction is horizontal, false otherwise."
	
	^ self subclassResponsibility
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionAbsolute >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds."
	
	^ self subclassResponsibility
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceNormalized: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds
	or 0 if destination is not in the direction of a source."
	
	^ 0 max: (self majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds)
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	
	^ self subclassResponsibility
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionAbsolute >> majorAxisDistanceToFarEdgeNormalized: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds
	or 1 if destination is not in the direction of a source.
	Note: we return 1 in order to prevent conflicts with #majorAxisDistanceNormalized:and:"
	
	^ 1 max: (self majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds)
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionAbsolute >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds."
	
	^ self subclassResponsibility
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionAbsolute >> minorAxisDistanceToNearEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from the furthers source bounds' edge to the neares edge of the destination bounds."
	
	^ self subclassResponsibility
]

{ #category : #focus }
BlFocusSearchDirectionAbsolute >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [

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

	self flag: 'Why 13 ??? '.
	self flag: 'wikipedia: A fudge factor is an ad hoc quantity or element introduced into a calculation, formula or model in order to make it fit observations or expectations. Also known as a "Correction Coefficient". '.
	self flag: 'Is that really reasonable here ?'.
	^ (13 * aMajorAxisDistance * aMajorAxisDistance) + (aMinorAxisDistance * aMinorAxisDistance)
]
