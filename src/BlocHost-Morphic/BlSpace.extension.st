Extension { #name : #BlSpace }

{ #category : #'*BlocHost-Morphic' }
BlSpace >> showNotification: aNotification [

	BlBlocUINotificationPublisher 
		showNotification: aNotification
		inSpace: self
]
