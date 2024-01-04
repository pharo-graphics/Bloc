Class {
	#name : #BlDevScripterStepExecutorScreenshotActivity,
	#superclass : #BlDevScripterStepExecutorStepActivity,
	#category : 'Bloc-Scripter-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorScreenshotActivity >> executePrePlayOnStep: aStep executor: anExecutor [
	| aForm |
	aForm := anExecutor scripter space asSpartaForm.
	aStep addScreenshotForm: aForm.
]
