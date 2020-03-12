Class {
	#name : #BlFocusFinderReference,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #'api - focus' }
BlFocusFinderReference >> focusBoundsIn: anElement [
	<return: #Rectangle>
	
	^ self subclassResponsibility
]

{ #category : #'api - focus' }
BlFocusFinderReference >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ self subclassResponsibility
]

{ #category : #accessing }
BlFocusFinderReference >> name [
	<return: #String>

	^ 'Uknown'
]
