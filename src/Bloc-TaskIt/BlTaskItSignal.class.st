Class {
	#name : #BlTaskItSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'callingMethod',
		'valuable',
		'message'
	],
	#category : #'Bloc-TaskIt-Beacon'
}

{ #category : #'instance creation' }
BlTaskItSignal class >> emit [ 

	^self new
		callingMethod: thisContext sender method asRingDefinition;
		emit
]

{ #category : #'instance creation' }
BlTaskItSignal class >> emitMessage: aString [

	^self new
		message: aString;
		callingMethod: thisContext sender method asRingDefinition;
		emit
]

{ #category : #'instance creation' }
BlTaskItSignal class >> emitValuable: aValuable [

	^self new
		valuable: aValuable;
		callingMethod: thisContext sender method asRingDefinition;
		emit
]

{ #category : #'instance creation' }
BlTaskItSignal class >> emitValuable: aValuable message: aString [

	^self new
		valuable: aValuable;
		message: aString;
		callingMethod: thisContext sender method asRingDefinition;
		emit
]

{ #category : #'instance creation' }
BlTaskItSignal class >> emitValuable: aValuable message: aString callingMethod: aMethod [

	^self new
		valuable: aValuable;
		message: aString;
		callingMethod: aMethod;
		emit
]

{ #category : #'instance creation' }
BlTaskItSignal class >> fromSton: stonReader [

	| signal |

	signal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		signal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties);
			callingMethod: (each at: #callingMethod);
			valuable: (each at: #valuable);
			message: (each at: #message) ].
	^signal
]

{ #category : #'ston persistence' }
BlTaskItSignal >> asStonDictionary [

	^super asStonDictionary 
		at: #callingMethod put: callingMethod;
		at: #valuable put: valuable printString;
		at: #message put: message;
		yourself.
]

{ #category : #accessing }
BlTaskItSignal >> callingMethod [
	^ callingMethod
]

{ #category : #accessing }
BlTaskItSignal >> callingMethod: anObject [
	callingMethod := anObject
]

{ #category : #accessing }
BlTaskItSignal >> message [
	^ message
]

{ #category : #accessing }
BlTaskItSignal >> message: anObject [
	message := anObject
]

{ #category : #printing }
BlTaskItSignal >> printOneLineContentsOn: stream [

	message ifNotNil: [ 
		stream 
			<< message;
			<< ': ';
			print: valuable. 
		^self ].

	valuable ifNotNil: [ 
		stream
			print: valuable ]
	
]

{ #category : #accessing }
BlTaskItSignal >> valuable [
	^ valuable
]

{ #category : #accessing }
BlTaskItSignal >> valuable: anObject [
	valuable := anObject
]
