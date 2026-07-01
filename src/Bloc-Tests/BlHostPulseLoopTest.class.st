Class {
	#name : #BlHostPulseLoopTest,
	#superclass : #BlParameterizedHostTest,
	#category : #'Bloc-Tests-Space'
}

{ #category : #running }
BlHostPulseLoopTest >> runCaseManaged [ 

	^ self runCase
]

{ #category : #tests }
BlHostPulseLoopTest >> testOpeningAnSpaceDeferingAnErrorKeepsLoopRunning [

	| aSpace logger oldUIManager |
	UIManager default class = MorphicUIManager ifFalse: [ ^ self skip ].

	hostClass = BlOSWindowSDL2Host ifFalse: [ ^ self skip ].

	aSpace := self newTestingSpace.
	aSpace root addChild: (BlElement new
			 background: Color blue;
			 yourself).

	aSpace show.

	logger := MemoryLogger new.
	oldUIManager := UIManager default.

	[
		UIManager default: oldUIManager nonInteractiveManager.
		logger runFor: BlParallelUniverseErrorDuringPulseSignal during: [
				aSpace universe defer: [ 1 error: 'I am the debugger to kill' ].
				[ aSpace universe hasDeferredActions ] whileTrue: [
					100 milliSeconds wait ] ] ] ensure: [
		UIManager default: oldUIManager ].

	self assert: logger entries size >= 2.
	self
		assert: logger recordings first signaledError class
		equals: Error.
	self
		assert: logger recordings second signaledError class
		equals: UnhandledError
]
