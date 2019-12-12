Class {
	#name : #BlDevScripterStepPlayOnceExecutor,
	#superclass : #BlDevScripterStepExecutor,
	#category : #'Bloc-DevTool-Scripter-Executors'
}

{ #category : #asserting }
BlDevScripterStepPlayOnceExecutor >> assertExecutableStep: aStep [
	self 
		assert: [ aStep wasExecuted not ]
		description: [ 'Step can be executed only once' ]
]
