"
I represent the cursor used in the space.

There are two general types of a cursor: {{gtClass:BlNamedCursor}} and {{gtClass:BlStaticCursor}}

"
Class {
	#name : #BlCursor,
	#superclass : #Object,
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Space - Cursor'
}

{ #category : #'instance creation' }
BlCursor class >> default [

	^ self new
]

{ #category : #'api - cursor' }
BlCursor >> activateOn: aSpace [
	aSpace updateCursor: self
]

{ #category : #converting }
BlCursor >> asForm [
	^ Cursor normal
]

{ #category : #'api - cursor' }
BlCursor >> deactivateOn: aSpace [
	
]
