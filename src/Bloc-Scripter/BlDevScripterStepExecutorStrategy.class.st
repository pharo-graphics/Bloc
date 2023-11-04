Class {
	#name : 'BlDevScripterStepExecutorStrategy',
	#superclass : 'Object',
	#category : 'Bloc-Scripter-Scripter-Executors',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Executors'
}

{ #category : 'execution' }
BlDevScripterStepExecutorStrategy >> playStep: aStep executor: anExecutor [
	aStep playOnExecutor: anExecutor
]

{ #category : 'execution' }
BlDevScripterStepExecutorStrategy >> startOnScripter: aScripter executor: anExecutor [
	aScripter pulse.
	aScripter startWithExecutor: anExecutor.
	aScripter pulse.
]
