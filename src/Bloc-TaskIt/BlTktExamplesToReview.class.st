Class {
	#name : #BlTktExamplesToReview,
	#superclass : #Object,
	#instVars : [
		'collector',
		'worker',
		'signaler',
		'uiWorkerPool'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'examples - announcing commands' }
BlTktExamplesToReview >> announcingAndResponsiveCommand [
	<gtExample>
	| aResponsiveCommand anAnnouncingCommand |
	aResponsiveCommand := self responsiveValuableCommand.
	anAnnouncingCommand := aResponsiveCommand asAnnouncingCommand. 
	self assert: anAnnouncingCommand class equals: BlTktAnnouncingCommand.
	self assert: anAnnouncingCommand command equals: aResponsiveCommand.
	self assert: (anAnnouncingCommand name includesSubstring: aResponsiveCommand name).
	self assert: anAnnouncingCommand announcer isNotNil.
	^ anAnnouncingCommand
]

{ #category : #accessing }
BlTktExamplesToReview >> collector [
	<return: #BlTktExamplesCollector>
	^ collector
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> ensureIsStarted: aWorker [
	aWorker isRunning ifFalse: [ aWorker start ]
]

{ #category : #'examples - announcing commands' }
BlTktExamplesToReview >> executeAnnouncingAndResponsiveCommand [
	<gtExample>
	| anAnnouncingCommand aResult |
	anAnnouncingCommand := self announcingAndResponsiveCommand. 
	anAnnouncingCommand announcer
		when: BlTktCommandAnnouncement do: [ :anAnnouncement | self collector add: anAnnouncement ].
	self assert: self collector collection size equals: 0.
	aResult := anAnnouncingCommand value.
	self assert: aResult equals: 2.
	self assert: self collector collection size equals: 3.
	self assert: self collector collection first class equals: BlTktCommandAboutToExecuteAnnouncement.
	self assert: self collector collection first command equals: anAnnouncingCommand.
	self assert: self collector collection second equals: 2.
	self assert: self collector collection third class equals: BlTktCommandAboutToFinishAnnouncement.
	self assert: self collector collection third command equals: anAnnouncingCommand.
	self assert: self collector collection third result equals: aResult.
	^ anAnnouncingCommand
]

{ #category : #'examples - tasks' }
BlTktExamplesToReview >> executeResponsiveCommandTask [
	<gtExample>
	| aTask aWorker aFuture aResult |
	aTask := self responsiveCommandTask.
	aWorker := self worker.
	self ensureIsStarted: aWorker.
	aFuture := aWorker future: aTask.
	aResult := aFuture synchronizeTimeout: self futureTimeout.
	self assert: aResult equals: 1.
	^ aTask
]

{ #category : #'examples - basic commands' }
BlTktExamplesToReview >> executeResponsiveValuableCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self responsiveValuableCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	self assert: self collector collection size equals: 1.
	self assert: self collector collection first equals: 1.
	^ aCommand
]

{ #category : #'examples - basic commands' }
BlTktExamplesToReview >> executeUnresponsiveCommandWithTerminationRequest [
	<gtExample>
	| aCommand anExecution aResult |
	aCommand := self unresponsiveValuableCommand asBlTktTerminableCommand.
	anExecution := BlTktCommandTaskExecution new.
	aCommand taskExecution: anExecution.
	aCommand terminate.
	aResult := anExecution executeTask.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.
	^ aCommand
]

{ #category : #'examples - tasks' }
BlTktExamplesToReview >> executeUnresponsiveTaskTerminatingInTheMiddle [
	<gtExample>
	"TODO: We should have two worker pools, one for tasks, another for checkers."
	| aCommand aTask aWorkerPool aFuture aResult |
	aCommand := self unresponsiveCommandTerminatingInTheMiddle asBlTktTerminableCommand.
	aTask := aCommand asTask.
	aWorkerPool := self uiWorkerPool.
	aFuture := aWorkerPool future: aTask.
	self assert: aFuture isNotNil.
	self signaler waitForTask.
	self assert: self collector collection size equals: 1.
	aCommand terminate.
	self signaler signalCallerSemaphore.
	[ aResult := aFuture synchronizeTimeout: self futureTimeout ] 
		on: BlTktExplicitlyTerminatedTaskException
		do: [ :anException | 
			"We should receive an exception"
			self collector add: anException ].
	self assert: aResult isNil.
	self assert: self collector collection size equals: 2.
	self assert: self collector collection first equals: 1.
	self assert: self collector collection second class equals: BlTktExplicitlyTerminatedTaskException.
	^ aTask
]

{ #category : #'examples - basic commands' }
BlTktExamplesToReview >> executeUnresponsiveValuableCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveValuableCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	^ aCommand
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> futureTimeout [
	^ 1000 milliSeconds
]

{ #category : #initialization }
BlTktExamplesToReview >> initialize [
	super initialize.
	collector := BlTktExamplesCollector new.
	signaler := BlTktExamplesSignaler new.
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> newUIWorkerPool [
	<gtExample>
	| aWorkerPool |
	aWorkerPool := BlTktWorkerProvider new highUICPUBoundPool; exemplify; poolMaxSize: 1; pool.
	self assert: aWorkerPool name isNotNil.
	self assert: aWorkerPool poolMaxSize equals: 1.
	^ aWorkerPool
	
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> newWorker [
	<gtExample>
	| aName aWorker |
	aName := self className, ' Worker'.
	aWorker := BlTktCommandTaskWorker new name: aName.
	self assert: aWorker name equals: aName.
	^ aWorker
	
]

{ #category : #'examples - tasks' }
BlTktExamplesToReview >> responsiveCommandTask [
	<gtExample>
	| aCommand aTask |
	aCommand := self responsiveValuableCommand.
	aTask := aCommand asTask.
	self assert: aTask command command equals: aCommand.
	^ aTask
]

{ #category : #'examples - basic commands' }
BlTktExamplesToReview >> responsiveValuableCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ :aRequests | self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktResponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]

{ #category : #accessing }
BlTktExamplesToReview >> signaler [
	<return: #BlTktExamplesSignaler>
	^ signaler
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> stopUIWorkerPool [
	uiWorkerPool ifNotNil: [ :aWorkerPool | 
		aWorkerPool stop.
		aWorkerPool stopWatchDog ].
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> stopWorker [
	worker ifNotNil: [ :aWorker | aWorker stop ].
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> uiWorkerPool [
	<gtExample>
	<after: #stopUIWorkerPool>
	uiWorkerPool ifNil: [ uiWorkerPool := self newUIWorkerPool ].
	self assert: uiWorkerPool isNotNil.
	^ uiWorkerPool
]

{ #category : #'examples - tasks' }
BlTktExamplesToReview >> unresponsiveCommandTerminatingInTheMiddle [
	<gtExample>
	| aCommand aBlock |
	aCommand := BlTktUnresponsiveCommand new.
	aBlock := [ 
		self collector increment.
		self signaler signalTaskSemaphore.
		self signaler waitForCaller.
		self collector increment. ].
	aCommand valuable: aBlock.
	self assert: aCommand valuable equals: aBlock.
	^ aCommand
]

{ #category : #'examples - basic commands' }
BlTktExamplesToReview >> unresponsiveValuableCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktUnresponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]

{ #category : #'examples - worker' }
BlTktExamplesToReview >> worker [
	<gtExample>
	<after: #stopWorker>
	worker ifNil: [ worker := self newWorker ].
	self assert: worker isNotNil.
	^ worker
]
