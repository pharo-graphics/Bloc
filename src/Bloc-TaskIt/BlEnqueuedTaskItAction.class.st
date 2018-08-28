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

{ #category : #callbacks }
BlEnqueuedTaskItAction >> onFailureDo: aCallback [
	exceptionCallbacks add: aCallback
]

{ #category : #callbacks }
BlEnqueuedTaskItAction >> onSuccessDo: aCallback [
	resultCallbacks add: aCallback
]

{ #category : #'api - running' }
BlEnqueuedTaskItAction >> run [
	future := self action asTask future.
	resultCallbacks do: [ :eachCallback | future onSuccessDo: eachCallback ].
	exceptionCallbacks do: [ :eachCallback | future onFailureDo: eachCallback ].
	
]
