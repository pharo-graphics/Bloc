Class {
	#name : #BlBlocUIManagerNotificationBasicHandler,
	#superclass : #BlBlocUIManagerNotificationHandler,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'api - accessing' }
BlBlocUIManagerNotificationBasicHandler class >> priority [
	"Return an integer indicating the priority of the publisher. The higher the number, the higher the priority"
	
	^ 1
]

{ #category : #'private - displaying' }
BlBlocUIManagerNotificationBasicHandler >> elementDoOrSpaceDo: aBlock [

	| context |
	context := thisContext.
	[ context notNil ]
		whileTrue: [ ((context receiver isKindOf: BlElement)
				or: [ context receiver isKindOf: BlSpace ])
				ifTrue: [ ^ aBlock value: context receiver ].
			context := context sender ]
]
