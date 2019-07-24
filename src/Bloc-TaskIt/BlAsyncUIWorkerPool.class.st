"
${class:BlAsyncUIWorkerPool}$ is a ${class:TKTCommonQueueWorkerPool}$ that:

- uses a ${class:AtomicSharedPriorityQueue}$ so that tasks are executed by task priority (rather than FIFO).
- runs the workers at low priority so that the UI thread is still responsive (see ${method:BlTKTBackgroundProcessProvider>>#createProcessDoing:named:}$)

Public API and Key Messages

The public API and key messages are the same as for ${class:TKTCommonQueueWorkerPool}$.

"
Class {
	#name : #BlAsyncUIWorkerPool,
	#superclass : #BlVariableSizeWorkerPool,
	#classVars : [
		'UseDefaultRunner'
	],
	#category : #'Bloc-TaskIt-! Obsolete'
}

{ #category : #accessing }
BlAsyncUIWorkerPool class >> defaultName [
	"Return a default worker pool name"
	<return: #String>
	^ 'Async UI'
]

{ #category : #accessing }
BlAsyncUIWorkerPool class >> defaultPoolSize [
	"Return a default worker pool size"
	<return: #Integer>
	^ 4
]

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> future: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^ self useDefaultRunner 
		ifTrue: [ aValuable asLoggingTask schedule ]
		ifFalse: [ super future: aValuable maxPoolSize: maxPoolSize ].
]

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> future: aValuable named: aString maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^ self useDefaultRunner 
		ifTrue: [ aValuable asLoggingTask schedule ]
		ifFalse: [ super future: aValuable named: aString maxPoolSize: maxPoolSize ].
]

{ #category : #'class initialization' }
BlAsyncUIWorkerPool class >> initialize [ 
	<script>

	self stopAll.
	workerPools := Dictionary new.

]

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> schedule: aValuable maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable with maxPoolSize worker pools"

	^ self useDefaultRunner 
		ifTrue: [ aValuable asLoggingTask schedule ]
		ifFalse: [ super schedule: aValuable maxPoolSize: maxPoolSize ].
]

{ #category : #scheduling }
BlAsyncUIWorkerPool class >> schedule: aValuable named: aString maxPoolSize: maxPoolSize [
	"Schedule the supplied valuable named aValuableName with maxPoolSize worker pools"

	^ self useDefaultRunner 
		ifTrue: [ aValuable asLoggingTask schedule ]
		ifFalse: [ super schedule: aValuable named: aString maxPoolSize: maxPoolSize ].

]

{ #category : #debugging }
BlAsyncUIWorkerPool class >> useDefaultRunner [
	"Answer a boolean indicating whether the default (calling priority) runner should be used"

	^UseDefaultRunner ifNil: [ false ]
]

{ #category : #debugging }
BlAsyncUIWorkerPool class >> useDefaultRunner: aBoolean [
	"Set the flag indicating whether to use the default (calling priority) runner"

	UseDefaultRunner := aBoolean 
]

{ #category : #initialization }
BlAsyncUIWorkerPool >> initialize [ 

	super initialize.
	taskQueue := AtomicSharedPriorityQueue new.
]

{ #category : #accessing }
BlAsyncUIWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ BlTKTBackgroundProcessProvider new
]
