"
I identify a mouse button being pressed or released by the user.

I am used by BlMouseEvent

"
Class {
	#name : #BlMouseButton,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'Bloc-Events'
}

{ #category : #accessing }
BlMouseButton class >> code: aNumber [
	^ BlMouseOtherButton code: aNumber
]

{ #category : #accessing }
BlMouseButton class >> middle [
	^ BlMouseMiddleButton uniqueInstance
]

{ #category : #accessing }
BlMouseButton class >> primary [
	^ BlMousePrimaryButton uniqueInstance
]

{ #category : #accessing }
BlMouseButton class >> secondary [
	^ BlMouseSecondaryButton uniqueInstance
]
