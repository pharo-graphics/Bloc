Class {
	#name : #BlTktExamples,
	#superclass : #Object,
	#instVars : [
		'collector',
		'signaler',
		'uiWorkerPool'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'examples - task terminations' }
BlTktExamples >> basicCommandTaskExecution [
	<gtExample>
	| anExecution |
	anExecution := BlTktCommandTaskExecution new.
	self assert: anExecution state class equals: TKTReadyTaskState.
	self assert: anExecution executionProcess isNil.
	self assert: anExecution task isNil.
	^ anExecution
]

{ #category : #accessing }
BlTktExamples >> collector [
	<return: #BlTktExamplesCollector>
	^ collector
]

{ #category : #'examples - commands' }
BlTktExamples >> executeResponsiveValuableCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self responsiveValuableCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	self assert: self collector collection size equals: 1.
	self assert: self collector collection first equals: 1.
	^ aCommand
]

{ #category : #'examples - command tasks' }
BlTktExamples >> executeResponsiveValuableCommandTask [
	<gtExample>
	| aTask aPool aFuture aResult |
	aTask := self responsiveValuableCommandTask.
	aPool := self uiWorkerPool.
	aFuture := aPool future: aTask.
	aResult := aFuture synchronizeTimeout: self futureTimeout.
	self assert: aResult equals: 1.
	^ aTask
]

{ #category : #'examples - task terminations' }
BlTktExamples >> executeTerminatedTerminableUnresponsiveValuableCommandInCancelledState [
	<gtExample>
	| aCommand aResult |
	aCommand := self terminateTerminableUnresponsiveValuableCommandInCancelledState.
	aResult := [ aCommand taskExecution executeTask ] 
		on: TKTCancelledTaskException do: [ :anException | self collector add: anException. anException ].
	self assert: aResult isNotNil.
	self assert: self collector collection size equals: 1.
	self assert: self collector collection first equals: aResult.
	self assert: aResult class equals: TKTCancelledTaskException.	
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> executeTerminatedTerminableUnresponsiveValuableCommandInFinishedState [
	<gtExample>
	| aCommand aResult |
	aCommand := self terminateTerminableUnresponsiveValuableCommandInFinishedState.
	aResult := [ aCommand taskExecution executeTask ] 
		on: Error do: [ :anException | self collector add: anException. anException ].
	self assert: aResult isNotNil.
	self assert: self collector collection size equals: 1.
	self assert: self collector collection first equals: aResult.
	self assert: aResult class equals: Error.	
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> executeTerminatedTerminableUnresponsiveValuableCommandInReadyState [
	<gtExample>
	| aCommand aResult |
	aCommand := self terminateTerminableUnresponsiveValuableCommandInReadyState.
	aResult := aCommand taskExecution executeTask.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.	
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> executeTerminatedTerminableUnresponsiveValuableCommandInRunningState [
	<gtExample>
	| aCommand aResult |
	aCommand := self terminateTerminableUnresponsiveValuableCommandInRunningState.
	aResult := aCommand taskExecution executeTask.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.	
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> executeTerminatedTerminableUnresponsiveValuableCommandInTerminatedState [
	<gtExample>
	| aCommand aResult |
	aCommand := self terminateTerminableUnresponsiveValuableCommandInTerminatedState.
	aResult := aCommand taskExecution executeTask.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.	
	^ aCommand
]

{ #category : #'examples - commands' }
BlTktExamples >> executeUnresponsiveValuableCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveValuableCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	^ aCommand
]

{ #category : #'examples - command tasks' }
BlTktExamples >> futureTimeout [
	^ 1000 milliSeconds
]

{ #category : #initialization }
BlTktExamples >> initialize [
	super initialize.
	collector := BlTktExamplesCollector new.
	signaler := BlTktExamplesSignaler new.
]

{ #category : #'examples - workers' }
BlTktExamples >> newUIWorkerPool [
	<gtExample>
	| aWorkerPool |
	aWorkerPool := BlTktWorkerProvider new highUICPUBoundPool; exemplify; poolMaxSize: 1; pool.
	self assert: aWorkerPool name isNotNil.
	self assert: aWorkerPool poolMaxSize equals: 1.
	^ aWorkerPool
	
]

{ #category : #'examples - commands' }
BlTktExamples >> responsiveDemoCommand [
	<gtExample>
	| aCommand |
	aCommand := BlTktDemoResponsiveCommand new.
	self assert: aCommand shouldTerminate not.
	self assert: aCommand wasCanceled not.
	self assert: aCommand name isNotNil.
	self assert: aCommand name isNotEmpty.
	^ aCommand
]

{ #category : #'examples - commands' }
BlTktExamples >> responsiveValuableCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ :aRequests | self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktResponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]

{ #category : #'examples - command tasks' }
BlTktExamples >> responsiveValuableCommandTask [
	<gtExample>
	| aCommand aTask |
	aCommand := self responsiveValuableCommand.
	aTask := aCommand asTask.
	self assert: aTask command command equals: aCommand.
	^ aTask
]

{ #category : #'examples - command tasks' }
BlTktExamples >> scheduleTerminableUnresponsiveValuableTaskTerminatingInTheMiddle [
	<gtExample>
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

{ #category : #accessing }
BlTktExamples >> signaler [
	<return: #BlTktExamplesSignaler>
	^ signaler
]

{ #category : #'examples - workers' }
BlTktExamples >> stopUIWorkerPool [
	uiWorkerPool ifNotNil: [ :aWorkerPool | 
		aWorkerPool stop.
		aWorkerPool killWatchDog ].
]

{ #category : #'examples - commands' }
BlTktExamples >> terminableUnresponsiveValuableCommand [
	<gtExample>
	| aCommand aTerminableCommand |
	aCommand := self unresponsiveValuableCommand.
	aTerminableCommand := aCommand asBlTktTerminableCommand.
	self assert: aTerminableCommand command equals: aCommand.
	self assert: aTerminableCommand command equals: aCommand.
	self assert: aTerminableCommand taskExecution isNil.
	self assert: aTerminableCommand name isNotNil.
	self assert: aTerminableCommand name isNotEmpty.
	^ aTerminableCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> terminateTerminableUnresponsiveValuableCommandInCancelledState [
	<gtExample>
	| aCommand anExecution |
	aCommand := self terminableUnresponsiveValuableCommand.
	anExecution := self basicCommandTaskExecution.
	anExecution setCancelStateWithReason: ''.
	aCommand taskExecution: anExecution.
	self assert: aCommand taskExecution equals: anExecution.
	aCommand terminate.
	self assert: anExecution state class equals: TKTCancelledTaskState.
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> terminateTerminableUnresponsiveValuableCommandInFinishedState [
	<gtExample>
	| aCommand anExecution |
	aCommand := self terminableUnresponsiveValuableCommand.
	anExecution := self basicCommandTaskExecution.
	anExecution setFinishedState.
	aCommand taskExecution: anExecution.
	self assert: aCommand taskExecution equals: anExecution.
	aCommand terminate.
	self assert: anExecution state class equals: TKTFinishedTaskState.
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> terminateTerminableUnresponsiveValuableCommandInReadyState [
	<gtExample>
	| aCommand anExecution |
	aCommand := self terminableUnresponsiveValuableCommand.
	anExecution := self basicCommandTaskExecution.
	aCommand taskExecution: anExecution.
	self assert: aCommand taskExecution equals: anExecution.
	aCommand terminate.
	self assert: anExecution state class equals: BlTktExplicitlyTerminatedTaskState.
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> terminateTerminableUnresponsiveValuableCommandInRunningState [
	<gtExample>
	| aCommand anExecution aProcess |
	aCommand := self terminableUnresponsiveValuableCommand.
	anExecution := self basicCommandTaskExecution.
	anExecution setRunningState.
	aProcess := [ self collector increment ] newProcess.
	aProcess name: 'Example of Terminable Task'.
	anExecution executionProcess: aProcess.
	self assert: anExecution executionProcess equals: aProcess.
	aCommand taskExecution: anExecution.
	self assert: aCommand taskExecution equals: anExecution.
	aCommand terminate.
	self assert: anExecution state class equals: BlTktExplicitlyTerminatedTaskState.
	^ aCommand
]

{ #category : #'examples - task terminations' }
BlTktExamples >> terminateTerminableUnresponsiveValuableCommandInTerminatedState [
	<gtExample>
	| aCommand anExecution |
	aCommand := self terminableUnresponsiveValuableCommand.
	anExecution := self basicCommandTaskExecution.
	anExecution setExplicitlyTerminatedStateWithReason: ''.
	aCommand taskExecution: anExecution.
	self assert: aCommand taskExecution equals: anExecution.
	aCommand terminate.
	self assert: anExecution state class equals: BlTktExplicitlyTerminatedTaskState.
	^ aCommand
]

{ #category : #'examples - workers' }
BlTktExamples >> uiWorkerPool [
	<gtExample>
	<after: #stopUIWorkerPool>
	uiWorkerPool ifNil: [ uiWorkerPool := self newUIWorkerPool ].
	self assert: uiWorkerPool isNotNil.
	^ uiWorkerPool
]

{ #category : #'examples - commands' }
BlTktExamples >> unresponsiveValuableCommand [
	<gtExample>
	| aBlock aCommand |
	aBlock := [ self collector increment ].
	aCommand := aBlock asBlTktCommand.
	self assert: aCommand class equals: BlTktUnresponsiveCommand.
	self assert: aCommand valuable equals: aBlock.
	self assert: aCommand name equals: aBlock printString.
	^ aCommand
]
