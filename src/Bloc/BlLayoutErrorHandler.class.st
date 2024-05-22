Class {
	#name : #BlLayoutErrorHandler,
	#superclass : #BlSingleErrorHandler,
	#category : #'Bloc-Basic-Errors'
}

{ #category : #testing }
BlLayoutErrorHandler >> matches: aFramePhase [
	^ aFramePhase isLayoutPhase
]

{ #category : #'error handling' }
BlLayoutErrorHandler >> processError: aBlHandledError [

	NonInteractiveTranscript stderr
		show: aBlHandledError;
		cr.
	self flag: 'crappy'. 
	"Temporary reset the layout of the parent if it's an infinite element.
	Should be replaced with a more generic solution."
	aBlHandledError element withAllParentsDo: [ :aParentElement | 
		(aParentElement class name = #BlInfiniteElement)
			ifTrue: [ aParentElement state beStepStart ] ].

	aBlHandledError debug
]
