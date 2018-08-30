Class {
	#name : #BlTaskItTaskExamples,
	#superclass : #Object,
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'cancellable task' }
BlTaskItTaskExamples >> addCancellableTaskToTheElementWithoutSpace [
	<gtExample>
	| anElement aWaitingElement aCancelButton anExecuteButton aCleaningBlock aTask anAction aStop aStep |
	anElement := self progress.
	anAction := BlTaskItDemoCommand new.
	aWaitingElement := self waitingElement.
	aCleaningBlock := [ :anElementName | 
		anElement childNamed: anElementName ifFound: [ :aChild | aChild removeFromParent ] ifNone: [  ].
	].
	aTask := BlCancellableTaskItAction new.
	aTask action: anAction.
	aCancelButton := self cancelElement.
	aCancelButton
		addEventHandlerOn: BlClickEvent
		do: [ aTask cancelRequest ].
	anExecuteButton := self executeElement.
	anExecuteButton addEventHandlerOn: BlClickEvent
		do: [ anElement enqueueTask: (aTask action: BlTaskItDemoCommand new) ].
	aStop := 0.1.
	aStep := 0.01.
	aTask
		onRunEnqueueAction: [ 
			aCleaningBlock value: #text.
			aCleaningBlock value: #action.
			anElement addChild: aWaitingElement as: #text.
			anElement addChild: aCancelButton as: #action ].
	aTask
		onRunEnqueueRepeatedAction: [ aStop > 0.9
				ifTrue: [ aStep := aStep negated ].
			aStop < 0.1
				ifTrue: [ aStep := aStep negated ].
			aStop := aStop + aStep.
			anElement background: (self gradientBackgroundAt: aStop) ].
	aTask
		onNotification: BlExactProgress
		enqueueAction: [ :aProgress | 
			aWaitingElement removeFromParent.
			anElement children first
				constraintsDo: [ :c | c frame horizontal weight: aProgress fraction asFloat ] ].
	aTask
		onSuccessEnqueueAction: [ :aResult | 
			aCleaningBlock value: #text.
			aCleaningBlock value: #action.
			aTask wasCanceled
				ifTrue: [ 
					anElement addChild: self cancelledElement as: #text.
					anElement addChild: anExecuteButton as: #action.
					anElement children first
						constraintsDo: [ :c | c frame horizontal weight: 0 ] ]
				ifFalse: [ anElement addChild: self transferredElement as: #text ] ].
	aTask
		onFailureEnqueueAction: [ :anException | 
			aCleaningBlock value: #action.
			anElement addChild: self failureElement as: #text ].
	aTask
		onFinishEnqueueAction: [ 
			anElement background: self containerColor ].
	anElement enqueueTask: aTask.

	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: {aTask}.
	"it was not executed"
	self assert: aTask action equals: anAction.
	^ anElement
]

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

{ #category : #'notificable task' }
BlTaskItTaskExamples >> addNotificableTaskToTheElementWithoutSpace [
	<gtExample>
	| anElement aWaitingElement aTask anAction aStop aStep |
	anElement := self progress.
	aWaitingElement := self waitingElement.
	aTask := BlNotificableTaskItAction new.
	anAction := self transferringActionWithProgressNotification.
	aTask action: anAction.
	aStop := 0.1.
	aStep := 0.01.
	aTask onRunEnqueueAction: [ anElement addChild: aWaitingElement ].
	aTask
		onRunEnqueueRepeatedAction: [ aStop > 0.9
				ifTrue: [ aStep := aStep negated ].
			aStop < 0.1
				ifTrue: [ aStep := aStep negated ].
			aStop := aStop + aStep.
			anElement background: (self gradientBackgroundAt: aStop) ].
	aTask
		onNotification: BlExactProgress
		enqueueAction: [ :aProgress | 
			aWaitingElement removeFromParent.
			anElement children first
				constraintsDo: [ :c | c frame horizontal weight: aProgress fraction asFloat ] ].
	aTask
		onSuccessEnqueueAction: [ :aResult | anElement addChild: self transferredElement ].
	aTask
		onFailureEnqueueAction: [ :anException | anElement addChild: self failureElement ].
	aTask
		onFinishEnqueueAction: [ aWaitingElement removeFromParent.
			anElement background: self containerColor ].
	anElement enqueueTask: aTask.

	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: {aTask}.

	^ anElement
]

{ #category : #'notificable task' }
BlTaskItTaskExamples >> addSimpleNotificableTaskToTheElementWithoutSpace [
	<gtExample>
	| anElement aTask anAction |
	anElement := self progress.
	aTask := BlNotificableTaskItAction new.
	anAction := self transferringActionWithProgressNotification.
	aTask action: anAction.
	aTask
		onNotification: BlExactProgress
		enqueueAction: [ :aProgress | 
			anElement children first
				constraintsDo: [ :c | c frame horizontal weight: aProgress fraction asFloat ] ].
	aTask
		onSuccessEnqueueAction: [ :aResult | anElement addChild: self transferredElement ].
	aTask
		onFailureEnqueueAction: [ :anException | anElement addChild: self failureElement ].
	anElement enqueueTask: aTask.

	"task was added to the local task queue"
	self assert: anElement taskQueue tasks asArray equals: {aTask}.

	^ anElement
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> cancelElement [
	<gtExample>
	^ BlElement new 
			geometry: BlCircle new;
			size: 12@12;
			background: Color red;
			constraintsDo: [ :c | 
				c frame horizontal alignRight.
				c frame vertical alignCenter ]
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> cancelledElement [
	<gtExample>
	^ BlTextElement new 
			text: 'cancelled' asRopedText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> container [
	<gtExample>
	^ self element
		padding: (BlInsets all: 10);
		background: self containerColor
]

{ #category : #colors }
BlTaskItTaskExamples >> containerColor [
	<gtExample>
	^ Color gray
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> element [
	<gtExample>
	
	^ BlElement new
]

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> elementWithFailure [
	<gtExample>
	| anElement aTask |
	anElement := BlElement new.
	anElement
		size: 300 @ 300;
		relocate: 10 @ 10;
		background: Color blue.
	aTask := BlEnqueuedTaskItAction new.
	aTask
		action: [ 10
				timesRepeat: [ 150 milliSeconds wait.
					anElement
						enqueueTask: (BlTaskAction new action: [ anElement background: Color random ]) ].
			Error signal ].
	aTask
		onSuccessEnqueueAction: [ :aResult | anElement background: Color green ].
	aTask
		onFailureEnqueueAction: [ :anException | anElement background: Color red ].
	anElement enqueueTask: aTask.
	^ anElement
]

{ #category : #'enqueued task' }
BlTaskItTaskExamples >> elementWithSuccessfulResult [
	<gtExample>
	| anElement aTask |
	anElement := BlElement new.
	anElement
		size: 300 @ 300;
		relocate: 10 @ 10;
		background: Color blue.
	aTask := BlEnqueuedTaskItAction new.
	aTask
		action: [ 10
				timesRepeat: [ 150 milliSeconds wait.
					anElement
						enqueueTask: (BlTaskAction new action: [ anElement background: Color random ]) ] ].
	aTask
		onSuccessEnqueueAction: [ :aResult | anElement background: Color green ].
	aTask
		onFailureEnqueueAction: [ :anException | anElement background: Color red ].
	anElement enqueueTask: aTask.
	^ anElement
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> executeElement [
	<gtExample>
	^ BlElement new 
			geometry: BlCircle new;
			size: 12@12;
			background: Color green;
			constraintsDo: [ :c | 
				c frame horizontal alignLeft.
				c frame vertical alignCenter ]
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> failureElement [
	<gtExample>
	^ BlTextElement new 
			text: 'failure' asRopedText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
]

{ #category : #colors }
BlTaskItTaskExamples >> gradientBackgroundAt: aStop [
	^ BlLinearGradientPaint new
						stops:
							{(0.0 -> Color gray).
							(aStop -> Color gray muchLighter).
							(1.0 -> Color gray)};
						start: 0@0;
						end: 1@1
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> indicator [
	<gtExample>
	
	^ self element
		background: (Color white alpha: 0.5)
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> progress [
	<gtExample>
	| anYellowElement aContainerElement |
	
	anYellowElement := self indicator
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent.
			c frame horizontal alignLeft.
			c frame vertical alignCenter.
			c frame horizontal weight: 0.0 ].

	aContainerElement := self container
		layout: BlFrameLayout new;
		size: 350@50;
		relocate: 10@10;
		addChild: anYellowElement.
	
	^ aContainerElement
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

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> transferredElement [
	<gtExample>
	^ BlTextElement new 
			text: 'transferred' asRopedText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
]

{ #category : #'notificable task' }
BlTaskItTaskExamples >> transferringActionWithProgressNotification [
	<gtExample>
	^ [ 
		3 seconds wait. 
		1 to: 20 do: [ :each |
			BlExactProgress signal: 'Transferring...' amount: each * 1024 total: 20*1024.
			(Delay forMilliseconds: 100) wait ] ]
]

{ #category : #'element instance creation' }
BlTaskItTaskExamples >> waitingElement [
	<gtExample>
	^ BlTextElement new 
			text: 'waiting...' asRopedText;
			constraintsDo: [ :c | 
				c frame horizontal alignCenter.
				c frame vertical alignCenter ]
]
