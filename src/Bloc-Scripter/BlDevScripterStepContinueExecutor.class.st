Class {
	#name : #BlDevScripterStepContinueExecutor,
	#superclass : #BlDevScripterStepExecutor,
	#category : 'Bloc-Scripter-Scripter-Executors'
}

{ #category : #testing }
BlDevScripterStepContinueExecutor >> canBeExecuted: aStep [
	<return: #Boolean>
	^ aStep wasExecuted not
]
