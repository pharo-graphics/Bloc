"
I run all gt-examples as automatic tests
"
Class {
	#name : #BlExamplesTestCase,
	#superclass : #GtExampleTestCase,
	#category : 'Bloc-Tests-Examples'
}

{ #category : #accessing }
BlExamplesTestCase class >> defaultTimeLimit [
	^ 2 minutes

]

{ #category : #configuration }
BlExamplesTestCase >> packageNames [
	"((#gtExample senders select: [ :each | each package name beginsWith: 'Bloc' ]) groupedBy: [ :each | each package name ]) keys"
	
	^  #(#'Bloc-Tests' #'Bloc-Extensions' #'Bloc-Examples' #'Bloc-SVG' #'Bloc-Layout-Tests')
]

{ #category : #tests }
BlExamplesTestCase >> runExample: example [
	" this is not the testing tool we have in mind, but a temporary solution to integrate examples into the currently existing testing tools "
	| exampleResult |
	
	NonInteractiveTranscript stdout show: (example methodClass name, '>>#', example selector); cr.
	
	exampleResult := super runExample: example.	
	(exampleResult returnValue isKindOf: BlElement) ifFalse: [ ^ self ].
	self testInSpace: exampleResult returnValue.
	^ exampleResult
]

{ #category : #tests }
BlExamplesTestCase >> testInSpace: anElement [
	| aSpace aTopMostElement semaphore timeout error |
	
	aTopMostElement := anElement topMostParent.
	aTopMostElement isAttachedToSceneGraph
		ifTrue: [ ^ self ].

	semaphore := Semaphore new.

	aSpace := BlTestAutoClosingSpace new.
	aSpace root addChild: aTopMostElement.

	aSpace
		addEventHandlerOn: BlSpaceClosedEvent
		do: [ semaphore signal ].
	aSpace
		addEventHandlerOn: BlSpaceErrorEvent
		do: [ :anEvent |
			error := anEvent error.
			semaphore signal ].
	aSpace show.

	timeout := semaphore waitTimeoutMSecs: 2000.
	aTopMostElement removeFromParent.
	
	timeout ifTrue: [
		aSpace close.
		self classForTestResult signalErrorWith: anElement gtDisplayString ].
	
	error
		ifNotNil: [ self classForTestResult signalErrorWith: error messageText ]
]
