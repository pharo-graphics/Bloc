"
I represent an abstract direction in which the next focusable element should be searched
"
Class {
	#name : #BlFocusSearchDirection,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : 'Bloc-Utilities - Focus'
}

{ #category : #focus }
BlFocusSearchDirection >> initFocusedBounds: aFocusedBounds root: aFocusRootElement [
	self subclassResponsibility
]

{ #category : #focus }
BlFocusSearchDirection >> nextFocus: aFocusedElement in: aCollectionOfElements within: aFocusRootElement from: aFocusedBounds finder: aFocusFinder [
	<return: #BlElement>
	
	^ self subclassResponsibility
]
