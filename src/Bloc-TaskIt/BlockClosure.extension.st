Extension { #name : #BlockClosure }

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asCommand [
	^ BlValuableCommand new valuable: self
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
