Class {
	#name : #BlFocusSearchDirectionUp,
	#superclass : #BlFocusSearchDirectionAbsolute,
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #testing }
BlFocusSearchDirectionUp >> beamsOverlap: aBlBounds and: anotherBlBounds [
	<return: #Boolean>
	
	^ anotherBlBounds right >= aBlBounds left
		and: [ anotherBlBounds left <= aBlBounds right ]
]

{ #category : #focus }
BlFocusSearchDirectionUp >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [
	aFocusedBounds
		left: aFocusRootElement width
		top: aFocusRootElement height
		right: aFocusRootElement width
		bottom: aFocusRootElement height
]

{ #category : #testing }
BlFocusSearchDirectionUp >> is: aDestinationBlBounds candidate: aSourceBlBounds [
	"Return if destination bounds are located (at least partially) in direction
	of a given source bounds depending on my direction type, false otherwise"
	<return: #Boolean>

	^ (aSourceBlBounds bottom > aDestinationBlBounds bottom
		or: [ aSourceBlBounds top >= aDestinationBlBounds bottom ])
			and: [ aSourceBlBounds top > aDestinationBlBounds top ]
]

{ #category : #testing }
BlFocusSearchDirectionUp >> is: aDestinationBlBounds inDirection: aSourceBlBounds [
	"In case of up direction destination bounds must be located below the source"
	<return: #Boolean>

	^ aSourceBlBounds top >= aDestinationBlBounds bottom
]

{ #category : #testing }
BlFocusSearchDirectionUp >> isHorizontal [
	"Return true if direction is horizontal, false otherwise"
	<return: #Boolean>
	
	^ false
]

{ #category : #geometry }
BlFocusSearchDirectionUp >> majorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ aSourceBlBounds top - aDestinationBlBounds bottom
]

{ #category : #geometry }
BlFocusSearchDirectionUp >> majorAxisDistanceToFarEdge: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a major axis depending on the type of direction
	from the furthers source bounds' edge to the far edge of the destination bounds"
	<return: #Number>
	
	^ aSourceBlBounds top - aDestinationBlBounds top
]

{ #category : #geometry }
BlFocusSearchDirectionUp >> minorAxisDistance: aDestinationBlBounds and: aSourceBlBounds [
	"Return the distance along a minor axis depending on the type of direction
	from source bounds to the nearest edge of the destination bounds"
	<return: #Number>
	
	^ (((aSourceBlBounds left + aSourceBlBounds width) / 2.0)
		- ((aDestinationBlBounds left + aDestinationBlBounds width) / 2.0)) abs
]

{ #category : #geometry }
BlFocusSearchDirectionUp >> offsetCandidateBounds: aCandidateBounds according: aFocusedBounds [
	"Offsets a given candidate bounds according to provided focused bounds based on direction type"

	aCandidateBounds
		translateX: 0
		Y: aFocusedBounds height + 1
]
