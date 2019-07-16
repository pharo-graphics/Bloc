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
TKTTask >> asNamedTask [
	^ BlTaskItNamedTask new task: self asLoggingTask
]

{ #category : #'*Bloc-TaskIt' }
TKTTask >> asNotifyingTask [
	^ BlTktNotifyingTask new task: self asLoggingTask
]

{ #category : #'*Bloc-TaskIt' }
TKTTask >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
