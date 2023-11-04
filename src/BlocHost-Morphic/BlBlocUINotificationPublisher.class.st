Class {
	#name : 'BlBlocUINotificationPublisher',
	#superclass : 'Object',
	#instVars : [
		'notification',
		'element'
	],
	#category : 'BlocHost-Morphic-Support',
	#package : 'BlocHost-Morphic',
	#tag : 'Support'
}

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher class >> preferredPublisher [
	| aSelectedClass |
	aSelectedClass := BlBlocUINotificationBasicPublisher.
	self allSubclassesDo: [ :aClass | 
		(aClass isAbstract not and: [ 
			aClass priority > aSelectedClass priority ])
				ifTrue: [ aSelectedClass := aClass ] ].
	^ aSelectedClass
]

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher class >> priority [
	<return: #Number>
	"The higher the number, the higher the priority"
	^ -100
]

{ #category : 'api - instance creation' }
BlBlocUINotificationPublisher class >> showNotification: aNotification inElement: anElement [
	^ self preferredPublisher new
		element: anElement;
		notification: aNotification;
		show
]

{ #category : 'private - displaying' }
BlBlocUINotificationPublisher >> addNotification [
	self subclassResponsibility
]

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher >> element [
	<return: #BlElement>
	^ element
]

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher >> element: anElement [
	element := anElement
]

{ #category : 'private - displaying' }
BlBlocUINotificationPublisher >> enqueueTaskAction: aBlock [
	self element enqueueTask: (BlTaskAction new 
		action: aBlock)
]

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher >> notification [
	^ notification
]

{ #category : 'api - accessing' }
BlBlocUINotificationPublisher >> notification: aNotification [
	"aNotification must be an object that understands #asElement"
	notification := aNotification
]

{ #category : 'api - displaying' }
BlBlocUINotificationPublisher >> show [
	self enqueueTaskAction: [ self addNotification ]
]
