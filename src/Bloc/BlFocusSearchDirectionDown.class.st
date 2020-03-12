Class {
	#name : #BlFocusSearchDirectionDown,
	#superclass : #BlFocusSearchDirectionAbsolute,
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #testing }
BlFocusSearchDirectionDown >> beamsOverlap: aBlBounds and: anotherBlBounds [
	<return: #Boolean>
	
	^ anotherBlBounds right >= aBlBounds left
		and: [ anotherBlBounds left <= aBlBounds right ]
]

{ #category : #focus }
BlFocusSearchDirectionDown >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [
	aFocusedBounds
		left: 0
		top: 0
		right: 0
		bottom: 0
]

{ #category : #testing }
BlFocusSearchDirectionDown >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ (aSourceBlBounds top < aDestinationBlBounds top
		or: [ aSourceBlBounds bottom <= aDestinationBlBounds top ])
			and: [ aSourceBlBounds bottom < aDestinationBlBounds bottom ]
]

{ #category : #testing }
BlFocusSearchDirectionDown >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"In case of down direction destination bounds must be located below the source"
	<return: #Boolean>

	^ aSourceBlBounds bottom <= aDestinationBlBounds top
]

{ #category : #testing }
BlFocusSearchDirectionDown >> isHorizontal [
	"Return true if direction is horizontal, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionDown >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ aDestinationBlBounds top - aSourceBlBounds bottom
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionDown >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	<return: #Number>
	
	^ aDestinationBlBounds bottom - aSourceBlBounds bottom
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionDown >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ (aDestinationBlBounds center x - aSourceBlBounds center x) abs
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionDown >> minorAxisDistanceToNearEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from the furthers source bounds' edge to the neares edge of the destination bounds"
	<return: #Number>
	
	^ (((aSourceBlBounds left - aDestinationBlBounds left) abs
		min: ((aSourceBlBounds left - aDestinationBlBounds right) abs))
			min: ((aSourceBlBounds right - aDestinationBlBounds left) abs))
				min: ((aSourceBlBounds right - aDestinationBlBounds right) abs)
]

{ #category : #focus }
BlFocusSearchDirectionDown >> name [
	<return: #String>

	^ 'down'
]

{ #category : #geometry }
BlFocusSearchDirectionDown >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	aCandidateBounds
		translateX: 0
		Y: (aFocusedBounds height + 1) negated
]

{ #category : #geometry }
BlFocusSearchDirectionDown >> vector [
	<return: #BlVector>

	^ BlVector x: 0 y: 1
]
