Class {
	#name : #BlTktExamples,
	#superclass : #Object,
	#instVars : [
		'collector',
		'signaler'
	],
	#category : #'Bloc-TaskIt-Examples'
}

{ #category : #'examples - task executions' }
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

{ #category : #'examples - commands' }
BlTktExamples >> executeUnresponsiveValuableCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveValuableCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	^ aCommand
]

{ #category : #initialization }
BlTktExamples >> initialize [
	super initialize.
	collector := BlTktExamplesCollector new.
	signaler := BlTktExamplesSignaler new.
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

{ #category : #accessing }
BlTktExamples >> signaler [
	<return: #BlTktExamplesSignaler>
	^ signaler
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

{ #category : #'examples - task executions' }
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

{ #category : #'examples - task executions' }
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

{ #category : #'examples - task executions' }
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

{ #category : #'examples - task executions' }
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

{ #category : #'examples - task executions' }
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

{ #category : #'examples - commands' }
BlTktExamples >> terminateUnresponsiveCommandInReadyState [
	<gtExample>
	| aCommand anExecution aResult |
	aCommand := self unresponsiveValuableCommand asBlTktTerminableCommand.
	anExecution := self basicCommandTaskExecution.
	aCommand taskExecution: anExecution.
	aCommand terminate.
	aResult := anExecution executeTask.
	self assert: aResult isNil.
	self assert: self collector collection isEmpty.
	^ aCommand
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
