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

	aStep reference definitionDo: [ :aCompiledMethod |
		| aStepDirectory aScreenshotName |
		aStepDirectory := BlDevScripter scripterDirectory / aCompiledMethod methodClass name / aCompiledMethod selector.
		aStepDirectory ensureCreateDirectory.
		
		aScreenshotName := aStep label asCamelCase asValidSelector, '.png'.
		
		(anExecutor scripter gtSpaceFor: GtPhlowEmptyView new) asElementDo: [ :aPreview |
			BlExporter png
				fileName: aStepDirectory / aScreenshotName;
				element: aPreview;
				export ] ]
]
