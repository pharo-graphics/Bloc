Class {
	#name : 'BlDevScripterStepExecutorScreenshotExportOnFailActivity',
	#superclass : 'BlDevScripterStepExecutorStepActivity',
	#category : 'Bloc-Scripter-Scripter-Executors',
	#package : 'Bloc-Scripter',
	#tag : 'Scripter-Executors'
}

{ #category : 'execution' }
BlDevScripterStepExecutorScreenshotExportOnFailActivity >> executePostPlayOnStep: aStep executor: anExecutor [
	aStep state = BlDevScripterStepState success
		ifTrue: [ ^ self ].
		
	aStep isRootStep
		ifTrue: [ ^ self ].
		
	self class debugFileNameFor: aStep do: [ :aDirectory :aFileName |
		| aScreenshotName |

		aDirectory ensureCreateDirectory.
		aScreenshotName := aFileName, '.png'.

		anExecutor scripter space root
			writePngTo: aDirectory / aScreenshotName ]
]
