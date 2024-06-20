"
I handle errors happened during rendering phase.

To not completely break the UI thread we should catch the error and prevent the element from further rendering

"
Class {
	#name : #BlDrawingErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlDrawingErrorHandler >> matches: aFramePhase [
	^ aFramePhase isDrawingPhase
]

{ #category : #'error handling' }
BlDrawingErrorHandler >> processError: aHandledError [

	aHandledError element addChild:
		(BlElement new
			size: 100 @ 40;
			id: #error;
			geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			border: (BlBorder paint: Color gray width: 1);
			background: Color red;
			addEventHandlerOn: BlClickEvent
				do: [ :anEvent |
					anEvent consume.
					aHandledError error debug ];
			yourself)
]
