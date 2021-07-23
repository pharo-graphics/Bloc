"
BlTaskAtTask is the object added to the queue by BlTaskAtQueue.  It stores the valuable and scheduled execution time.

## Internal Representation and Key Implementation Points.

### Instance Variables

	scheduledTime:		<DateAndTime>
	valuable:				<Object>


"
Class {
	#name : 'BlTaskAtQueueTask',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'valuable',
		'scheduledTime',
		'queue'
	],
	#category : 'Bloc-DataStructure - Priority Queue'
}

{ #category : 'instance creation' }
BlTaskAtQueueTask class >> valuable: aValuable at: aTime [

	^self new initialize: aValuable at: aTime
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> entryPriority [ 
	"Answer the receiver's priority.
	0 is highest, so earlier scheduled tasks have a higher priority"

	^ (scheduledTime - queue processTime) asMilliSeconds max: 0

]

{ #category : 'handling' }
BlTaskAtQueueTask >> handleNotScheduledBecauseOfPreviousTask: aBlTaskAtTask [
	"subclasses can act on this event"
]

{ #category : 'initialization' }
BlTaskAtQueueTask >> initialize: aValuable at: aTime [

	valuable := aValuable.
	scheduledTime := aTime.
]

{ #category : 'printing' }
BlTaskAtQueueTask >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< '(';
		print: scheduledTime;
		<< ')'
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> queue [
	^ queue
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> queue: anObject [
	queue := anObject
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> scheduledTime [
	^ scheduledTime
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> scheduledTime: aTime [
	scheduledTime := aTime
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> valuable [
	^ valuable
]

{ #category : 'evaluating' }
BlTaskAtQueueTask >> value [
	"evaluate valuable"
	^ self valuable value
]
