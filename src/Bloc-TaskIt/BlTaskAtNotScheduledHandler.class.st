Class {
	#name : #BlTaskAtNotScheduledHandler,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

{ #category : #factory }
BlTaskAtNotScheduledHandler class >> default [
	^ BlTaskAtNotScheduledRegularExecutionHandler new
]

{ #category : #factory }
BlTaskAtNotScheduledHandler class >> shifting [
	^ BlTaskAtNotScheduledShiftingExecutionHandler new
]

{ #category : #handling }
BlTaskAtNotScheduledHandler >> notScheduled: aNotScheduleTask becauseOf: aScheduledTask [
	"subclasses can act on this event"
	self subclassResponsibility
]
