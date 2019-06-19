Extension { #name : #BlockClosure }

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asCommand [
	^ BlValuableCommand new valuable: self
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> asLoggingTask [ 
	"Answer the receiver as a task that will log its execution"

	^BlLoggingTask new 
		valuable: self;
		callingMethod: thisContext sender method asRingDefinition;
		yourself
]

{ #category : #'*Bloc-TaskIt' }
BlockClosure >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
