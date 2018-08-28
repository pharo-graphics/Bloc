Class {
	#name : #BlTaskItTaskExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt'
}

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> addElementWithEnqueuedTaskToSpace [
	<gtExample>
	| anElement aSpace |

	anElement := self addEnqueuedTaskToTheElementWithoutSpace.
	
	aSpace := BlSpace new.
	
	aSpace root addChild: anElement.
	
	"task were moved to the space"
	self assert: anElement taskQueue tasks isEmpty.
	self assert: aSpace taskQueue tasks size equals: 1.

	"it was not executed yet"
	self assert: aSpace taskQueue tasks first action ~= 'done'. 

	^ aSpace
]

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> addEnqueuedTaskToTheElementWithoutSpace [
	<gtExample>
	| anElement aTask anAction |
	
	anElement := BlElement new.
	aTask := BlEnqueuedTaskItAction new.
	
	anAction := [ aTask action: 'done' ].
	aTask action: anAction.
	aTask onSuccessDo: [ :aResult | aTask action: (aTask action asString, '-success') ].
	aTask onFailureDo: [ :anException | aTask action: (aTask action asString, '-failure') ].
	
	anElement enqueueTask: aTask.
	
	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: { aTask }.
	"it was not executed"
	self assert: aTask action equals: anAction. 
	
	^ anElement
]

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> pulseSpaceWithEnqueuedTask [
	<gtExample>
	| aSpace aTask |

	aSpace := self addElementWithEnqueuedTaskToSpace.
	
	aTask := aSpace taskQueue tasks first.
	
	aSpace pulse.
	
	"task was run and queue is empty now"
	self assert: aSpace taskQueue tasks isEmpty.

	"action was executed"
	self assert: aTask future notNil.
	aTask future waitForCompletion: 1 second.
	self assert: aTask action equals: 'done-success'. 

	^ aSpace
]

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> pulseSpaceWithEnqueuedTaskThatFails [
	<gtExample>
	| aSpace aTask |

	aSpace := self addElementWithEnqueuedTaskToSpace.
	
	aTask := aSpace taskQueue tasks first.
	aTask action: [ aTask action: 'signalling'. Error signal ].
	
	aSpace pulse.
	
	"task was run and queue is empty now"
	self assert: aSpace taskQueue tasks isEmpty.

	"action was executed"
	self assert: aTask future notNil.
	aTask future waitForCompletion: 1 second.
	self assert: aTask action equals: 'signalling-failure'.

	^ aSpace
]

{ #category : #workflow }
BlTaskItTaskExamples >> rawTaskItWorkflow [
	<gtExample>
	
	| anElement aCollection anAction aTaskItTask aSuccessAction aFailureAction aFuture aSpace aSuccessTask aFailureTask |
	anElement := BlElement new.
	aCollection := OrderedCollection new.	
	anAction := [ aCollection add: #actionDone ].
	aSuccessAction := [ aCollection add: #success ].
	aSuccessTask := BlTaskAction new action: aSuccessAction.
	aFailureAction := [ aCollection add: #failure ].
	aFailureTask := BlTaskAction new action: aFailureAction.
	aTaskItTask := anAction asTask.
	aFuture := aTaskItTask future.
	aFuture onSuccessDo: [ :aResult | 
		anElement enqueueTask: aSuccessTask ].
	aFuture onFailureDo: [ :aResult | 
		anElement enqueueTask: aFailureTask ].

	"task was not added to the local task queue"
	self assert: anElement taskQueue tasks asArray isEmpty.
	"future value may or may not be executed"
	self assert: (aCollection includes: #actionDone) not.
	
	aFuture waitForCompletion: 1 second.
	"future value is already known"
	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: { aSuccessTask }.
	"it was not executed"
	self assert: aCollection size equals: 1.
	self assert: (aCollection includes: #actionDone).
	
	"Add the element to a space"
	aSpace := BlSpace new.
	aSpace root addChild: anElement.
	
	"task were moved to the space"
	self assert: anElement taskQueue tasks isEmpty.
	self assert: aSpace taskQueue tasks size equals: 1.

	"it was not executed yet"
	self assert: aCollection size equals: 1.
	self assert: (aCollection includes: #actionDone).

	"pulse space"
	aSpace pulse.
	
	"task was run and queue is empty now"
	self assert: aSpace taskQueue tasks isEmpty.

	"action was executed"
	self assert: aCollection size equals: 2.
	self assert: aCollection asArray equals: { #actionDone. #success }.

	^ aSpace
]
