Class {
	#name : #BlParallelUniverseSignal,
	#superclass : #BeaconSignal,
	#instVars : [
		'universe',
		'universeID'
	],
	#classInstVars : [
		'enabled'
	],
	#category : #'Bloc-Universe - Parallel'
}

{ #category : #accessing }
BlParallelUniverseSignal class >> enableAll: aBoolean [
	"Enable/disable the receiver and all subclasses"

	self withAllSubclassesDo: [ :each | each enabled: aBoolean ]
]

{ #category : #accessing }
BlParallelUniverseSignal class >> enabled [ 
	"Answer a boolean indicating whether the receiver is enabled.
	Allow for nil = false"

	^enabled == true
]

{ #category : #accessing }
BlParallelUniverseSignal class >> enabled: aBoolean [
	"Indicate whether the receiver is enabled or not"

	enabled := aBoolean
]

{ #category : #testing }
BlParallelUniverseSignal class >> isAbstract [
	^ self = BlParallelUniverseSignal
]

{ #category : #accessing }
BlParallelUniverseSignal class >> isRepeatable [
	"Return true if this signal is expected to be emitted regularly"
	<return: #Boolean>

	^ false
]

{ #category : #accessing }
BlParallelUniverseSignal class >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
BlParallelUniverseSignal class >> nextSignals [
	"Return a collection of possible signals after this one"
	^ #()
]

{ #category : #'instance creation' }
BlParallelUniverseSignal >> emit [ 

	self class enabled ifTrue: [ super emit ]
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe [
	^ universe
]

{ #category : #accessing }
BlParallelUniverseSignal >> universe: aParallelUniverse [
	universe := aParallelUniverse.
	universeID := aParallelUniverse identityHash
]
