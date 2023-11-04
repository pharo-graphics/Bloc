Class {
	#name : 'BlDevScripterStepExecutorSyncStrategy',
	#superclass : 'BlDevScripterStepExecutorStrategy',
	#category : 'Bloc-Scripter-Scripter-Executors',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Executors'
}

{ #category : 'execution' }
BlDevScripterStepExecutorSyncStrategy >> startOnScripter: aScripter executor: anExecutor [
	BlUseAsyncFeatures disableDuring: [ 
		super startOnScripter: aScripter executor: anExecutor ]
]
