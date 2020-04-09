Class {
	#name : #BlTaskAtNotScheduledRegularExecutionHandler,
	#superclass : #BlTaskAtNotScheduledHandler,
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

{ #category : #handling }
BlTaskAtNotScheduledRegularExecutionHandler >> notScheduled: aNotScheduleTask becauseOf: aScheduledTask [
	"do nothing - it implies that aScheduledTask will be executed at its scheduled time"
]

{ #category : #handling }
BlTaskAtNotScheduledRegularExecutionHandler >> notScheduledBecauseOf: aBlTaskAtTask [
	"do nothing - it implies that aBlTaskAtTask will be executed at its scheduled time"
]
