Class {
	#name : #BlFocusFinderReferenceArea,
	#superclass : #BlFocusFinderReference,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'bounds'
	],
	#category : #'Bloc-Utilities - Focus'
}

{ #category : #accessing }
BlFocusFinderReferenceArea >> bounds [
	^ bounds
]

{ #category : #accessing }
BlFocusFinderReferenceArea >> bounds: anObject [
	bounds := anObject
]

{ #category : #'api - focus' }
BlFocusFinderReferenceArea >> focusBoundsIn: anElement [
	<return: #Rectangle>
	
	^ self bounds
]

{ #category : #'api - focus' }
BlFocusFinderReferenceArea >> focusElementIn: anElement [
	"Return a 'current' focused element which should be used a reference"
	<return: #BlElement>

	^ anElement
]

{ #category : #accessing }
BlFocusFinderReferenceArea >> name [
	<return: #String>

	^ 'area'
]
