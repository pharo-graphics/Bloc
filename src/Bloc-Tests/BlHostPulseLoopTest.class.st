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

	| aSpace logger |

	UIManager default class = MorphicUIManager 
		ifFalse: [ ^ self skip ].

	hostClass = BlOSWindowSDL2Host 
		ifFalse: [ ^ self skip ].

	aSpace := self newTestingSpace.
	aSpace root addChild: (BlElement new background: Color blue; yourself).
		
	aSpace show.
	
	logger := MemoryLogger new.
	logger runFor: BlParallelUniverseErrorDuringPulseSignal during: [	
			aSpace universe defer: [ 1 error: 'I am the debugger to kill' ].	
			[aSpace universe hasDeferredActions] whileTrue: [ 
				100 milliSeconds wait
			 ]].

	self assert: logger recordings size equals: 2.
	self assert: logger recordings first signaledError class equals: Error.
	self assert: logger recordings second signaledError class equals: UnhandledError.
	
	MorphicRenderLoop new doOneCycle.
	
	"This is horrible, I will fix Pharo to have a list of open debuggers"
	StDebugger allInstances 
		detect: [ :e |
			e window notNil and: [
				e window title = 'Error: I am the debugger to kill' ] ]
		ifFound: [ :x | x window close ]
		ifNone: [ self fail ].
	
]
