Class {
	#name : #BlDragSession,
	#superclass : #Object,
	#instVars : [
		'dragRegistry'
	],
	#category : #'Bloc-Utilities - Drag&Drop'
}

{ #category : #'drag and drop' }
BlDragSession >> drag: aDragItemOrItems from: aSourceElement [
	"Add provided drag items (or a single item) with a given element as its source to this drag session"
	
	dragRegistry at: aSourceElement put: aDragItemOrItems asOrderedCollection
]

{ #category : #initialization }
BlDragSession >> initialize [
	super initialize.

	dragRegistry := IdentityDictionary new
]
