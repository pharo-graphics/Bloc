"
The event is being manually forwarded to other dispatchers

"
Class {
	#name : 'BlEventTraversalForwardingStep',
	#superclass : 'BlEventTraversalStep',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'accessing' }
BlEventTraversalForwardingStep >> type [
	<return: #String>
	
	^ 'Forwarded'
]
