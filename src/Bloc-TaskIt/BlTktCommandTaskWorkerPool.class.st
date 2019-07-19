Class {
	#name : #BlTktCommandTaskWorkerPool,
	#superclass : #TKTCommonQueueWorkerPool,
	#traits : 'TBlDebug + TBlTktCommandTaskScheduler',
	#classTraits : 'TBlDebug classTrait + TBlTktCommandTaskScheduler classTrait',
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #cleanup }
BlTktCommandTaskWorkerPool class >> cleanUp [
	self resetUniqueInstance
]

{ #category : #current }
BlTktCommandTaskWorkerPool class >> createDefault [
	<return: #BlTktCommandTaskWorkerPool>
	^ self new
		name: self defaultName;
		poolMaxSize: self defaultPoolSize
]

{ #category : #current }
BlTktCommandTaskWorkerPool class >> default [
	^ self uniqueInstance
]

{ #category : #accessing }
BlTktCommandTaskWorkerPool class >> defaultName [
	<return: #BlTktCommandTaskWorkerPool>
	^ self subclassResponsibility
]

{ #category : #accessing }
BlTktCommandTaskWorkerPool class >> defaultPoolSize [
	<return: #Integer>
	^ self subclassResponsibility
]

{ #category : #management }
BlTktCommandTaskWorkerPool class >> initialize [ 
	<script>
	self resetAllSubUniqueInstances.
	self resetUniqueInstance.
]

{ #category : #cleanup }
BlTktCommandTaskWorkerPool class >> resetAllSubUniqueInstances [
	self subclassesDo: #resetUniqueInstance
]

{ #category : #cleanup }
BlTktCommandTaskWorkerPool class >> resetUniqueInstance [
	self stopDefault.
	uniqueInstance := nil.
]

{ #category : #management }
BlTktCommandTaskWorkerPool class >> startDefault [
	<return: #BlTktCommandTaskWorkerPool>
	^ self createDefault start
]

{ #category : #management }
BlTktCommandTaskWorkerPool class >> stopAllSubDefaults [
	<script>
	"Stop the all worker pools"
	self subclassesDo: #stopDefault
]

{ #category : #management }
BlTktCommandTaskWorkerPool class >> stopDefault [
	<script>
	"Stop the default worker pool"
	uniqueInstance ifNotNil: #stop
]

{ #category : #current }
BlTktCommandTaskWorkerPool class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := self startDefault ]
]

{ #category : #schedulling }
BlTktCommandTaskWorkerPool >> future: aTask [
	<return: #TKTFuture>
	^ self withConfigurationDo: [ super future: aTask ].
]

{ #category : #'public - mutexed' }
BlTktCommandTaskWorkerPool >> printOn: aStream [
	name ifNil: [ aStream nextPutAll: 'a '; nextPutAll: self className. ^ self ].
	aStream nextPutAll: name
]

{ #category : #private }
BlTktCommandTaskWorkerPool >> privateNewWorker [
	workers
		add:
			(BlTktCommandTaskWorker new
				name: self name , ' Worker #' , (self size + 1) asString;
				taskQueue: taskQueue;
				start)
]

{ #category : #accessing }
BlTktCommandTaskWorkerPool >> processProvider [
	<return: #TKTTaskItProcessProvider>
	^ self subclassResponsibility
]

{ #category : #schedulling }
BlTktCommandTaskWorkerPool >> schedule: aTask [
	self withConfigurationDo: [ super schedule: aTask ].
]

{ #category : #schedulling }
BlTktCommandTaskWorkerPool >> schedule: aTask timeout: aTimeout [
	self withConfigurationDo: [ super schedule: aTask timeout: aTimeout ].
]

{ #category : #'public - mutexed' }
BlTktCommandTaskWorkerPool >> start [
	"TODO: maybe WatchDog should be at higher priority?"
	self withConfigurationDo: [ super start ].
]

{ #category : #removing }
BlTktCommandTaskWorkerPool >> stopWatchDog [
	dog ifNotNil: [ :aWatchDog | aWatchDog stop ]
]

{ #category : #private }
BlTktCommandTaskWorkerPool >> withConfigurationDo: aBlock [
	^ TKTConfiguration 
		processProvider: self processProvider 
		during: aBlock
]
