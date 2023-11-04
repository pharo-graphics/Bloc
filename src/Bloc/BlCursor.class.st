"
I represent the cursor used in the space.

There are two general types of a cursor: {{gtClass:BlNamedCursor}} and {{gtClass:BlStaticCursor}}

"
Class {
	#name : 'BlCursor',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#package : 'Bloc',
	#tag : 'Space - Cursor'
}

{ #category : 'instance creation' }
BlCursor class >> crosshair [
	^ BlCrosshairCursor new
]

{ #category : 'instance creation' }
BlCursor class >> default [
	^ BlDefaultCursor new
]

{ #category : 'instance creation' }
BlCursor class >> hand [

	^ BlHandCursor new
]

{ #category : 'instance creation' }
BlCursor class >> overEditableText [ 
	^ BlTextCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeBottom [
	^ BlResizeBottomCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeBottomLeft [
	^ BlResizeBottomLeftCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeBottomRight [
	^ BlResizeBottomRightCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeLeft [
	^ BlResizeLeftCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeRight [
	^ BlResizeRightCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeTop [
	^ BlResizeTopCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeTopLeft [
	^ BlResizeTopLeftCursor new
]

{ #category : 'instance creation' }
BlCursor class >> resizeTopRight [
	^ BlResizeTopRightCursor new
]

{ #category : 'instance creation' }
BlCursor class >> wait [
	^ BlWaitCursor new
]

{ #category : 'instance creation' }
BlCursor class >> zoomIn [
	^ BlZoomInCursor new
]

{ #category : 'instance creation' }
BlCursor class >> zoomOut [
	^ BlZoomOutCursor new
]

{ #category : 'api - cursor' }
BlCursor >> activateOn: aSpace [
	aSpace updateCursor: self
]

{ #category : 'converting' }
BlCursor >> asForm [
	^ self subclassResponsibility
]

{ #category : 'api - cursor' }
BlCursor >> deactivateOn: aSpace [
	
]
