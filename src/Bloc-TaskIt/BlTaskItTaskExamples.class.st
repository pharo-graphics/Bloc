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

{ #category : #element }
BlTaskItTaskExamples >> elementWithFailure [
	<gtExample>
	| anElement aTask |
	anElement := BlElement new.
	anElement 
		size: 300@300;
		relocate: 10@10;
		background: Color blue.
	aTask := BlEnqueuedTaskItAction new.
	aTask action: [ 
		10 timesRepeat: [ 
			150 milliSeconds wait.
			anElement background: Color random ].
		Error signal ].
	aTask onSuccessEnqueueTaskAction: [ anElement background: Color green ] in: anElement. 
	aTask onFailureEnqueueTaskAction: [ anElement background: Color red ] in: anElement.
	anElement enqueueTask: aTask.
	^ anElement.
]

{ #category : #element }
BlTaskItTaskExamples >> elementWithRandomTermination [
	<gtExample>
	| anElement aTask aTerminateRequest |
	aTerminateRequest := false.
	anElement := BlElement new.
	anElement 
		size: 300@300;
		relocate: 10@10;
		background: Color blue.
	aTask := BlEnqueuedTaskItAction new.
	"long-lasting action"
	aTask action: [ | anIndex |
		anIndex := 1.
		[ 	anIndex := anIndex + 1. 
			anIndex < 100 and: [ aTerminateRequest not ] 
		] whileTrue: [ 
			150 milliSeconds wait.
			anElement background: Color random ] ].
	"Executed when a long-lasting action starts, 
	it might be before or after as both happen in different processes"
	aTask onStart: [ anElement border: (BlBorder builder width: 3; paint: Color black) ].
	"To indicate a task progress, e.g. HTTPProgress"
	aTask onProgressEnqueueTaskAction: [ :aProgress | 
		anElement border: (BlBorder builder width: 3; paint: Color atRandom) ] in: anElement.
	"if the task is finish successfully"
	aTask onSuccessEnqueueTaskAction: [ anElement background: Color green ] in: anElement. 
	"if the task fails"
	aTask onFailureEnqueueTaskAction: [ anElement background: Color red ] in: anElement.
	aTask onTerminationEnqueueTaskAction: [ anElement background: Color yellow ] in: anElement.
	anElement enqueueTask: aTask.
	10 atRandom < 5 ifTrue: [ aTask requestTermination ].
	^ anElement.
]

{ #category : #element }
BlTaskItTaskExamples >> elementWithSuccessfulResult [
	<gtExample>
	| anElement aTask |
	anElement := BlElement new.
	anElement 
		size: 300@300;
		relocate: 10@10;
		background: Color blue.
	aTask := BlEnqueuedTaskItAction new.
	aTask action: [ 
		10 timesRepeat: [ 
			150 milliSeconds wait.
			anElement background: Color random ] ].
	aTask onSuccessEnqueueTaskAction: [ anElement background: Color green ] in: anElement. 
	aTask onFailureEnqueueTaskAction: [ anElement background: Color red ] in: anElement.
	anElement enqueueTask: aTask.
	^ anElement.
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
