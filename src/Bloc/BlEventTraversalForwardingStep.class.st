"
The event is being manually forwarded to other dispatchers
"
Class {
	#name : #BlEventTraversalForwardingStep,
	#superclass : #BlEventTraversalStep,
	#category : 'Bloc-Event'
}

{ #category : #accessing }
BlEventTraversalForwardingStep >> type [
	<return: #String>
	
	^ 'Forwarded'
]
