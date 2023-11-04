Class {
	#name : 'BlDropEvent',
	#superclass : 'BlBaseDragEvent',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDropEvent >> sendTo: anObject [
	anObject dropEvent: self
]
