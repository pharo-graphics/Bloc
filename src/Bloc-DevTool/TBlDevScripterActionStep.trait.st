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

{ #category : #'steps - actions' }
TBlDevScripterActionStep >> fire [
	^ self addStep: BlDevScripterFireEventStep new
]

{ #category : #'steps - storing' }
TBlDevScripterActionStep >> storeAt: aSymbol elementInfo: anOneArgBlock [
	^ self addStep: (BlDevScripterStoreElementInfoStep new
		key: aSymbol;
		block: anOneArgBlock)
]

{ #category : #'steps - subactions' }
TBlDevScripterActionStep >> substep [
	^ self addStep: (BlDevScripterMultipleActionStep new)
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
	^ self addStep: BlDevScripterTypeTextStep new
]

{ #category : #'steps - actions' }
TBlDevScripterActionStep >> type: aString [
	^ self type text: aString
]

{ #category : #'steps - waiting' }
TBlDevScripterActionStep >> wait [
	^ self addStep: BlDevScripterWaitStep new
]
