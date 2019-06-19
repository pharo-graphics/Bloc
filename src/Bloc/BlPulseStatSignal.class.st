Class {
	#name : #BlPulseStatSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'l2',
		'min',
		'max'
	],
	#classVars : [
		'Index',
		'Times'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlPulseStatSignal class >> duration: aDuration [

	Times at: Index put: aDuration asMilliSeconds.
	Index := Index + 1.
	Index <= self sampleCount ifTrue: [ ^self ].
	self new 
		l2: (Times inject: 0 into: [ :s :v | s + (v <= 2 ifTrue: [1] ifFalse: [0]) ]);
		min: Times min;
		max: Times max;
		emit.
	Index := 1.
]

{ #category : #'instance creation' }
BlPulseStatSignal class >> fromSton: stonReader [

	| signal |

	signal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		signal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties);
			l2: (each at: #l2);
			min: (each at: #min);
			max: (each at: #max) ].
	^signal
]

{ #category : #'class initialization' }
BlPulseStatSignal class >> initialize [ 

	Times := Array new: self sampleCount.
	Index := 1.
]

{ #category : #accessing }
BlPulseStatSignal class >> sampleCount [
	"Answer the number of pulse loops that are summarised in each entry"

	^60
]

{ #category : #'ston persistence' }
BlPulseStatSignal >> asStonDictionary [

	^super asStonDictionary 
		at: #l2 put: l2;
		at: #min put: min;
		at: #max put: max;
		yourself.
]

{ #category : #accessing }
BlPulseStatSignal >> l2 [
	^ l2
]

{ #category : #accessing }
BlPulseStatSignal >> l2: anObject [
	l2 := anObject
]

{ #category : #accessing }
BlPulseStatSignal >> max [
	^ max
]

{ #category : #accessing }
BlPulseStatSignal >> max: anObject [
	max := anObject
]

{ #category : #accessing }
BlPulseStatSignal >> min [
	^ min
]

{ #category : #accessing }
BlPulseStatSignal >> min: anObject [
	min := anObject
]

{ #category : #printing }
BlPulseStatSignal >> printOneLineContentsOn: stream [

	stream
		<< 'l2: ';
		print: l2;
		<< ', min: ';
		print: min;
		<< ', max: ';
		print: max.
]
