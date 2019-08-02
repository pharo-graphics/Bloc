Extension { #name : #TKTTask }

{ #category : #'*Bloc-TaskIt' }
TKTTask >> name [ 

	^'an Unamed Task'
]

{ #category : #'*Bloc-TaskIt' }
TKTTask >> taskPriority [
	"Answer the priority of the receiver when submitted as a task to TaskIt. 0 is highest priority"

	^0
]
