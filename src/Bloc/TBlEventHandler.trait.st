"
I define an API of an abstract event handler
"
Trait {
	#name : #TBlEventHandler,
	#category : 'Bloc-EventHandling'
}

{ #category : #events }
TBlEventHandler >> handleEvent: anEvent [
	"Handle a given event or dispatch it using #sendTo:"

	self explicitRequirement
]

{ #category : #testing }
TBlEventHandler >> hasOwner [
	<return: #Boolean>

	^ false
]

{ #category : #events }
TBlEventHandler >> wantsEvent: anEvent [
	"Return true if I am interested in a given event and want to handle it,
	false otherwise"
	<return: #Boolean>

	^ self explicitRequirement
]
