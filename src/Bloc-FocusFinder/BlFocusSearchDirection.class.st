"
I represent an abstract direction in which the next focusable element should be searched

"
Class {
	#name : 'BlFocusSearchDirection',
	#superclass : 'Object',
	#category : 'Bloc-FocusFinder-Directions',
	#package : 'Bloc-FocusFinder',
	#tag : 'Directions'
}

{ #category : 'focus' }
BlFocusSearchDirection >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [

	self subclassResponsibility
]

{ #category : 'focus' }
BlFocusSearchDirection >> name [

	^ 'Uknown'
]

{ #category : 'focus' }
BlFocusSearchDirection >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [
	"Return a `BlElement` or nil with the next focus."
	
	^ self subclassResponsibility
]

{ #category : 'geometry' }
BlFocusSearchDirection >> vector [
	"Return a vector that represents a direction of the search"

	^ BlVector x: 0 y: 0
]
