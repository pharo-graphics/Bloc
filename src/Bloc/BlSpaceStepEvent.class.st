"
I represent the execution of a space frame phase.
"
Class {
	#name : #BlSpaceStepEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'end'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpaceStepEvent >> duration [

	^ end - timestamp
]

{ #category : #accessing }
BlSpaceStepEvent >> end [

	^ end
]

{ #category : #accessing }
BlSpaceStepEvent >> end: aDateAndTime [

	end := aDateAndTime
]

{ #category : #printing }
BlSpaceStepEvent >> printOn: aStream [

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
BlSpaceStepEvent >> start [

	^ timestamp
]

{ #category : #accessing }
BlSpaceStepEvent >> start: aDateAndTime [

	timestamp := aDateAndTime
]
