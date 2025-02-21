"
I represent the execution of a space frame phase.
"
Class {
	#name : #BlSpacePhaseEvent,
	#superclass : #BlSpaceEvent,
	#instVars : [
		'end',
		'endInMicroseconds'
	],
	#category : #'Bloc-Events-Type-Space'
}

{ #category : #accessing }
BlSpacePhaseEvent >> duration [

	^ Duration microSeconds: (endInMicroseconds - timestampInMicroseconds)
]

{ #category : #accessing }
BlSpacePhaseEvent >> end [

	^ end ifNil: [ end := DateAndTime fromUTCMicrosecondClockValue: endInMicroseconds ]
]

{ #category : #printing }
BlSpacePhaseEvent >> printOn: aStream [

	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: 'timestamp: ';
		print: self timestamp;
		nextPutAll: '; duration: ';
		print: self duration;
		nextPut: $)
]

{ #category : #accessing }
BlSpacePhaseEvent >> start [

	^ self timestamp 
]

{ #category : #accessing }
BlSpacePhaseEvent >> startMicroseconds: aStartInMicro endMicroseconds: anEndInMicro [

	timestampInMicroseconds := aStartInMicro.
	timestamp := nil.
	end := nil.
	endInMicroseconds := anEndInMicro
]
