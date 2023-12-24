Class {
	#name : #BlBlocUINotificationBasicPublisher,
	#superclass : #BlBlocUINotificationPublisher,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'api - accessing' }
BlBlocUINotificationBasicPublisher class >> priority [
	"Return an integer indicating the priority of the publisher. The higher the number, the higher the priority"
	
	^ 1
]

{ #category : #'api - displaying' }
BlBlocUINotificationBasicPublisher >> addNotification [
	^ self element addChild: self notification asElement
]
