Class {
	#name : 'BlBlocUIManagerNotificationHandler',
	#superclass : 'Object',
	#instVars : [
		'managerNotification'
	],
	#classVars : [
		'NotificationHandlers'
	],
	#category : 'BlocHost-Morphic-Support',
	#package : 'BlocHost-Morphic',
	#tag : 'Support'
}

{ #category : 'api - instance creation' }
BlBlocUIManagerNotificationHandler class >> managerNotification: aManagerNotification [
	^ self new managerNotification: aManagerNotification
]

{ #category : 'accessing' }
BlBlocUIManagerNotificationHandler class >> notificationHandlers [
	^ NotificationHandlers
		ifNil: [ NotificationHandlers := Dictionary new ]
]

{ #category : 'api - accessing' }
BlBlocUIManagerNotificationHandler class >> preferredHandler [
	| aSelectedClass |
	aSelectedClass := BlBlocUIManagerNotificationBasicHandler.
	self allSubclassesDo: [ :aClass | 
		(aClass isAbstract not and: [ 
			aClass priority > aSelectedClass priority ])
				ifTrue: [ aSelectedClass := aClass ] ].
	^ aSelectedClass
]

{ #category : 'api - accessing' }
BlBlocUIManagerNotificationHandler class >> priority [
	<return: #Number>
	"The higher the number, the higher the priority"
	^ -100
]

{ #category : 'private - accessing' }
BlBlocUIManagerNotificationHandler >> arguments [
	^ self managerNotification arguments
]

{ #category : 'private - displaying' }
BlBlocUIManagerNotificationHandler >> continue: debugSession with: anObject [
	| context |
	context := debugSession interruptedContext.
	[ context notNil
		and: [ context isBlockContext or: [ context receiver ~~ self ] ] ]
		whileTrue: [ context := context sender ].
	debugSession
		returnValue: anObject
		from: (context ifNil: [ debugSession interruptedContext ]).
	debugSession resume
]

{ #category : 'private - accessing' }
BlBlocUIManagerNotificationHandler >> elementDoOrSpaceDo: aBlock [
	"Provide an element or space and evaluate the block"
	self subclassResponsibility
]

{ #category : 'private - accessing' }
BlBlocUIManagerNotificationHandler >> managerNotification [
	<return: #BlBlocUIManagerNotification>
	^ managerNotification
]

{ #category : 'api - initialization' }
BlBlocUIManagerNotificationHandler >> managerNotification: aManagerNotification [
	managerNotification := aManagerNotification
]

{ #category : 'private - accessing' }
BlBlocUIManagerNotificationHandler >> request [
	^ self managerNotification request
]

{ #category : 'api - displaying' }
BlBlocUIManagerNotificationHandler >> show [
	self elementDoOrSpaceDo: [ :each | ^ self showNotificationIn: each ].
	^ self unhandledAction
]

{ #category : 'private - displaying' }
BlBlocUIManagerNotificationHandler >> showNotificationIn: anElementOrSpace [
	self class notificationHandlers
		at: self request
		ifPresent: [ :creationBlock | 
			creationBlock numArgs <= 2
				ifTrue: [ anElementOrSpace
						showNotification: (creationBlock cull: self request cull: self arguments) ]
				ifFalse: [ ^ UIManager default
						debugProcess: Processor activeProcess
						context: thisContext
						label: 'UIManager Notification'
						spawningDebuggingUsing: [ :session | 
							anElementOrSpace
								showNotification:
									(creationBlock
										cull: self request
										cull: self arguments
										cull: [ :object | self continue: session with: object ]) ] ] ].
	^ self unhandledAction
]

{ #category : 'private - handling exceptions' }
BlBlocUIManagerNotificationHandler >> unhandledAction [
	^ self managerNotification unhandledAction
]
