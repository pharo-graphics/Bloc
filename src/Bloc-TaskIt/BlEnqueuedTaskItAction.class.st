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
BlEnqueuedTaskItAction >> action: anAction [
	action := anAction asBlTktCommand asBlTktLoggingCommand.
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
	self action: [ ].
	resultCallbacks := OrderedCollection new.
	exceptionCallbacks := OrderedCollection new.
	name := nil.

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
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) 
				asBeaconLoggingTask maySetName: 'Failute Action') ]
]

{ #category : #'api - callbacks' }
BlEnqueuedTaskItAction >> onFinishEnqueueAction: aCallback [
	self onFinishedDo: [ :aResultOrException | 
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResultOrException cull: self ]) 
				asBeaconLoggingTask maySetName: 'Finish Action') ]
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
		self element enqueueTask: ((BlTaskAction new 
			action: [ aCallback cull: aResult cull: self ]) 
				asBeaconLoggingTask maySetName: 'Success Action') ]
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
	<return: #TKTFuture>
	| aCommand |
	aCommand := self futureAction asBlTktCommand.
	self name ifNotNil: [ aCommand name: self name].
	^ BlTktWorkerProvider highUICPUBoundPool future: aCommand.
]
