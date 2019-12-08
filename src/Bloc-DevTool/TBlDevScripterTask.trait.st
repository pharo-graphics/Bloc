Trait {
	#name : #TBlDevScripterTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
TBlDevScripterTask >> addTask: aScripterTask [
	<return: #BlDevScripterTask>
	^ self explicitRequirement
]

{ #category : #tasks }
TBlDevScripterTask >> check [
	^ self addTask: (BlDevScripterMultipleCheckTask new)
]

{ #category : #tasks }
TBlDevScripterTask >> click [
	^ self addTask: (BlDevScripterClickTask new)
]

{ #category : #tasks }
TBlDevScripterTask >> subtask [
	^ self addTask: (BlDevScripterMultipleTask new)
]

{ #category : #tasks }
TBlDevScripterTask >> subtask: aLabel [
	^ self subtask label: aLabel
]

{ #category : #tasks }
TBlDevScripterTask >> type [
	^ self addTask: BlDevScriptTypeTextTask new
]

{ #category : #tasks }
TBlDevScripterTask >> type: aString [
	^ self type text: aString
]
