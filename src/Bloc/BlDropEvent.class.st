Class {
	#name : 'BlDropEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events',
	#package : 'Bloc',
	#tag : 'Events'
}

{ #category : 'sending' }
BlDropEvent >> sendTo: anObject [
	anObject dropEvent: self
]
