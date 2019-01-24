Class {
	#name : #BlBasicEventHandler,
	#superclass : #Object,
	#traits : 'TBlEventHandler + TBlDebug',
	#classTraits : 'TBlEventHandler classTrait + TBlDebug classTrait',
	#category : #'Bloc-Events-Handling'
}

{ #category : #'api - event managing' }
BlBasicEventHandler >> handleEvent: anEvent [
]

{ #category : #'api - hooks' }
BlBasicEventHandler >> onInstalledIn: anObject [
]

{ #category : #'api - hooks' }
BlBasicEventHandler >> onUninstalledIn: anObject [
]

{ #category : #'api - event managing' }
BlBasicEventHandler >> wantsEvent: anEvent [
	^ true
]
