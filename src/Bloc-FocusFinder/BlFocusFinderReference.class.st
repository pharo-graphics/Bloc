Class {
	#name : #BlFocusFinderReference,
	#superclass : #Object,
	#category : #'Bloc-FocusFinder-Core'
}

{ #category : #'api - focus' }
BlFocusFinderReference >> focusBoundsIn: anElement [
	"Answer a Rectangle."
	
	^ self subclassResponsibility
]

{ #category : #'api - focus' }
BlFocusFinderReference >> focusElementIn: anElement [
	"Return a 'current' focused BlElement which should be used a reference"

	^ self subclassResponsibility
]

{ #category : #accessing }
BlFocusFinderReference >> name [

	^ 'Uknown'
]
