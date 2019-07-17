Class {
	#name : #BlTktExamples,
	#superclass : #Object,
	#instVars : [
		'collector'
	],
	#category : #'Bloc-TaskIt-New Implementation'
}

{ #category : #accessing }
BlTktExamples >> collector [
	<return: #BlTktExampleCollector>
	^ collector
]

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
BlTktExamples >> executeUnresponsiveCommand [
	<gtExample>
	| aCommand aResult |
	aCommand := self unresponsiveCommand.
	aResult := aCommand value.
	self assert: aResult equals: 1.
	^ aCommand
]

{ #category : #'examples - commands' }
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

{ #category : #initialization }
BlTktExamples >> initialize [
	super initialize.
	collector := BlTktExamplesCollector new.
]

{ #category : #'examples - commands' }
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

{ #category : #'examples - commands' }
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
