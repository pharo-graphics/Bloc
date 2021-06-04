"
This class contains tests

"
Class {
	#name : #BlSpaceTest,
	#superclass : #TestCase,
	#instVars : [
		'space',
		'host'
	],
	#category : #'Bloc-Tests-Space'
}

{ #category : #initialization }
BlSpaceTest >> dirtyAreas [
	^ space dirtyAreas asArray collect: #asRectangle
]

{ #category : #initialization }
BlSpaceTest >> setUp [
	super setUp.
	
	space := BlSpace new.
	host := BlMockedHost new.

	space host: host.
	host createHostSpaceFor: space.
]

{ #category : #initialization }
BlSpaceTest >> tearDown [
	super tearDown.

	host destroyHostSpaceFor: space.
	space host: nil.
	host := nil.
	space := nil
]

{ #category : #tests }
BlSpaceTest >> testEnqueueEvent [

	space pulse.
	self assert: space pulseRequested not.
	
	space hostSpace enqueueEvent: (BlMouseMoveEvent new position: 20@20).
	self assert: space pulseRequested.
	
	space pulse.
	self assert: space pulseRequested not
]

{ #category : #tests }
BlSpaceTest >> testInitialization [

	"Host space must not be nil"
	self assert: space hostSpace isNotNil.
	
	"Space must request pulse when just created"
	self assert: space pulseRequested.
	
	"Space must have its whole area being dirty"
	self assert: self dirtyAreas equals: { 0@0 extent: space extent }
]

{ #category : #tests }
BlSpaceTest >> testRender [

	self assert: self dirtyAreas equals: { 0@0 extent: space extent }.
	self assert: space hostSpace renderCount equals: 0.
	self assert: space pulseRequested.
	
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.

	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.
	
	space requestNextPulse.
	self assert: space pulseRequested.
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 1.
	self assert: space pulseRequested not.

	space invalidRect: (BlBounds origin: 50.0@70.0 extent: 300.0@200.0) from: space root.
	self assert: space pulseRequested.
	self assert: self dirtyAreas equals: { 50@70 extent: 300@200 }.
	space pulse.
	self assert: self dirtyAreas equals: {}.
	self assert: space hostSpace renderCount equals: 2.
	self assert: space pulseRequested not.
]
