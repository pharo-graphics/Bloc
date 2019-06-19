Extension { #name : #MessageSend }

{ #category : #'*Bloc-TaskIt' }
MessageSend >> asLoggingTask [ 
	"Answer the receiver as a task that will log its execution"

	^BlLoggingTask new 
		valuable: self;
		callingMethod: thisContext sender method asRingDefinition;
		yourself
]

{ #category : #'*Bloc-TaskIt' }
MessageSend >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
