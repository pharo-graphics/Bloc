"
I define common action steps
"
Trait {
	#name : #TBlDevScripterActionStep,
	#traits : 'TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'steps - actions' }
TBlDevScripterActionStep >> click [
	^ self addStep: (BlDevScripterClickStep new)
]

{ #category : #'steps - subactions' }
TBlDevScripterActionStep >> substep [
	^ self addStep: (BlDevScripterMultipleStep new)
]

{ #category : #'steps - subactions' }
TBlDevScripterActionStep >> substep: aLabel [
	^ self substep label: aLabel
]

{ #category : #'steps - subactions' }
TBlDevScripterActionStep >> substep: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self substep label: aLabel.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #'steps - actions' }
TBlDevScripterActionStep >> type [
	^ self addStep: BlDevScriptTypeTextStep new
]

{ #category : #'steps - actions' }
TBlDevScripterActionStep >> type: aString [
	^ self type text: aString
]
