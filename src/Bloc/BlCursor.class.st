"
I represent the cursor used in the space.

There are two general types of a cursor: ${class:BlNamedCursor} and ${class:BlStaticCursor}
"
Class {
	#name : #BlCursor,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Space-Cursor'
}

{ #category : #'instance creation' }
BlCursor class >> default [
	^ BlDefaultCursor new
]

{ #category : #'instance creation' }
BlCursor class >> overEditableText [ 
	^ BlTextCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeBottom [
	^ BlResizeBottomCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeBottomLeft [
	^ BlResizeBottomLeftCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeBottomRight [
	^ BlResizeBottomRightCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeLeft [
	^ BlResizeLeftCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeRight [
	^ BlResizeRightCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeTop [
	^ BlResizeTopCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeTopLeft [
	^ BlResizeTopLeftCursor new
]

{ #category : #'instance creation' }
BlCursor class >> resizeTopRight [
	^ BlResizeTopRightCursor new
]

{ #category : #'instance creation' }
BlCursor class >> wait [
	^ BlWaitCursor new
]

{ #category : #'api - cursor' }
BlCursor >> activateOn: aSpace [
	aSpace updateCursor: self
]

{ #category : #converting }
BlCursor >> asForm [
	^ self subclassResponsibility
]

{ #category : #'api - cursor' }
BlCursor >> deactivateOn: aSpace [
	
]
