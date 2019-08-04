"
GtInspector openOn: BlTaskItDemoCommand new
"
Class {
	#name : #BlTaskItDemoCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'wasCanceled',
		'shouldTerminate'
	],
	#category : #'Bloc-TaskIt-Commands'
}

{ #category : #taskit }
BlTaskItDemoCommand >> canHandleTerminationRequest [
	<return: #Boolean>
	^ true
]

{ #category : #'api - execution' }
BlTaskItDemoCommand >> execute [
	1 to: 20 do: [ :each |
		self shouldTerminate ifTrue: [ wasCanceled := true. ^ self ].
		(Delay forMilliseconds: 100) wait ]. 
	1 to: 20 do: [ :each |
		self shouldTerminate ifTrue: [ wasCanceled := true. ^ self ].
		BlTaskProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
		(Delay forMilliseconds: 100) wait ]
]

{ #category : #initialization }
BlTaskItDemoCommand >> initialize [
	super initialize.
	wasCanceled := false.
	shouldTerminate := false.
	name := 'Bloc TaskIt Demo Command'.
]

{ #category : #accessing }
BlTaskItDemoCommand >> shouldTerminate [
	<return: #Boolean>
	^ shouldTerminate
]

{ #category : #actions }
BlTaskItDemoCommand >> terminate [
	shouldTerminate := true
]

{ #category : #actions }
BlTaskItDemoCommand >> terminateWithReason: aReason [
	shouldTerminate := true
]

{ #category : #accessing }
BlTaskItDemoCommand >> wasCanceled [
	^ wasCanceled
]
