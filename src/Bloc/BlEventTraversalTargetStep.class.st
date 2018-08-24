"
The event has arrived at the event's target. Event listeners registered for this phase are called at this time. If BlEvent>>#canBePropagated  is false, processing the event is finished after this phase is complete.
"
Class {
	#name : #BlEventTraversalTargetStep,
	#superclass : #BlEventTraversalStep,
	#category : 'Bloc-Event'
}

{ #category : #accessing }
BlEventTraversalTargetStep >> type [
	<return: #String>
	
	^ 'Arrived'
]
