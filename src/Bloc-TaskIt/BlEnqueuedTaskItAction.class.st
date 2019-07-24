Class {
	#name : #BlEnqueuedTaskItAction,
	#superclass : #BlElementTask,
	#instVars : [
		'action',
		'resultCallbacks',
		'exceptionCallbacks',
		'element',
		'name'
	],
	#category : #'Bloc-TaskIt-Element Tasks'
}

{ #category : #accessing }
BlEnqueuedTaskItAction >> action [
	^ action
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> action: anObject [
	action := anObject.
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> element [
	<return: #BlElement>

	^ element
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> element: aBlElement [
	element := aBlElement
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> futureAction [
	^ self action
]

{ #category : #initialization }
BlEnqueuedTaskItAction >> initialize [
	super initialize.
	action := [ ].
	resultCallbacks := OrderedCollection new.
	exceptionCallbacks := OrderedCollection new.

]

{ #category : #accessing }
BlEnqueuedTaskItAction >> name [
	^ name
]

{ #category : #accessing }
BlEnqueuedTaskItAction >> name: anObject [
	name := anObject
]

{ #category : #hooks }
BlEnqueuedTaskItAction >> onEnqueuedInElement: aBlElement [
	self element: aBlElement
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFailureDo: aCallback [
	exceptionCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFailureEnqueueAction: aCallback [
	self onFailureDo: [ :aResult | 
		self element enqueueTask: (BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) ]
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFinishEnqueueAction: aCallback [
	self onFinishedDo: [ :aResultOrException | 
		self element enqueueTask: (BlTaskAction new 
			action: [ aCallback cull: aResultOrException cull: self ]) ]
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFinishedDo: aCallback [
	self onSuccessDo: aCallback.
	self onFailureDo: aCallback.
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onSuccessDo: aCallback [
	resultCallbacks add: aCallback
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onSuccessEnqueueAction: aCallback [
	self onSuccessDo: [ :aResult | 
		self element enqueueTask: (BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) ]
]

{ #category : #'api - running' }
BlEnqueuedTaskItAction >> run [
	future := self runFuture.
	resultCallbacks
		do: [ :eachCallback | future onSuccessDo: eachCallback asLoggingTask ].
	exceptionCallbacks
		do: [ :eachCallback | future onFailureDo: eachCallback asLoggingTask ]
]

{ #category : #'api - running' }
BlEnqueuedTaskItAction >> runFuture [
	<return: #TKTFuture>
	| aCommand |
	aCommand := self futureAction asBlTktCommand.
	self name ifNotNil: [ aCommand name: self name].
	self element ifNotNil: [ aCommand invocatedByElement: self element ].
	^ BlTktUIWorkerPool default future: aCommand.
]
