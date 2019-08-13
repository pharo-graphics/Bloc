Extension { #name : #TKTGenericTask }

{ #category : #'*Bloc-TaskIt' }
TKTGenericTask >> entryPriority [ 
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^valuable entryPriority
]
