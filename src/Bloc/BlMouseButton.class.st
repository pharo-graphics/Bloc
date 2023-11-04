"
I identify a mouse button being pressed or released by the user.

I am used by BlMouseEvent

"
Class {
	#name : 'BlMouseButton',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'accessing' }
BlMouseButton class >> code: aNumber [
	^ BlMouseOtherButton code: aNumber
]

{ #category : 'accessing' }
BlMouseButton class >> middle [
	^ BlMouseMiddleButton uniqueInstance
]

{ #category : 'accessing' }
BlMouseButton class >> primary [
	^ BlMousePrimaryButton uniqueInstance
]

{ #category : 'accessing' }
BlMouseButton class >> secondary [
	^ BlMouseSecondaryButton uniqueInstance
]

{ #category : 'event creation' }
BlMouseButton >> clickEventClass [

	^ BlClickEvent 
]

{ #category : 'action dispatching' }
BlMouseButton >> ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock [

	^ anotherBlock value
]

{ #category : 'event creation' }
BlMouseButton >> mouseDownEventClass [

	^ BlMouseDownEvent 
]

{ #category : 'event creation' }
BlMouseButton >> mouseUpEventClass [

	^ BlMouseUpEvent 
]
