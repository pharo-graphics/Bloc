Class {
	#name : #BlTaskAtPostponedTerminableFuture,
	#superclass : #BlTaskAtPostponedTerminableTask,
	#instVars : [
		'onSuccess',
		'onFailure'
	],
	#category : #'Bloc-TaskIt-Postponed Tasks'
}

{ #category : #initialization }
BlTaskAtPostponedTerminableFuture >> initialize [
	super initialize.
	onFailure := OrderedCollection new: 2.
	onSuccess := OrderedCollection new: 2.
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onFailure [
	<return: #Collection>
	^ onFailure
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onFailureDo: aBlock [
	onFailure add: aBlock
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onSuccess [
	<return: #Collection>
	^ onSuccess
]

{ #category : #accessing }
BlTaskAtPostponedTerminableFuture >> onSuccessDo: aBlock [
	onSuccess add: aBlock
]

{ #category : #evaluating }
BlTaskAtPostponedTerminableFuture >> privateExecute [
	| aFuture |
	aFuture := self pool future: self command.
	self onSuccess do: [ :eachCallback | 
		aFuture onSuccessDo: eachCallback ].
	self onFailure do: [ :eachCallback | 
		aFuture onFailureDo: eachCallback ].
	
]
