Extension { #name : 'BlElement' }

{ #category : '*BlocHost-Morphic' }
BlElement >> showNotification: aNotification [
	self parent ifNotNil: [ :aParent | 
		aParent showNotification: aNotification.
		^ self ].
	
	BlBlocUINotificationPublisher 
		showNotification: aNotification
		inElement: self
]
