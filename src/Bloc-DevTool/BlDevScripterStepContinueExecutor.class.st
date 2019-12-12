Class {
	#name : #BlDevScripterStepContinueExecutor,
	#superclass : #BlDevScripterStepExecutor,
	#category : #'Bloc-DevTool-Scripter-Executors'
}

{ #category : #testing }
BlDevScripterStepContinueExecutor >> canBeExecuted: aStep [
	<return: #Boolean>
	^ aStep wasExecuted not
]
