"
GtInspector openOn: BlTaskItDemoCommand new
"
Class {
	#name : #BlTktDemoResponsiveCommand,
	#superclass : #BlTktCommand,
	#instVars : [
		'wasCanceled',
		'shouldTerminate'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #taskit }
BlTktDemoResponsiveCommand >> canHandleTerminationRequest [
	<return: #Boolean>
	^ true
]

{ #category : #'api - execution' }
BlTktDemoResponsiveCommand >> execute [
	1 to: 20 do: [ :each |
		self shouldTerminate ifTrue: [ wasCanceled := true. ^ self ].
		(Delay forMilliseconds: 100) wait ]. 
	1 to: 20 do: [ :each |
		self shouldTerminate ifTrue: [ wasCanceled := true. ^ self ].
		BlTaskProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
		(Delay forMilliseconds: 100) wait ]
]

{ #category : #initialization }
BlTktDemoResponsiveCommand >> initialize [
	super initialize.
	wasCanceled := false.
	shouldTerminate := false.
	name := 'Bloc TaskIt Demo Command'.
]

{ #category : #accessing }
BlTktDemoResponsiveCommand >> shouldTerminate [
	<return: #Boolean>
	^ shouldTerminate
]

{ #category : #actions }
BlTktDemoResponsiveCommand >> terminate [
	shouldTerminate := true
]

{ #category : #actions }
BlTktDemoResponsiveCommand >> terminateWithReason: aReason [
	shouldTerminate := true
]

{ #category : #accessing }
BlTktDemoResponsiveCommand >> wasCanceled [
	^ wasCanceled
]
