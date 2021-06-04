"
BlTaskExecutionSignal is used to record the start and end times of tasks that are run in the UI process.  These can then be analysed and tasks that are slow, and thus are significantly impacting the frame rate, identified.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	duration:		<Object>
	task:		<Object>


    Implementation Points

"
Class {
	#name : #BlTaskExecutionSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'task',
		'action'
	],
	#classVars : [
		'Enabled',
		'IgnoredTasks'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #filtering }
BlTaskExecutionSignal class >> clearIgnored [

	IgnoredTasks := nil
]

{ #category : #filtering }
BlTaskExecutionSignal class >> dontIgnoreClass: aBlTask [

	IgnoredTasks ifNil: [ ^self ].
	(IgnoredTasks includes: aBlTask) ifTrue: 
		[ IgnoredTasks := IgnoredTasks copyWithout: aBlTask ].
]

{ #category : #accessing }
BlTaskExecutionSignal class >> enabled [ 

	^Enabled ifNil: [ ^false ]
]

{ #category : #accessing }
BlTaskExecutionSignal class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #'instance creation' }
BlTaskExecutionSignal class >> endTask: aTask [

	^self new 
		task: aTask;
		action: #end;
		emit
]

{ #category : #'instance creation' }
BlTaskExecutionSignal class >> for: aTask block: aBlock [

	self enabled ifFalse: [ ^aBlock value ].
	(IgnoredTasks isNotNil and: [ IgnoredTasks includes: aTask class ]) 
		ifTrue: [ ^aBlock value ].
	self startTask: aTask.
	aBlock value.
	self endTask: aTask.
]

{ #category : #'instance creation' }
BlTaskExecutionSignal class >> fromSton: stonReader [

	| signal |

	signal := self new.
	stonReader parseListDo: [ :each :idx |
		idx = 1 ifFalse: [ self error: 'Invalid STON' ].
		signal
			basicTimestamp: (each at: #timestamp);
			basicProcessId: (each at: #processId);
			basicProperties: (each at: #properties);
			task: (each at: #task);
			action: (each at: #action) ].
	^signal
]

{ #category : #filtering }
BlTaskExecutionSignal class >> ignoreClass: aBlTask [

	IgnoredTasks ifNil: [ IgnoredTasks := #() ].
	(IgnoredTasks includes: aBlTask) ifFalse: 
		[ IgnoredTasks := IgnoredTasks copyWith: aBlTask ].
]

{ #category : #accessing }
BlTaskExecutionSignal class >> ignoreRepeatedTasks [

	BlRepeatedTask withAllSubclasses do: [ :each |
		self ignoreClass: each ].
]

{ #category : #'instance creation' }
BlTaskExecutionSignal class >> startTask: aTask [

	^self new 
		task: aTask;
		action: #start;
		emit
]

{ #category : #accessing }
BlTaskExecutionSignal >> action [
	^ action
]

{ #category : #accessing }
BlTaskExecutionSignal >> action: anObject [
	action := anObject
]

{ #category : #'ston persistence' }
BlTaskExecutionSignal >> asDictionary [

	| taskSton |

	taskSton := String streamContents: [ :stream |
		stream 
			print: task identityHash;
			<< '-';
			print: task ].
	^Dictionary new
		at: #timestamp put: timestamp;
		at: #processId put: processId;
		at: #properties put: properties;
		at: #task put: taskSton;
		at: #action put: action;
		yourself.
]

{ #category : #printing }
BlTaskExecutionSignal >> printOneLineContentsOn: stream [

	stream
		print: action;
		<< ': ';
		print: task.

]

{ #category : #'ston persistence' }
BlTaskExecutionSignal >> stonOn: stonWriter [

	stonWriter writeObject: self streamShortList: [ :array |
		array add: self asDictionary ]
]

{ #category : #accessing }
BlTaskExecutionSignal >> target [
	"Answer the object that is the target of this signal"

	^task
]

{ #category : #accessing }
BlTaskExecutionSignal >> task [
	^ task
]

{ #category : #accessing }
BlTaskExecutionSignal >> task: anObject [
	task := anObject
]
