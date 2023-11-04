Class {
	#name : 'BlFocusSearchDirectionUp',
	#superclass : 'BlFocusSearchDirectionAbsolute',
	#category : 'Bloc-FocusFinder-Directions',
	#package : 'Bloc-FocusFinder',
	#tag : 'Directions'
}

{ #category : 'testing' }
BlFocusSearchDirectionUp >> beamsOverlap: aBlBounds and: anotherBlBounds [

	^ anotherBlBounds right >= aBlBounds left and: [
		  anotherBlBounds left <= aBlBounds right ]
]

{ #category : 'focus' }
BlFocusSearchDirectionUp >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	aFocusedBounds
		left: aFocusRootElement width
		top: aFocusRootElement height
		right: aFocusRootElement width
		bottom: aFocusRootElement height
]

{ #category : 'testing' }
BlFocusSearchDirectionUp >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise."

	^ (aSourceBlBounds bottom > aDestinationBlBounds bottom
		or: [ aSourceBlBounds top >= aDestinationBlBounds bottom ])
			and: [ aSourceBlBounds top > aDestinationBlBounds top ]
]

{ #category : 'testing' }
BlFocusSearchDirectionUp >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"In case of up direction destination bounds must be located below the source."

	^ aSourceBlBounds top >= aDestinationBlBounds bottom
]

{ #category : 'testing' }
BlFocusSearchDirectionUp >> isHorizontal [
	"Return true if direction is horizontal, false otherwise."
	
	^ false
]

{ #category : 'geometry - major' }
BlFocusSearchDirectionUp >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds."
	
	^ aSourceBlBounds top - aDestinationBlBounds bottom
]

{ #category : 'geometry - major' }
BlFocusSearchDirectionUp >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds."
	
	^ aSourceBlBounds top - aDestinationBlBounds top
]

{ #category : 'geometry - minor' }
BlFocusSearchDirectionUp >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds."
	
	^ (aDestinationBlBounds center x - aSourceBlBounds center x) abs
]

{ #category : 'geometry - minor' }
BlFocusSearchDirectionUp >> minorAxisDistanceToNearEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from the furthers source bounds' edge to the neares edge of the destination bounds."
	
	^ (((aSourceBlBounds left - aDestinationBlBounds left) abs
		min: ((aSourceBlBounds left - aDestinationBlBounds right) abs))
			min: ((aSourceBlBounds right - aDestinationBlBounds left) abs))
				min: ((aSourceBlBounds right - aDestinationBlBounds right) abs)
]

{ #category : 'focus' }
BlFocusSearchDirectionUp >> name [

	^ 'up'
]

{ #category : 'geometry' }
BlFocusSearchDirectionUp >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type."

	aCandidateBounds
		translateX: 0
		Y: aFocusedBounds height + 1
]

{ #category : 'geometry' }
BlFocusSearchDirectionUp >> vector [

	^ BlVector x: 0 y: -1
]
