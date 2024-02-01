"
I am a secondary mouse button. In most cases is bound to the right button and used to invoke a contextual menu

"
Class {
	#name : #BlMouseSecondaryButton,
	#superclass : #BlMouseNamedButton,
	#category : #'Bloc-Events'
}

{ #category : #'event creation' }
BlMouseSecondaryButton >> clickEventClass [

	^ BlSecondaryClickEvent 
]

{ #category : #'action dispatching' }
BlMouseSecondaryButton >> ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock [

	^ aSecBlock value
]

{ #category : #'event creation' }
BlMouseSecondaryButton >> mouseDownEventClass [

	^ BlSecondaryMouseDownEvent 
]

{ #category : #'event creation' }
BlMouseSecondaryButton >> mouseUpEventClass [

	^ BlSecondaryMouseUpEvent 
]
