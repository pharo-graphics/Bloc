"
I define common action steps
"
Trait {
	#name : #TBlDevScripterActionStep,
	#traits : 'TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #tasks }
TBlDevScripterActionStep >> click [
	^ self addStep: (BlDevScripterClickStep new)
]

{ #category : #tasks }
TBlDevScripterActionStep >> substep [
	^ self addStep: (BlDevScripterMultipleStep new)
]

{ #category : #tasks }
TBlDevScripterActionStep >> substep: aLabel [
	^ self substep label: aLabel
]

{ #category : #tasks }
TBlDevScripterActionStep >> substep: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self substep label: aLabel.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #tasks }
TBlDevScripterActionStep >> type [
	^ self addStep: BlDevScriptTypeTextStep new
]

{ #category : #tasks }
TBlDevScripterActionStep >> type: aString [
	^ self type text: aString
]
