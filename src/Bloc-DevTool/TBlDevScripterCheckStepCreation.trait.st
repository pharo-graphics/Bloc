"
I define very basic methods to create check steps using ${class:BlDevScripterMultipleCheckStep}$.
"
Trait {
	#name : #TBlDevScripterCheckStepCreation,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #adding }
TBlDevScripterCheckStepCreation >> addStep: aScripterTask [
	<return: #BlDevScripterStep>
	^ self explicitRequirement
]

{ #category : #tasks }
TBlDevScripterCheckStepCreation >> check [
	^ self addStep: (BlDevScripterMultipleCheckStep new)
]

{ #category : #tasks }
TBlDevScripterCheckStepCreation >> check: aLabel [
	^ self check label: aLabel
]

{ #category : #tasks }
TBlDevScripterCheckStepCreation >> check: aLabel do: anOneArgBlock [
	| aStep |
	aStep := self check: aLabel.
	anOneArgBlock value: aStep.
	^ aStep
]
