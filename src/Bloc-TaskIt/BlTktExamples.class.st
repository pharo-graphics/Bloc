Class {
	#name : #BlTktExamples,
	#superclass : #Object,
	#instVars : [
		'collector',
		'worker',
		'signaler'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #'examples - announcing commands' }
BlTktExamples >> announcingAndResponsiveCommand [
	<gtExample>
	| aResponsiveCommand anAnnouncingCommand |
	aResponsiveCommand := self responsiveCommand.
	anAnnouncingCommand := aResponsiveCommand asAnnouncingCommand. 
	self assert: anAnnouncingCommand class equals: BlTktAnnouncingCommand.
	self assert: anAnnouncingCommand command equals: aResponsiveCommand.
	self assert: (anAnnouncingCommand name includesSubstring: aResponsiveCommand name).
	self assert: anAnnouncingCommand announcer isNotNil.
	^ anAnnouncingCommand
]

{ #category : #accessing }
BlTktExamples >> collector [
	<return: #BlTktExamplesCollector>
	^ collector
]

{ #category : #'examples - announcing commands' }
BlTktExamples >> executeAnnouncingAndResponsiveCommand [
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

{ #category : #'examples - basic commands' }
BlTktExamples >> executeResponsiveCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self responsiveCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	self assert: self collector collection size equals: 1.
	self assert: self collector collection first equals: 1.
	^ aCommand
]

{ #category : #'examples - tasks' }
BlTktExamples >> executeResponsiveCommandTask [
	<gtExample>
	| aTask aWorker aFuture aResult |
	aTask := self responsiveCommandTask.
	aWorker := self worker.
	aFuture := aWorker future: aTask.
	aResult := aFuture synchronizeTimeout: self futureTimeout.
	self assert: aResult equals: 1.
	^ aTask
]

{ #category : #'examples - basic commands' }
BlTktExamples >> executeResponsiveCommandWithSuspendRequest [
	<gtExample>
	| aCommand aResult |
	aCommand := self responsiveCommand.
	aCommand suspendRequested.
	aResult := aCommand value.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.
	^ aCommand
]

{ #category : #'examples - basic commands' }
BlTktExamples >> executeUnresponsiveCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	^ aCommand
]

{ #category : #'examples - basic commands' }
BlTktExamples >> executeUnresponsiveCommandWithTerminationRequest [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveCommand.
	aCommand terminationRequested.
	aResult := aCommand value.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.
	^ aCommand
]

{ #category : #'examples - tasks' }
BlTktExamples >> executeUnresponsiveTaskTerminatingInTheMiddle [
	<gtExample>
	<noTest>
	"TODO: It cannot work because TKTWorker executes one task, then another. We need WorkerPool"
	| aTask aWorker aFuture aResult |
	aTask := self unresponsiveCommandTerminatingInTheMiddle asTask.
	aWorker := self worker.
	aFuture := aWorker future: aTask.
	self assert: aFuture isNotNil.
	self signaler waitForTask.
	self assert: self collector collection size equals: 1.
	self signaler signalCallerSemaphore.
	aResult := aFuture synchronizeTimeout: self futureTimeout.
	self assert: aResult isNil.
	self assert: self collector collection size equals: 1.
	^ aTask
]

{ #category : #'examples - worker' }
BlTktExamples >> futureTimeout [
	^ 1000 milliSeconds
]

{ #category : #initialization }
BlTktExamples >> initialize [
	super initialize.
	collector := BlTktExamplesCollector new.
	signaler := BlTktExamplesSignaler new.
]

{ #category : #'examples - basic commands' }
BlTktExamples >> responsiveCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ :aRequests | self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktResponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]

{ #category : #'examples - tasks' }
BlTktExamples >> responsiveCommandTask [
	<gtExample>
	| aCommand aTask |
	aCommand := self responsiveCommand.
	aTask := aCommand asTask.
	self assert: aTask command equals: aCommand.
	^ aTask
]

{ #category : #accessing }
BlTktExamples >> signaler [
	<return: #BlTktExamplesSignaler>
	^ signaler
]

{ #category : #'examples - worker' }
BlTktExamples >> stopWorker [
	<gtExample>
	<after: #stopWorker>
	worker ifNotNil: [ :aWorker | aWorker stop ].
]

{ #category : #'examples - basic commands' }
BlTktExamples >> unresponsiveCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktUnresponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]

{ #category : #'examples - tasks' }
BlTktExamples >> unresponsiveCommandTerminatingInTheMiddle [
	<gtExample>
	| aCommand aBlock |
	aCommand := BlTktUnresponsiveCommand new.
	aBlock := [ 
		self collector increment.
		aCommand terminationRequested.
		self signaler signalTaskSemaphore.
		100 milliSeconds wait.
		self signaler waitForCaller.
		self collector increment ].
	aCommand valuable: aBlock.
	self assert: aCommand valuable equals: aBlock.
	^ aCommand
]

{ #category : #'examples - worker' }
BlTktExamples >> worker [
	<gtExample>
	<after: #stopWorker>
	worker ifNil: [ worker := BlTktCommandTaskWorker new name: self className, ' Worker'; start ].
	self assert: worker isNotNil.
	^ worker
]
