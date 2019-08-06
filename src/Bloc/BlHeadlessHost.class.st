"
I am a fallback host that is chosen if there are no other available and supported hosts.
"
Class {
	#name : #BlHeadlessHost,
	#superclass : #BlHost,
	#instVars : [
		'isRunning'
	],
	#category : #'Bloc-Universe'
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

{ #category : #api }
BlHeadlessHost >> createHostSpaceFor: aSpace [	
	| aHostSpace |
	
	aHostSpace := BlHeadlessHostSpace new.
	aHostSpace universe: self universe.
	aHostSpace host: self.
	aHostSpace space: aSpace.

	aSpace hostSpace: aHostSpace
]

{ #category : #api }
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

{ #category : #api }
BlHeadlessHost >> isRunning [
	^ isRunning
]

{ #category : #api }
BlHeadlessHost >> start [
	isRunning := true.
	
	(BlParallelUniverse forHost: self class) pulse
]

{ #category : #api }
BlHeadlessHost >> stop [
	isRunning := false
]
