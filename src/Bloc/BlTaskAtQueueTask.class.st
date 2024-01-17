"
I represent the objects added to the queue by `BlTaskAtQueue`. It stores the valuable and scheduled execution time.

## Internal Representation and Key Implementation Points.

### Instance Variables

	scheduledTime:		<DateAndTime>
	valuable:				<Object>


"
Class {
	#name : 'BlTaskAtQueueTask',
	#superclass : 'Object',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'valuable',
		'scheduledTime',
		'queue'
	],
	#category : 'Bloc-DataStructure - Priority Queue',
	#package : 'Bloc',
	#tag : 'DataStructure - Priority Queue'
}

{ #category : 'instance creation' }
BlTaskAtQueueTask class >> valuable: aValuable at: aTime [

	^ self new
		initialize: aValuable at: aTime;
		yourself
]

{ #category : 'accessing' }
BlTaskAtQueueTask >> entryPriority [ 
	"Answer the receiver's priority.
	Zero is the highest priority, so earlier scheduled tasks have a higher priority."

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
BlTaskAtQueueTask >> queue: aQueue [

	queue := aQueue
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

	^ valuable value
]
