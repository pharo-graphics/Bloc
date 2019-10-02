"
I am a fallback host that is chosen if there are no other available and supported hosts.
"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#instVars : [
		'isRunning'
	],
	#category : #'Bloc-Universe - Host'
}

{ #category : #'driver selection' }
BlHeadlessHost class >> label [
	^ 'Headless'
]

{ #category : #'driver selection' }
BlHeadlessHost class >> priority [
	"Infinite priority means that I am selected only if there are no other available hosts"
	<return: #Number>
	
	^ Float infinity
]

{ #category : #'host - api' }
BlHeadlessHost >> createHostSpaceFor: aSpace [	
	| aHostSpace |
	
	aHostSpace := BlHeadlessHostSpace new.
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.
	aHostSpace withSpartaRenderer.

	aSpace hostSpace: aHostSpace
]

{ #category : #'host - api' }
BlHeadlessHost >> destroyHostSpaceFor: aSpace [
	aSpace hostSpace
		close;
		detachSpace;
		detachHost;
		detachUniverse.

	aSpace detachHostSpace
]

{ #category : #initialization }
BlHeadlessHost >> initialize [
	super initialize.
	
	isRunning := false
]

{ #category : #'host - api' }
BlHeadlessHost >> isRunning [
	^ isRunning
]

{ #category : #'host - api' }
BlHeadlessHost >> start [
	isRunning := true.
	
	(BlParallelUniverse forHost: self class) pulse
]

{ #category : #'host - api' }
BlHeadlessHost >> stop [
	isRunning := false
]

{ #category : #'host - testing' }
BlHeadlessHost >> supportsBufferSurface [
	<return: #Boolean>
	
	^ true
]
