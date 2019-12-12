Class {
	#name : #BlDevScripterStepExecutorScreenshotActivity,
	#superclass : #BlDevScripterStepExecutorStepActivity,
	#category : #'Bloc-DevTool-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorScreenshotActivity >> executePrePlayOnStep: aStep executor: anExecutor [
	| aForm |
	aForm := anExecutor scripter space asSpartaForm.
	aStep addScreenshotForm: aForm.
]
