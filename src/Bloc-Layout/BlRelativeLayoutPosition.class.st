Class {
	#name : 'BlRelativeLayoutPosition',
	#superclass : 'Object',
	#category : 'Bloc-Layout-Relative',
	#package : 'Bloc-Layout',
	#tag : 'Relative'
}

{ #category : 'testing' }
BlRelativeLayoutPosition >> isUndefined [
	^ false
]

{ #category : 'translation' }
BlRelativeLayoutPosition >> translationOf: aBounds relativeTo: anAnchorBounds [
	^ 0@0
]
