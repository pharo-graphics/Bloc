"
Emitted when the Universe has been suspended.

"
Class {
	#name : 'BlUniverseSuspended',
	#superclass : 'BlUniverseEvent',
	#category : 'Bloc-Events-Type-Universe'
}

{ #category : 'sending' }
BlUniverseSuspended >> sendTo: anObject [
	anObject universeSuspended: self
]
