"
BlTaskAtTask is the object added to the queue by BlTaskAtQueue.  It stores the valuable and scheduled execution time.

!!Internal Representation and Key Implementation Points.

!!!Instance Variables

	scheduledTime:		<DateAndTime>
	valuable:				<Object>

"
Class {
	#name : #BlTaskAtTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'valuable',
		'scheduledTime'
	],
	#category : #'Bloc-Space - Tasks'
}

{ #category : #'instance creation' }
BlTaskAtTask class >> valuable: aValuable at: aTime [

	^self new initialize: aValuable at: aTime
]

{ #category : #accessing }
BlTaskAtTask >> entryPriority [ 
	"Answer the receiver's priority - 0 is highest"

	^(scheduledTime - BlTime real now) asMilliSeconds max: 0
]

{ #category : #initialization }
BlTaskAtTask >> initialize: aValuable at: aTime [

	valuable := aValuable.
	scheduledTime := aTime.
]

{ #category : #printing }
BlTaskAtTask >> printOn: aStream [

	super printOn: aStream.
	aStream 
		<< '(';
		print: scheduledTime;
		<< ')'
]

{ #category : #accessing }
BlTaskAtTask >> scheduledTime [
	^ scheduledTime
]

{ #category : #accessing }
BlTaskAtTask >> valuable [
	^ valuable
]

{ #category : #evaluating }
BlTaskAtTask >> value [
	"evaluate valuable"
	^ self valuable value
]
