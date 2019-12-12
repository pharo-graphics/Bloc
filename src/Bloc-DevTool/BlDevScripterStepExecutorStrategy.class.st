Class {
	#name : #BlDevScripterStepExecutorStrategy,
	#superclass : #Object,
	#category : #'Bloc-DevTool-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorStrategy >> playStep: aStep executor: anExecutor [
	aStep playOnExecutor: anExecutor
]

{ #category : #execution }
BlDevScripterStepExecutorStrategy >> startOnScripter: aScripter executor: anExecutor [
	aScripter startWithExecutor: anExecutor
]
