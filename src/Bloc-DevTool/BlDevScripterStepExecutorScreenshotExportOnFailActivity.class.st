Class {
	#name : #BlDevScripterStepExecutorScreenshotExportOnFailActivity,
	#superclass : #BlDevScripterStepExecutorStepActivity,
	#category : #'Bloc-DevTool-Scripter-Executors'
}

{ #category : #execution }
BlDevScripterStepExecutorScreenshotExportOnFailActivity >> executePostPlayOnStep: aStep executor: anExecutor [
	aStep state = BlDevScripterStepState success
		ifTrue: [ ^ self ].
		
	aStep isRootStep
		ifTrue: [ ^ self ].
		
	self class debugFileNameFor: aStep do: [ :aDirectory :aFileName |
		| aScreenshotName |

		aDirectory ensureCreateDirectory.
		aScreenshotName := aFileName, '.png'.
		
		(anExecutor scripter gtSpaceFor: GtPhlowEmptyView new) asElementDo: [ :aPreview |
			BlExporter png
				fileName: aDirectory / aScreenshotName;
				element: aPreview;
				export ] ]
]
