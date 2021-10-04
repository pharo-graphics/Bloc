"
I share {{gtClass:BlEvent}} instances (element events) among a given elements.

## Example

In the following example, {{gtClass:BlMouseOverEvent}}, {{gtClass:BlMouseOutEvent}}, and {{gtClass:BlClickEvent}} are shared between the two graphical elements. If you hover a mouse over any element, both elements get darker. If you click on any of two elements, both elements randomly change their background color.
{{gtExample:BlSharedEventDistributorExamples>>#example|codeExpanded=false|previewExpanded=true}}


"
Class {
	#name : #BlSharedEventDistributor,
	#superclass : #BlBasicEventHandler,
	#instVars : [
		'elements',
		'handledEvents',
		'shouldHandle'
	],
	#category : #'Bloc-Events-Handler'
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
	
	(anOldEvent currentTarget isKindOf: BlElement)
		ifFalse: [ ^ self ].
	
	anOldBounds := anOldEvent currentTarget boundsInSpace.
	anOldDiagonal := anOldBounds topLeft - anOldBounds bottomRight.
	aNewBounds := aNewEvent target boundsInSpace.
	aNewDiagonal := aNewBounds topLeft - aNewBounds bottomRight.
	aRatio := ((aNewDiagonal x closeTo: 0) or: [ aNewDiagonal y closeTo: 0])
		ifTrue: [ 1 ]
		ifFalse: [ anOldDiagonal / aNewDiagonal ].
	aNewPosition := (anOldEvent position - anOldBounds topLeft) * aRatio + aNewBounds topLeft.
	aNewEvent position: aNewPosition.
	aNewEvent screenPosition: (anOldEvent screenPosition ifNil: [ 0@0 ]) + (aNewPosition - anOldEvent position)
]

{ #category : #'api - event managing' }
BlSharedEventDistributor >> dispatch: anEvent on: anElement [
	| aNewEvent |

	shouldHandle
		ifFalse: [ ^ self ].
	
	aNewEvent := anEvent newCopyFor: anElement.
	(anEvent isKindOf: BlUIEvent) ifTrue: [
		self adjustPosition: aNewEvent from: anEvent ].

	shouldHandle := false.
	[ anElement dispatchEvent: aNewEvent ]
		ensure: [ shouldHandle := true ]
]

{ #category : #accessing }
BlSharedEventDistributor >> elements [
	^ elements asArray
]

{ #category : #'api - accessing' }
BlSharedEventDistributor >> eventsToHandle [
	^ handledEvents
]

{ #category : #'api - event managing' }
BlSharedEventDistributor >> handleEvent: anEvent [

	shouldHandle
		ifFalse: [ ^ self ].

	elements do: [ :eachElement | 
		anEvent currentTarget = eachElement
			ifFalse: [ self dispatch: anEvent on: eachElement ] ]
]

{ #category : #initialization }
BlSharedEventDistributor >> initialize [
	super initialize.
	elements := Set new.
	handledEvents := #().
	shouldHandle := true
]

{ #category : #'api - hooks' }
BlSharedEventDistributor >> onInstalledIn: anObject [
	elements add: anObject
]

{ #category : #'api - hooks' }
BlSharedEventDistributor >> onUninstalledIn: anObject [
	elements
		remove: anObject
		ifAbsent: [ "ignore" ]
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
	shouldHandle
		ifFalse: [ ^ false ].

	^ handledEvents includes: anEvent class
]
