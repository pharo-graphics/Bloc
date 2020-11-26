Class {
	#name : #BlBlocUINotificationPublisher,
	#superclass : #Object,
	#instVars : [
		'space',
		'notification'
	],
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher class >> preferredPublisher [
	| aSelectedClass |
	aSelectedClass := BlBlocUINotificationBasicPublisher.
	self allSubclassesDo: [ :aClass | 
		(aClass isAbstract not and: [ 
			aClass priority > aSelectedClass priority ])
				ifTrue: [ aSelectedClass := aClass ] ].
	^ aSelectedClass
]

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher class >> priority [
	<return: #Number>
	"The higher the number, the higher the priority"
	^ -100
]

{ #category : #'api - instance creation' }
BlBlocUINotificationPublisher class >> showNotification: aNotification inSpace: aSpace [
	^ self preferredPublisher new
		space: aSpace;
		notification: aNotification;
		show
]

{ #category : #'private - accessing' }
BlBlocUINotificationPublisher >> element [
	<return: #BlElement>
	^ self notification asElement
]

{ #category : #'private - displaying' }
BlBlocUINotificationPublisher >> enqueueTaskAction: aBlock [
	self space enqueueTask: (BlTaskAction new 
		action: aBlock)
]

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher >> notification [
	^ notification
]

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher >> notification: aNotification [
	"aNotification must be an object that understands #asElement"
	notification := aNotification
]

{ #category : #'api - displaying' }
BlBlocUINotificationPublisher >> show [
	"Display a notification in a space.
	Notification may come from any process."
	self subclassResponsibility
]

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher >> space [
	<return: #BlSpace>
	^ space
]

{ #category : #'api - accessing' }
BlBlocUINotificationPublisher >> space: aSpace [
	space := aSpace
]
