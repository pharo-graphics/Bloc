Class {
	#name : #BlBlocUINotificationBasicPublisher,
	#superclass : #BlBlocUINotificationPublisher,
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'api - accessing' }
BlBlocUINotificationBasicPublisher class >> priority [
	<return: #Number>
	"Higher number, higher priority"
	^ 1
]

{ #category : #'api - displaying' }
BlBlocUINotificationBasicPublisher >> addNotification [
	^ self element addChild: self notification asElement
]
