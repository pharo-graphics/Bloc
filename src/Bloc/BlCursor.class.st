"
I represent the cursor used in my world.
"
Class {
	#name : #BlCursor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Space'
}

{ #category : #'as yet unclassified' }
BlCursor class >> default [
	^ BlStaticCursor new image: Cursor normal
]

{ #category : #constants }
BlCursor class >> overEditableText [ 
	^ BlStaticCursor new image: Cursor overEditableText 
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeBottom [
	^ BlStaticCursor new image: Cursor resizeBottom
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeBottomLeft [
	^ BlStaticCursor new image: Cursor resizeBottomLeft
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeBottomRight [
	^ BlStaticCursor new image: Cursor resizeBottomRight
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeLeft [
	^ BlStaticCursor new image: Cursor resizeLeft
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeRight [
	^ BlStaticCursor new image: Cursor resizeRight
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeTop [
	^ BlStaticCursor new image: Cursor resizeTop
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeTopLeft [
	^ BlStaticCursor new image: Cursor resizeTopLeft
]

{ #category : #'as yet unclassified' }
BlCursor class >> resizeTopRight [
	^ BlStaticCursor new image: Cursor resizeTopRight
]

{ #category : #'as yet unclassified' }
BlCursor class >> wait [
	^ BlStaticCursor new image: Cursor wait
]

{ #category : #'as yet unclassified' }
BlCursor >> activateOn: aSpace [
	
]

{ #category : #'as yet unclassified' }
BlCursor >> deactivateOn: aSpace [
	
]
