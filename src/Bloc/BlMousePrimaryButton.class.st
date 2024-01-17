"
I am a primary mouse button. In most cases is bound to the left button.

"
Class {
	#name : 'BlMousePrimaryButton',
	#superclass : 'BlMouseNamedButton',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'event creation' }
BlMousePrimaryButton >> clickEventClass [

	^ BlPrimaryClickEvent 
]

{ #category : 'action dispatching' }
BlMousePrimaryButton >> ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock [

	^ aPrimBlock value
]

{ #category : 'event creation' }
BlMousePrimaryButton >> mouseDownEventClass [

	^ BlPrimaryMouseDownEvent 
]

{ #category : 'event creation' }
BlMousePrimaryButton >> mouseUpEventClass [

	^ BlPrimaryMouseUpEvent 
]
