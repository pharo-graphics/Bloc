"
I am a subclass of BlSpaceFrame to replace the it with profiling extensions
"
Class {
	#name : #BlProfilingSpaceFrame,
	#superclass : #BlSpaceFrame,
	#instVars : [
		'spaceStatistics'
	],
	#category : #'Bloc-DevTool-Profiling'
}

{ #category : #initialization }
BlProfilingSpaceFrame >> fillFrom: aBlSpaceFrame [ 
	
	id := aBlSpaceFrame id.
	phases := aBlSpaceFrame phases. 
	currentPhaseLink := (aBlSpaceFrame instVarNamed: #currentPhaseLink)
]

{ #category : #running }
BlProfilingSpaceFrame >> runCurrentPhaseOn: aSpace [

	| millis |
	millis := [ self currentPhase runOn: aSpace ] millisecondsToRun.

	spaceStatistics recordMilliseconds: millis forFramePhase: self currentPhase 
]

{ #category : #running }
BlProfilingSpaceFrame >> runOn: aSpace [
	self incrementFrameId.

	spaceStatistics frameStarted: id.

	self runCurrentPhaseOn: aSpace.

	[ self hasNextPhase ] whileTrue: [
		self switchToNextPhase.
		self runCurrentPhaseOn: aSpace ].

	"move back to the first phase"
	self switchToNextPhase.
	
	spaceStatistics frameEnded: id.

]

{ #category : #accessing }
BlProfilingSpaceFrame >> spaceStatistics: aPRSpaceStatistics [ 

	spaceStatistics := aPRSpaceStatistics 

]
