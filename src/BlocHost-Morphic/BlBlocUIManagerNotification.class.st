Class {
	#name : #BlBlocUIManagerNotification,
	#superclass : #Notification,
	#instVars : [
		'request',
		'arguments',
		'defaultBlock'
	],
	#classVars : [
		'NotificationHandlers'
	],
	#category : #'BlocHost-Morphic-Support'
}

{ #category : #accessing }
BlBlocUIManagerNotification class >> notificationHandlers [
	^ NotificationHandlers
		ifNil: [ NotificationHandlers := Dictionary new ]
]

{ #category : #signaling }
BlBlocUIManagerNotification class >> request: aSymbol with: anArray [
	^ self new
		request: aSymbol;
		arguments: anArray;
		signal
]

{ #category : #signaling }
BlBlocUIManagerNotification class >> request: aSymbol with: anArray default: aBlock [
	^ self new
		request: aSymbol;
		arguments: anArray;
		defaultBlock: aBlock;
		signal
]

{ #category : #signaling }
BlBlocUIManagerNotification class >> requestOrNil: aSymbol with: anArray [
	^ self new
		request: aSymbol;
		arguments: anArray;
		defaultBlock: [ nil ];
		signal
]

{ #category : #accessing }
BlBlocUIManagerNotification >> arguments [
	^ arguments
]

{ #category : #accessing }
BlBlocUIManagerNotification >> arguments: anArray [
	arguments := anArray
]

{ #category : #private }
BlBlocUIManagerNotification >> continue: debugSession with: anObject [
	debugSession
		returnValue: anObject
		from: debugSession interruptedContext.
	debugSession resume
]

{ #category : #private }
BlBlocUIManagerNotification >> createNotificationWithContinuation: aBlock [
	^ self class notificationHandlers
		at: request
		ifPresent: [ :block | block cull: request cull: arguments cull: aBlock ]
]

{ #category : #'exception handling' }
BlBlocUIManagerNotification >> defaultAction [
	self isFromMorphic
		ifTrue: [ ^ self processInMorphic ].
	self elementDoOrSpaceDo: [ :each | ^ self showNotificationIn: each ].
	^ self unhandledAction
]

{ #category : #accessing }
BlBlocUIManagerNotification >> defaultBlock: aBlock [
	defaultBlock := aBlock
]

{ #category : #private }
BlBlocUIManagerNotification >> elementDoOrSpaceDo: aBlock [
	| context |
	context := thisContext.
	[ context notNil ]
		whileTrue: [ ((context receiver isKindOf: BlElement)
				or: [ context receiver isKindOf: BlSpace ])
				ifTrue: [ ^ aBlock value: context receiver ].
			context := context sender ]
]

{ #category : #testing }
BlBlocUIManagerNotification >> isFromMorphic [
	| context worldMorphClass |
	worldMorphClass := Smalltalk at: #WorldMorph.
	worldMorphClass isNil
		ifTrue: [ ^ false ].
	context := thisContext.
	[ context notNil ]
		whileTrue: [ (context receiver isKindOf: worldMorphClass)
				ifTrue: [ ^ true ].
			context := context sender ].
	^ false
]

{ #category : #private }
BlBlocUIManagerNotification >> processInMorphic [
	^ self
		resume:
			((MorphicUIManager whichClassIncludesSelector: self request)
				>> self request
				valueWithReceiver: UIManager default
				arguments: self arguments)
]

{ #category : #accessing }
BlBlocUIManagerNotification >> request [
	^ request
]

{ #category : #accessing }
BlBlocUIManagerNotification >> request: aSymbol [
	request := aSymbol
]

{ #category : #private }
BlBlocUIManagerNotification >> showNotificationIn: anElementOrSpace [
	| session |
	(self
		createNotificationWithContinuation: [ :object | self continue: session with: object ])
		ifNotNil: [ :notification | 
			^ UIManager default
				debugProcess: Processor activeProcess
				context: thisContext
				label: 'UIManager Notification'
				spawningDebuggingUsing: [ :debugSession | 
					session := debugSession.
					anElementOrSpace showNotification: notification ] ].
	^ self unhandledAction
]

{ #category : #private }
BlBlocUIManagerNotification >> unhandledAction [
	^ defaultBlock isNil
		ifTrue: [ self error: 'No handler for request: ' , self request ]
		ifFalse: [ defaultBlock value ]
]
