Class {
	#name : 'BlTelemetryTask',
	#superclass : 'Object',
	#instVars : [
		'startTime',
		'endTime',
		'realStartTime',
		'realEndTime',
		'gcStartTime',
		'gcEndTime',
		'name',
		'tasks'
	],
	#package : 'Bloc',
	#tag : 'Space - Telemetry'
}

{ #category : 'adding' }
BlTelemetryTask >> addTask: aTelemetryTask [
	tasks add: aTelemetryTask
]

{ #category : 'accessing' }
BlTelemetryTask >> childrenOverhead [
	^ self tasks
		inject: 0
		into: [ :aSum :eachTask | aSum + eachTask totalOverhead ]
]

{ #category : 'accessing' }
BlTelemetryTask >> duration [
	^ self endTime - self startTime - self childrenOverhead
]

{ #category : 'printing' }
BlTelemetryTask >> durationInMilliseconds [
	^ self duration / 1000.0
]

{ #category : 'accessing' }
BlTelemetryTask >> endTime [
	^ endTime
]

{ #category : 'accessing' }
BlTelemetryTask >> endTime: anObject [
	endTime := anObject
]

{ #category : 'accessing' }
BlTelemetryTask >> gcDurationInMilliseconds [
	^ (self gcEndTime - self gcStartTime)
]

{ #category : 'accessing' }
BlTelemetryTask >> gcEndTime [
	^ gcEndTime
]

{ #category : 'accessing' }
BlTelemetryTask >> gcEndTime: anObject [
	gcEndTime := anObject
]

{ #category : 'accessing' }
BlTelemetryTask >> gcStartTime [
	^ gcStartTime
]

{ #category : 'accessing' }
BlTelemetryTask >> gcStartTime: anObject [
	gcStartTime := anObject
]

{ #category : 'initialization' }
BlTelemetryTask >> initialize [
	super initialize.
	
	tasks := OrderedCollection new
]

{ #category : 'accessing' }
BlTelemetryTask >> name [
	^ name
]

{ #category : 'accessing' }
BlTelemetryTask >> name: anObject [
	name := anObject
]

{ #category : 'accessing' }
BlTelemetryTask >> overhead [
	^ (self realEndTime - self realStartTime) - (self endTime - self startTime)
]

{ #category : 'printing' }
BlTelemetryTask >> printDurationInMilliseconds [
	^ self durationInMilliseconds asString, 'ms'
]

{ #category : 'printing' }
BlTelemetryTask >> printOn: aStream [
	aStream
		nextPutAll: self name; space;
		nextPut: $(;
		nextPutAll: self printDurationInMilliseconds;
		nextPut: $)
]

{ #category : 'accessing' }
BlTelemetryTask >> realEndTime [
	^ realEndTime
]

{ #category : 'accessing' }
BlTelemetryTask >> realEndTime: aNumberOfMicroseconds [
	realEndTime := aNumberOfMicroseconds
]

{ #category : 'accessing' }
BlTelemetryTask >> realStartTime [
	^ realStartTime
]

{ #category : 'accessing' }
BlTelemetryTask >> realStartTime: aNumberOfMicroseconds [
	realStartTime := aNumberOfMicroseconds
]

{ #category : 'accessing' }
BlTelemetryTask >> startTime [
	^ startTime
]

{ #category : 'accessing' }
BlTelemetryTask >> startTime: aNumberOfMicroseconds [
	startTime := aNumberOfMicroseconds
]

{ #category : 'accessing' }
BlTelemetryTask >> tasks [
	^ tasks
]

{ #category : 'accessing' }
BlTelemetryTask >> tasks: aCollectionOfTasks [
	tasks := aCollectionOfTasks asOrderedCollection
]

{ #category : 'accessing' }
BlTelemetryTask >> totalOverhead [
	^ self overhead + self childrenOverhead
]
