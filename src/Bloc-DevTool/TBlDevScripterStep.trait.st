Trait {
	#name : #TBlDevScripterStep,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
TBlDevScripterStep >> addStep: aScripterTask [
	<return: #BlDevScripterStep>
	^ self explicitRequirement
]

{ #category : #tasks }
TBlDevScripterStep >> check [
	^ self addStep: (BlDevScripterMultipleCheckStep new)
]

{ #category : #tasks }
TBlDevScripterStep >> click [
	^ self addStep: (BlDevScripterClickStep new)
]

{ #category : #tasks }
TBlDevScripterStep >> substep [
	^ self addStep: (BlDevScripterMultipleStep new)
]

{ #category : #tasks }
TBlDevScripterStep >> substep: aLabel [
	^ self substep label: aLabel
]

{ #category : #tasks }
TBlDevScripterStep >> type [
	^ self addStep: BlDevScriptTypeTextStep new
]

{ #category : #tasks }
TBlDevScripterStep >> type: aString [
	^ self type text: aString
]
