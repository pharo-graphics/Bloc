Class {
	#name : #BlSpacePropertiesTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'space',
		'showFirst'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #'building suites' }
BlSpacePropertiesTest class >> testParameters [

	^ super testParameters
		forSelector: #showFirst
		addOptions: #(true false)
]

{ #category : #running }
BlSpacePropertiesTest >> setUp [

	super setUp.

	space := self newTestingSpace.

	showFirst ifTrue: [ space show ].

	self waitTestingSpaces
]

{ #category : #accessing }
BlSpacePropertiesTest >> showFirst: aBoolean [ 

	showFirst := aBoolean
]

{ #category : #tests }
BlSpacePropertiesTest >> testBorderless [

	self deny: space isBorderless.

	space borderless: true.
	self waitTestingSpaces.

	self assert: space isBorderless
]

{ #category : #tests }
BlSpacePropertiesTest >> testFullscreen [

	self deny: space isFullscreen.

	space fullscreen: true.
	self waitTestingSpaces.

	self assert: space isFullscreen
]

{ #category : #tests }
BlSpacePropertiesTest >> testMaximize [

	self deny: space maximized.

	space maximize.
	self waitTestingSpaces.

	self assert: space maximized
]

{ #category : #tests }
BlSpacePropertiesTest >> testMinimize [

	self deny: space minimized.

	space minimize.
	self waitTestingSpaces.

	self assert: space minimized
]

{ #category : #tests }
BlSpacePropertiesTest >> testResizable [

	self assert: space isResizable.

	space resizable: false.
	self waitTestingSpaces.

	self deny: space isResizable
]

{ #category : #tests }
BlSpacePropertiesTest >> testVisible [

	showFirst
		ifTrue: [
			space close.
			self waitTestingSpaces.
			self deny: space isVisible ]
		ifFalse: [
 			space show.
			self waitTestingSpaces.
			self assert: space isVisible ]
]
