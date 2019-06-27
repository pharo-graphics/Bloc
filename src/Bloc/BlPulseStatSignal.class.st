"
BlPulseStatSignal records some basic statistics about the Bloc main loop and is emitted each time a pulse is fired.  See ${class:name=BlPulseLoop} for more details and ${method:name=BlPulseLoop>>#wait} for a description of milliSecs.

sampleCount is the number of pulses fired.

l2 is the number of times milliSecs <= 2.

min is the minimum value of millliSecs in the sample set.

max is the maximum value of milliSecs in the sample set.


!!Internal Representation and Key Implementation Points.

!!!Instance Variables
	l2:						<Integer>
	lowPriorityDelayCount:		<Integer>
	max:					<Integer>
	min:		<Integer>
	sampleCount:		<Integer>

"
Class {
	#name : #BlPulseStatSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'l2',
		'min',
		'max',
		'lowPriorityDelayCount',
		'sampleCount'
	],
	#classVars : [
		'CurrentSignal'
	],
	#category : #'Bloc-Universe'
}

{ #category : #accessing }
BlPulseStatSignal class >> duration: aDuration delayForced: aBoolean [

	| currentSignal |
	
	currentSignal := CurrentSignal ifNil: [ CurrentSignal := self new ].
	currentSignal addSampleDuration: aDuration delayForced: aBoolean.
	currentSignal sampleCount < self sampleCount ifTrue: [ ^self ].
	currentSignal emit.
	CurrentSignal := nil.

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

{ #category : #accessing }
BlPulseStatSignal class >> sampleCount [
	"Answer the number of pulse loops that are summarised in each entry"

	^60
]

{ #category : #accessing }
BlPulseStatSignal >> addSampleDuration: aDuraction delayForced: aBoolean [

	| milliSeconds |

	milliSeconds := aDuraction asMilliSeconds.
	sampleCount := sampleCount + 1.
	milliSeconds <= 2 ifTrue: [ l2 := l2 + 1 ].
	min := min min: milliSeconds.
	max := max max: milliSeconds.
	aBoolean ifTrue: [ lowPriorityDelayCount := lowPriorityDelayCount + 1 ].
]

{ #category : #'ston persistence' }
BlPulseStatSignal >> asStonDictionary [

	^super asStonDictionary 
		at: #l2 put: l2;
		at: #min put: min;
		at: #max put: max;
		yourself.
]

{ #category : #initialization }
BlPulseStatSignal >> initialize [ 

	super initialize.
	l2 := 0.
	min := SmallInteger maxVal.
	max := SmallInteger minVal.
	lowPriorityDelayCount := 0.
	sampleCount := 0.
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
BlPulseStatSignal >> lowPriorityDelayCount [
	^ lowPriorityDelayCount
]

{ #category : #accessing }
BlPulseStatSignal >> lowPriorityDelayCount: anObject [
	lowPriorityDelayCount := anObject
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
		print: max;
		<< ', forced: ';
		print: lowPriorityDelayCount;
		<< ', count: ';
		print: sampleCount.
]

{ #category : #accessing }
BlPulseStatSignal >> sampleCount [
	^ sampleCount
]

{ #category : #accessing }
BlPulseStatSignal >> sampleCount: anObject [
	sampleCount := anObject
]
