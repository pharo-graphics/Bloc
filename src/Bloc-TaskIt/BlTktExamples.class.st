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
