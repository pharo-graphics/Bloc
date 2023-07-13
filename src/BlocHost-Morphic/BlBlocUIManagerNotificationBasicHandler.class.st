Class {
	#name : #BlBlocUIManagerNotificationBasicHandler,
	#superclass : #BlBlocUIManagerNotificationHandler,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'api - accessing' }
BlBlocUIManagerNotificationBasicHandler class >> priority [
	<return: #Number>
	"Higher number, higher priority"
	^ 1
]

{ #category : #'private - displaying' }
BlBlocUIManagerNotificationBasicHandler >> elementDoOrSpaceDo: aBlock [
	| context |
	context := thisContext.
	[ context notNil ]
		whileTrue: [ ((context receiver isKindOf: BlElement)
				or: [ context receiver isKindOf: BlOSpace ])
				ifTrue: [ ^ aBlock value: context receiver ].
			context := context sender ]
]
