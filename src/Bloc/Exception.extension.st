Extension { #name : #Exception }

{ #category : #'*Bloc' }
Exception >> freezeOrWithoutContext [
	"For classes that aren't resumable, just nil the signalContext, otherwise freeze it"

	self isResumable 
		ifTrue: [ self freeze ]
		ifFalse: [ signalContext := nil ]
]
