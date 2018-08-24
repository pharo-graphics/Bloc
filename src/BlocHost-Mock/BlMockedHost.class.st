"
I am a mocked host that looks like real but does not create any windows
"
Class {
	#name : #BlMockedHost,
	#superclass : #BlHost,
	#instVars : [
		'isRunning'
	],
	#category : 'BlocHost-Mock-Host'
}

{ #category : #'host - api' }
BlMockedHost >> createHostSpaceFor: aSpace [
	| aHostSpace |

	aHostSpace := BlMockedHostSpace new.
	aHostSpace host: self.
	aHostSpace space: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BlMockedHost >> destroyHostSpaceFor: aSpace [
	"Destroys host space window of a given space.
	Note: in most cases under 'destroy host space' we mean 'close host window' and unregister it"
	
	aSpace detachHostSpace
]

{ #category : #initialization }
BlMockedHost >> initialize [
	super initialize.
	
	isRunning := false
]

{ #category : #'host - api' }
BlMockedHost >> isRunning [
	"Return true if host is initialized and running"
	<return: #Boolean>

	^ isRunning
]

{ #category : #'host - api' }
BlMockedHost >> start [
	isRunning := true
]

{ #category : #'host - api' }
BlMockedHost >> stop [
	isRunning := false
]
