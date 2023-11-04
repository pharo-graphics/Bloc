Class {
	#name : 'BlFocusFinderReferenceArea',
	#superclass : 'BlFocusFinderReference',
	#instVars : [
		'bounds'
	],
	#category : 'Bloc-FocusFinder-Core',
	#package : 'Bloc-FocusFinder',
	#tag : 'Core'
}

{ #category : 'accessing' }
BlFocusFinderReferenceArea >> bounds [

	^ bounds
]

{ #category : 'accessing' }
BlFocusFinderReferenceArea >> bounds: aRectangle [

	bounds := aRectangle
]

{ #category : 'api - focus' }
BlFocusFinderReferenceArea >> focusBoundsIn: anElement [
	
	^ bounds
]

{ #category : 'api - focus' }
BlFocusFinderReferenceArea >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"

	^ anElement
]

{ #category : 'accessing' }
BlFocusFinderReferenceArea >> name [

	^ 'area'
]
