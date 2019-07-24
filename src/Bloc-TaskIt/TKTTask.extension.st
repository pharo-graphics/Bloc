Extension { #name : #TKTTask }

{ #category : #'*Bloc-TaskIt' }
TKTTask >> asLoggingTask [ 
	"Answer the receiver as a task that will log its execution"

	^BlLoggingTask new 
		valuable: self;
		callingMethod: thisContext sender method asRingDefinition;
		yourself
]

{ #category : #'*Bloc-TaskIt' }
TKTTask >> name [ 

	^'an Unamed Task'
]

{ #category : #'*Bloc-TaskIt' }
TKTTask >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
