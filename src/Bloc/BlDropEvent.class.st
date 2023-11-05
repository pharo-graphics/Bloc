Class {
	#name : 'BlDropEvent',
	#superclass : 'BlBaseDragEvent',
	#category : 'Bloc-Events'
}

{ #category : 'sending' }
BlDropEvent >> sendTo: anObject [
	anObject dropEvent: self
]
