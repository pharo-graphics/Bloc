"
Emitted when the Universe has been resumed.

"
Class {
	#name : 'BlUniverseResumed',
	#superclass : 'BlUniverseEvent',
	#category : 'Bloc-Events-Type-Universe'
}

{ #category : 'sending' }
BlUniverseResumed >> sendTo: anObject [
	anObject universeResumed: self
]
