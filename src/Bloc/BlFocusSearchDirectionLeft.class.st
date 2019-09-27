Class {
	#name : #BlFocusSearchDirectionLeft,
	#superclass : #BlFocusSearchDirectionAbsolute,
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #testing }
BlFocusSearchDirectionLeft >> beamsOverlap: aBlBounds and: anotherBlBounds [
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
	<return: #Boolean>

	^ anotherBlBounds bottom >= aBlBounds top
		and: [ anotherBlBounds top <= aBlBounds bottom ]
]

{ #category : #focus }
BlFocusSearchDirectionLeft >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [
	aFocusedBounds
		left: aFocusRootElement width
		top: aFocusRootElement height
		right: aFocusRootElement width
		bottom: aFocusRootElement height
]

{ #category : #testing }
BlFocusSearchDirectionLeft >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ (aSourceBlBounds right > aDestinationBlBounds right
		or: [ aSourceBlBounds left >= aDestinationBlBounds right ])
			and: [ aSourceBlBounds left > aDestinationBlBounds left ]
]

{ #category : #testing }
BlFocusSearchDirectionLeft >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"In case of left direction destination bounds must be located to left from source"
	<return: #Boolean>

	^ aSourceBlBounds left >= aDestinationBlBounds right
]

{ #category : #testing }
BlFocusSearchDirectionLeft >> isHorizontal [
	"Return true if direction is horizontal, false otherwise"
	<return: #Boolean>
	
	^ true
]

{ #category : #geometry }
BlFocusSearchDirectionLeft >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ aSourceBlBounds left - aDestinationBlBounds right
]

{ #category : #geometry }
BlFocusSearchDirectionLeft >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	<return: #Number>
	
	^ aSourceBlBounds left - aDestinationBlBounds left
]

{ #category : #geometry }
BlFocusSearchDirectionLeft >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ (((aSourceBlBounds top + aSourceBlBounds height) / 2.0)
		- ((aDestinationBlBounds top + aDestinationBlBounds height) / 2.0)) abs
]

{ #category : #geometry }
BlFocusSearchDirectionLeft >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	aCandidateBounds
		translateX: aFocusedBounds width + 1
		Y: 0
]
