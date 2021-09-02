Class {
	#name : 'BlDevScripterStepExecutorStepActivity',
	#superclass : 'Object',
	#category : 'Bloc-Scripter-Scripter-Executors'
}

{ #category : 'accessing' }
BlDevScripterStepExecutorStepActivity class >> debugFileNameFor: aStep do: aBlock [
	aStep reference definitionDo: [ :aCompiledMethod |
		| aStepDirectory aSafeSelectorName aFileName |
		
		aSafeSelectorName := (aCompiledMethod selector copyReplaceAll: ':' with: ' ') asCamelCase uncapitalized.
		aStepDirectory := BlDevScripter scripterDirectory / aCompiledMethod methodClass name / aSafeSelectorName.
		aFileName := aStep label asCamelCase asValidSelector.
		
		aBlock
			value: aStepDirectory
			value: aFileName ]
]

{ #category : 'execution' }
BlDevScripterStepExecutorStepActivity >> executePostPlayOnStep: aStep executor: anExecutor [
	
]

{ #category : 'execution' }
BlDevScripterStepExecutorStepActivity >> executePrePlayOnStep: aStep executor: anExecutor [
	
]
