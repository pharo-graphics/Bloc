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
	^ BlBlocUIManagerNotificationHandler notificationHandlers
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

{ #category : #'exception handling' }
BlBlocUIManagerNotification >> defaultAction [
	self isFromMorphic ifTrue: [ ^ self processInMorphic ].
	self handlerDo: [ :aHandler | ^ aHandler show ].
	^ self unhandledAction
]

{ #category : #accessing }
BlBlocUIManagerNotification >> defaultBlock: aBlock [
	defaultBlock := aBlock
]

{ #category : #'private - accessing' }
BlBlocUIManagerNotification >> handlerDo: aBlock [
	| aClass anInstance |
	aClass := BlBlocUIManagerNotificationHandler preferredHandler.
	aClass ifNil: [ ^ self ].
	anInstance := aClass managerNotification: self.
	aBlock cull: anInstance.
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
BlBlocUIManagerNotification >> unhandledAction [
	^ defaultBlock isNil
		ifTrue: [ self error: 'No handler for request: ' , self request ]
		ifFalse: [ defaultBlock value ]
]
