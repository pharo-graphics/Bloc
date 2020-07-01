Class {
	#name : #BlTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'id'
	],
	#classVars : [
		'UniqueIdGenerator'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'class initialization' }
BlTask class >> initialize [
	UniqueIdGenerator := BlUniqueIdGenerator new
]

{ #category : #converting }
BlTask >> asBeaconLoggingTask [
	^ BlBeaconLoggingTask subtask: self
]

{ #category : #accessing }
BlTask >> id [
	"Return a unique id of this task"
	<return: #Number>

	^ id
]

{ #category : #initialization }
BlTask >> initialize [
	super initialize.
	
	id := UniqueIdGenerator generateUniqueId
]

{ #category : #hooks }
BlTask >> onEnqueued: aBlSpace [
	"Is self when a task is enqueued in a space.
	It gives subclasses a possibility to synchronize time with the space"
]

{ #category : #hooks }
BlTask >> onEnqueuedInElement: aBlElement [
	"Is sent when a task is enqueued in a element.
	It gives subclasses a possibility to re-enqueue themselves in the same element"
]

{ #category : #'api - running' }
BlTask >> run [
	self subclassResponsibility
]

{ #category : #'api - running' }
BlTask >> value [
	"To support defer:"
	self run
]
