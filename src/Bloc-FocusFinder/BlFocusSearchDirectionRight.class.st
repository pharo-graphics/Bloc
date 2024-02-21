Class {
	#name : #BlFocusSearchDirectionRight,
	#superclass : #BlFocusSearchDirectionAbsolute,
	#category : #'Bloc-FocusFinder-Directions'
}

{ #category : #testing }
BlFocusSearchDirectionRight >> beamsOverlap: aBlBounds and: anotherBlBounds [
	"
	Beams overlap:
	
	|------------|. . . . . . . . . . . . . . . . . . . . .   (
	|            |
	|  (first)   |...........|---------------|.............   [
	|            |           |               |              
	|____________|. . . . . .|   (another)   |. . . . . . .   )
	                         |               |
	.........................|_______________|.............   ]


	Don't overlap:

   |------------|. . . . . . . . . . . . . . . . . . . . .   (
	|            |
	|  (first)   |
	|            |
	|____________|. . . . . . . . . . . . . . . . . . . . .   )

	
	.........................|---------------|.............   [
	                         |               |              
	                         |   (another)   |
	                         |               |
	.........................|_______________|.............   ]
"

	^ anotherBlBounds bottom >= aBlBounds top
		and: [ anotherBlBounds top <= aBlBounds bottom ]
]

{ #category : #focus }
BlFocusSearchDirectionRight >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	aFocusedBounds
		left: 0
		top: 0
		right: 0
		bottom: 0
]

{ #category : #testing }
BlFocusSearchDirectionRight >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise."

	^ (aSourceBlBounds left < aDestinationBlBounds left
		or: [ aSourceBlBounds right <= aDestinationBlBounds left ])
			and: [ aSourceBlBounds right < aDestinationBlBounds right ]
]

{ #category : #testing }
BlFocusSearchDirectionRight >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"In case of right direction destination bounds must be located to right from source."

	^ aSourceBlBounds right <= aDestinationBlBounds left
]

{ #category : #testing }
BlFocusSearchDirectionRight >> isHorizontal [
	"Return true if direction is horizontal, false otherwise."
	
	^ true
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionRight >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds."
	
	^ aDestinationBlBounds left - aSourceBlBounds right
]

{ #category : #'geometry - major' }
BlFocusSearchDirectionRight >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds."
	
	^ aDestinationBlBounds right - aSourceBlBounds right
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionRight >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds."
	
	^ (aDestinationBlBounds center y - aSourceBlBounds center y) abs
]

{ #category : #'geometry - minor' }
BlFocusSearchDirectionRight >> minorAxisDistanceToNearEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from the furthers source bounds' edge to the neares edge of the destination bounds."
	
	^ (((aSourceBlBounds top - aDestinationBlBounds top) abs
		min: ((aSourceBlBounds top - aDestinationBlBounds bottom) abs))
			min: ((aSourceBlBounds bottom - aDestinationBlBounds top) abs))
				min: ((aSourceBlBounds bottom - aDestinationBlBounds bottom) abs)
]

{ #category : #focus }
BlFocusSearchDirectionRight >> name [

	^ 'right'
]

{ #category : #geometry }
BlFocusSearchDirectionRight >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type."

	aCandidateBounds
		translateX: (aFocusedBounds width + 1) negated
		Y: 0
]

{ #category : #geometry }
BlFocusSearchDirectionRight >> vector [

	^ BlVector x: 1 y: 0
]
