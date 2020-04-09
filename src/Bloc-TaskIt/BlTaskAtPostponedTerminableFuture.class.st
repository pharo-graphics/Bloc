Class {
	#name : #BlTaskAtPostponedTerminableFuture,
	#superclass : #BlTaskAtPostponedTerminableTask,
	#instVars : [
		'onSuccess',
		'onFailure',
		'futureMutex',
		'future'
	],
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

{ #category : #handling }
BlTaskAtPostponedTerminableFuture >> handleNotScheduledBecauseOfPreviousTask: aBlTaskAtTask [
	self transferCallbacksTo: aBlTaskAtTask.
	super handleNotScheduledBecauseOfPreviousTask: aBlTaskAtTask
]

{ #category : #initialization }
BlTaskAtPostponedTerminableFuture >> initialize [
	super initialize.
	onFailure := OrderedCollection new: 2.
	onSuccess := OrderedCollection new: 2.
	futureMutex := Mutex new.
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onFailure [
	<return: #Collection>
	^ onFailure
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onFailureDo: aBlock [
	futureMutex critical: [ 
		future 
			ifNil: [ onFailure add: aBlock ]
			ifNotNil: [ future onFailureDo: aBlock ]
	]
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onSuccess [
	<return: #Collection>
	^ onSuccess
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onSuccessDo: aBlock [
	futureMutex critical: [ 
		future 
			ifNil: [ onSuccess add: aBlock ]
			ifNotNil: [ future onSuccessDo: aBlock ]
	]
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableFuture >> privateExecute [
	futureMutex critical: [ 
		future := self pool future: self command.
		self onSuccess do: [ :eachCallback | 
			future onSuccessDo: eachCallback ].
		self onFailure do: [ :eachCallback | 
			future onFailureDo: eachCallback ].
	]
]

{ #category : #private }
BlTaskAtPostponedTerminableFuture >> transferCallbacksTo: aBlTaskAtTask [
	aBlTaskAtTask class = self class ifFalse: [ ^ self ].
	self onSuccess
		do: [ :eachCallback | aBlTaskAtTask onSuccessDo: eachCallback ].
	self onFailure
		do: [ :eachCallback | aBlTaskAtTask onFailureDo: eachCallback ]
]
