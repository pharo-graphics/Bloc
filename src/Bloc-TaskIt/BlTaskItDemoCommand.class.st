"
GtInspector openOn: BlTaskItDemoCommand new
"
Class {
	#name : #BlTaskItDemoCommand,
	#superclass : #BlCommand,
	#instVars : [
		'cancelRequested',
		'wasCanceled'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #'api - execution' }
BlTaskItDemoCommand >> cancelRequest [
	"Every command is responsible to terminate nicely"
	cancelRequested := true.
]

{ #category : #'api - execution' }
BlTaskItDemoCommand >> execute [
	1 to: 20 do: [ :each |
		cancelRequested ifTrue: [ wasCanceled := true. ^ self ].
		(Delay forMilliseconds: 100) wait ]. 
	1 to: 20 do: [ :each |
		cancelRequested ifTrue: [ wasCanceled := true. ^ self ].
		BlTaskProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
		(Delay forMilliseconds: 100) wait ]
]

{ #category : #initialization }
BlTaskItDemoCommand >> initialize [
	super initialize.
	cancelRequested := false.
	wasCanceled := false.
]

{ #category : #'api - execution' }
BlTaskItDemoCommand >> result [
	"I do not have a meanigful result"
	^ nil
]

{ #category : #'api - testing' }
BlTaskItDemoCommand >> wasCanceled [
	"Answer whether an execution was canceled"
	<return: #Boolean>
	^ wasCanceled
]
