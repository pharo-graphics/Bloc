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
