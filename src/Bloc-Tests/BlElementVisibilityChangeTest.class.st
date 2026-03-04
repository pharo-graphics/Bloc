Class {
	#name : #BlElementVisibilityChangeTest,
	#superclass : #TestCase,
	#instVars : [
		'visibility',
		'element'
	],
	#category : #'Bloc-Tests-Basic-Changes'
}

{ #category : #tests }
BlElementVisibilityChangeTest >> elementVisibilityChangedEvent: anEvent [

	visibility := anEvent currentTarget visibility copy
]

{ #category : #'instance creation' }
BlElementVisibilityChangeTest >> newElement [

	| e |
	e := BlElement new.
	e extent: 200 @ 200.
	e background: Color blue.
	^ e
]

{ #category : #running }
BlElementVisibilityChangeTest >> setUp [ 

	super setUp.
	element := self newElement.
	element
		addEventHandlerOn: BlElementVisibilityChangedEvent
		do: [ :evt | evt sendTo: self ].
	visibility := nil
]

{ #category : #tests }
BlElementVisibilityChangeTest >> testVisibilityChanged [

	self assert: visibility equals: nil.
	element visibility: BlVisibility visible.
	self assert: visibility equals: nil.
	element visibility: BlVisibility hidden.
	self assert: visibility equals: BlVisibility hidden.
	element visibility: BlVisibility gone.
	self assert: visibility equals: BlVisibility gone
]

{ #category : #tests }
BlElementVisibilityChangeTest >> testVisibilityChangedDisabled [

	element eventDispatcher disableVisibilityChanged.
	self assert: visibility equals: nil.
	element visibility: BlVisibility visible.
	self assert: visibility equals: nil.
	element visibility: BlVisibility hidden.
	self assert: visibility equals: nil.
	element visibility: BlVisibility gone.
	self assert: visibility equals: nil.
]
