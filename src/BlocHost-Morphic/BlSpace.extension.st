Extension { #name : #BlSpace }

{ #category : #'*BlocHost-Morphic' }
BlSpace >> showNotification: aNotification [
	"Notification may come from any process"

	self enqueueTask: (BlTaskAction new 
		action: [ self root addChild: aNotification asElement ])
]
