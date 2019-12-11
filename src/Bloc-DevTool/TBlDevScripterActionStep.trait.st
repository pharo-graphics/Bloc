"
I define common action steps
"
Trait {
	#name : #TBlDevScripterActionStep,
	#traits : 'TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> click [
	^ self addStep: (BlDevScripterClickStep new)
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> fire [
	^ self addStep: BlDevScripterFireEventStep new
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> model [
	^ self addStep: BlDevScripterBlockReceivingModelStep new
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> modelDo: anOneArgBlock [
	^ self model block: anOneArgBlock
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> set [
	^ self addStep: BlDevScripterSetStep new
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> storeAt: aSymbol elementInfo: anOneArgBlock [
	^ self addStep: (BlDevScripterStoreElementInfoStep new
		key: aSymbol;
		block: anOneArgBlock)
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substep [
	^ self addStep: (BlDevScripterMultipleActionStep new)
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substep: aLabel [
	^ self substep label: aLabel
]

{ #category : #'steps - substeps' }
TBlDevScripterActionStep >> substep: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self substep label: aLabel.
	anOneArgBlock value: aStep.
	^ aStep
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type [
	^ self addStep: BlDevScripterTypeTextStep new
]

{ #category : #'steps - interactions' }
TBlDevScripterActionStep >> type: aString [
	^ self type text: aString
]

{ #category : #'steps - other' }
TBlDevScripterActionStep >> wait [
	^ self addStep: BlDevScripterWaitStep new
]
