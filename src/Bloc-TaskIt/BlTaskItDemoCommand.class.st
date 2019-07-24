"
GtInspector openOn: BlTaskItDemoCommand new
"
Class {
	#name : #BlTaskItDemoCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'wasCanceled'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'api - execution' }
BlTaskItDemoCommand >> execute [
	1 to: 20 do: [ :each |
		self isTerminationRequested ifTrue: [ wasCanceled := true. ^ self ].
		(Delay forMilliseconds: 100) wait ]. 
	1 to: 20 do: [ :each |
		self isTerminationRequested ifTrue: [ wasCanceled := true. ^ self ].
		BlTaskProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
		(Delay forMilliseconds: 100) wait ]
]

{ #category : #initialization }
BlTaskItDemoCommand >> initialize [
	super initialize.
	wasCanceled := false.
	name := 'Bloc TaskIt Demo Command'.
]

{ #category : #accessing }
BlTaskItDemoCommand >> wasCanceled [
	^ wasCanceled
]
