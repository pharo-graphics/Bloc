Extension { #name : #TKTGenericTask }

{ #category : #'*Bloc-TaskIt' }
TKTGenericTask >> taskPriority [ 
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^valuable taskPriority
]
