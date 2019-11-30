Class {
	#name : #BlSharedEventDistributor,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'elements',
		'events',
		'handledEvents'
	],
	#category : #'Bloc-Events-Handling'
}

{ #category : #'instance creation' }
BlSharedEventDistributor class >> shareEvent: anEventClass [
	^ self shareEvents: { anEventClass }
]

{ #category : #'instance creation' }
BlSharedEventDistributor class >> shareEvents: aCollectionOfEvents [
	^ self new shareEvents: aCollectionOfEvents
]

{ #category : #'private - coordinates' }
BlSharedEventDistributor >> adjustPosition: aNewEvent from: anOldEvent [
	| anOldBounds anOldDiagonal aNewBounds aNewDiagonal aRatio aNewPosition |
	(anOldEvent currentTarget isKindOf: BlElement) ifFalse: [ ^ self ].
	anOldBounds := anOldEvent currentTarget boundsInSpace.
	anOldDiagonal := anOldBounds topLeft - anOldBounds bottomRight.
	aNewBounds := aNewEvent target boundsInSpace.
	aNewDiagonal := aNewBounds topLeft - aNewBounds bottomRight.
	aRatio := anOldDiagonal / aNewDiagonal.
	aNewPosition := (anOldEvent position - anOldBounds topLeft) * aRatio + aNewBounds topLeft.
	aNewEvent position: aNewPosition.
	aNewEvent screenPosition: anOldEvent screenPosition + (aNewPosition - anOldEvent position).
	
]

{ #category : #'api - event managing' }
BlSharedEventDistributor >> dispatch: anEvent on: anElement [
	| aNewEvent |
	anElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	aNewEvent := anEvent newCopyFor: anElement.
	(anEvent isKindOf: BlUIEvent) ifTrue: [ 
		self adjustPosition: aNewEvent from: anEvent ].
	events add: aNewEvent.
	BlEvent fireEvent: aNewEvent target: anElement.
]

{ #category : #accessing }
BlSharedEventDistributor >> elements [
	^ elements asArray
]

{ #category : #'gt-extension' }
BlSharedEventDistributor >> gtProcessedEventsFor: aView [
	<gtView>
	events ifNil: [ ^ aView empty ].
	events ifEmpty: [ ^ aView empty ].
	^ (events gtItemsFor: aView)
		title: 'Processed Events'
]

{ #category : #'gt-extension' }
BlSharedEventDistributor >> gtRegisteredElementsFor: aView [
	<gtView>
	elements ifNil: [ ^ aView empty ].
	elements ifEmpty: [ ^ aView empty ].
	^ (elements gtItemsFor: aView)
		title: 'Registered Elements'
]

{ #category : #'api - event managing' }
BlSharedEventDistributor >> handleEvent: anEvent [
	(events includes: anEvent) ifTrue: [ ^ self ].
	events add: anEvent.
	elements do: [ :eachElement | 
		anEvent currentTarget = eachElement ifFalse: [ 
			self dispatch: anEvent on: eachElement ] ]
]

{ #category : #initialization }
BlSharedEventDistributor >> initialize [
	super initialize.
	elements := Set new.
	events := WeakSet new.
	handledEvents := #().
]

{ #category : #'api - hooks' }
BlSharedEventDistributor >> onInstalledIn: anObject [
	elements add: anObject
]

{ #category : #'api - hooks' }
BlSharedEventDistributor >> onUninstalledIn: anObject [
	elements remove: anObject ifAbsent: [ "ignore" ]
]

{ #category : #accessing }
BlSharedEventDistributor >> shareEvents: aCollectionOfEvents [
	self 
		assert: [ aCollectionOfEvents isCollection ] 
		description: [ 'Handled events must be a collection' ].
	self 
		assert: [ aCollectionOfEvents isNotEmpty ] 
		description: [ 'Handled events must be a non-empty collection' ].
	handledEvents := aCollectionOfEvents
]

{ #category : #'api - event managing' }
BlSharedEventDistributor >> wantsEvent: anEvent [
	^ handledEvents includes: anEvent class
]
