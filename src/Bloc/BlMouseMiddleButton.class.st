"
I am a middle mouse button. Often can be triggered by mouse wheel click

"
Class {
	#name : 'BlMouseMiddleButton',
	#superclass : 'BlMouseNamedButton',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'event creation' }
BlMouseMiddleButton >> clickEventClass [

	^ BlMiddleClickEvent 
]

{ #category : 'action dispatching' }
BlMouseMiddleButton >> ifPrimary: aPrimBlock secondary: aSecBlock middle: aMidBlock other: anotherBlock [

	^ aMidBlock value
]

{ #category : 'event creation' }
BlMouseMiddleButton >> mouseDownEventClass [

	^ BlMiddleMouseDownEvent 
]

{ #category : 'event creation' }
BlMouseMiddleButton >> mouseUpEventClass [

	^ BlMiddleMouseUpEvent 
]
