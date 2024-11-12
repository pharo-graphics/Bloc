"
I represent the execution of a space frame phase.
"
Class {
	#name : #BlSpacePhaseEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'end'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpacePhaseEvent >> duration [

	^ end - timestamp
]

{ #category : #accessing }
BlSpacePhaseEvent >> end [

	^ end
]

{ #category : #accessing }
BlSpacePhaseEvent >> end: aDateAndTime [

	end := aDateAndTime
]

{ #category : #printing }
BlSpacePhaseEvent >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: 'timestamp: ';
		print: timestamp;
		nextPutAll: '; duration: ';
		print: self duration;
		nextPut: $)
]

{ #category : #accessing }
BlSpacePhaseEvent >> start [

	^ timestamp
]

{ #category : #accessing }
BlSpacePhaseEvent >> start: aDateAndTime [

	timestamp := aDateAndTime
]
