"
I am a {{gtClass:Beacon}} signal.
I am emitted by {{gtClass:BlBeaconLoggingTask}}.
I inform about scheduling and executing of  {{gtClass:BlTask}}.

"
Class {
	#name : 'BlBeaconTaskSignal',
	#superclass : 'BeaconSignal',
	#instVars : [
		'task',
		'callingMethod',
		'message'
	],
	#category : 'Bloc-Space - Tasks',
	#package : 'Bloc',
	#tag : 'Space - Tasks'
}

{ #category : 'instance creation' }
BlBeaconTaskSignal class >> fromSton: stonReader [
	| aSignal |
	aSignal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		aSignal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties);
			callingMethod: (each at: #callingMethod);
			task: (each at: #task);
			message: (each at: #message) ].
	^aSignal
]

{ #category : 'converting' }
BlBeaconTaskSignal >> asDictionary [
	^ super asDictionary 
		at: #callingMethod put: callingMethod;
		at: #task put: task printString;
		at: #message put: message;
		yourself.
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> callingMethod [
	^ callingMethod
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> callingMethod: anObject [
	callingMethod := anObject
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> message [
	^ message
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> message: anObject [
	message := anObject
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> name: aString message: anObject [
	self message: aString asString, ' ', anObject asString
]

{ #category : 'printing' }
BlBeaconTaskSignal >> printOneLineContentsOn: stream [

	message ifNotNil: [ 
		stream 
			<< message;
			<< ': ';
			print: task. 
		^self ].

	task ifNotNil: [ 
		stream
			print: task ]
	
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> task [
	^ task
]

{ #category : 'accessing' }
BlBeaconTaskSignal >> task: anObject [
	task := anObject
]
