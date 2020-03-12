Class {
	#name : #BlFocusFinderReferenceElement,
	#superclass : #BlFocusFinderReference,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'element'
	],
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #accessing }
BlFocusFinderReferenceElement >> element [
	^ element
]

{ #category : #accessing }
BlFocusFinderReferenceElement >> element: anObject [
	element := anObject
]

{ #category : #'api - focus' }
BlFocusFinderReferenceElement >> focusBoundsIn: anElement [
	<return: #Rectangle>
	
	^ (anElement
		localBoundsToMine: (self element focusedBounds: BlBounds new)
		fromChild: self element) asRectangle
]

{ #category : #'api - focus' }
BlFocusFinderReferenceElement >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ self element
]

{ #category : #accessing }
BlFocusFinderReferenceElement >> name [
	<return: #String>

	^ 'element'
]
