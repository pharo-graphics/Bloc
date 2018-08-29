Class {
	#name : #BlEnqueuedTaskItAction,
	#superclass : #BlTaskItTask,
	#instVars : [
		'action',
		'resultCallbacks',
		'exceptionCallbacks'
	],
	#category : #'Bloc-TaskIt'
}

{ #category : #accessing }
BlEnqueuedTaskItAction >> action [
	^ action
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> action: anObject [
	action := anObject.
]

{ #category : #initialization }
BlEnqueuedTaskItAction >> initialize [
	super initialize.
	action := [ ].
	resultCallbacks := OrderedCollection new.
	exceptionCallbacks := OrderedCollection new.

]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFailureDo: aCallback [
	exceptionCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFailureEnqueueAction: aCallback in: anElement [
	self onFailureDo: [ :aResult | 
		anElement enqueueTask: (BlTaskAction new action: [ aCallback value: aResult ]) ]
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onSuccessDo: aCallback [
	resultCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onSuccessEnqueueAction: aCallback in: anElement [
	self onSuccessDo: [ :aResult | 
		anElement enqueueTask: (BlTaskAction new action: [ aCallback value: aResult ]) ]
]

{ #category : #'api - running' }
BlEnqueuedTaskItAction >> run [
	future := self runFuture.
	resultCallbacks
		do: [ :eachCallback | future onSuccessDo: eachCallback ].
	exceptionCallbacks
		do: [ :eachCallback | future onFailureDo: eachCallback ]
]

{ #category : #'api - running' }
BlEnqueuedTaskItAction >> runFuture [
	^ self action asTask future
]
