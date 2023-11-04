Class {
	#name : 'BlFocusFinderReferenceElement',
	#superclass : 'BlFocusFinderReference',
	#instVars : [
		'element'
	],
	#category : 'Bloc-FocusFinder-Core',
	#package : 'Bloc-FocusFinder',
	#tag : 'Core'
}

{ #category : 'accessing' }
BlFocusFinderReferenceElement >> element [

	^ element
]

{ #category : 'accessing' }
BlFocusFinderReferenceElement >> element: aBlElement [

	element := aBlElement
]

{ #category : 'api - focus' }
BlFocusFinderReferenceElement >> focusBoundsIn: anElement [
	
	^ (anElement
		localBoundsToMine: (self element focusedBounds: BlBounds new)
		fromChild: self element) asRectangle
]

{ #category : 'api - focus' }
BlFocusFinderReferenceElement >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"

	^ element
]

{ #category : 'accessing' }
BlFocusFinderReferenceElement >> name [

	^ 'element'
]
