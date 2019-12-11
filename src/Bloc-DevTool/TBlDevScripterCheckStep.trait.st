"
I define common check steps.
"
Trait {
	#name : #TBlDevScripterCheckStep,
	#traits : 'TBlDevScripterCheckStepCreation',
	#classTraits : 'TBlDevScripterCheckStepCreation classTrait',
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> childrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckChildrenCountStep new childrenCount: aNumber)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> click [
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: BlClickEvent)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementIsOfClass: aClass [
	^ self addStep: (BlDevScripterCheckElementClassStep new 
		elementClass: aClass)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementSatisfies: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: anOneArgBlock)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> totalChildrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckTotalChildrenCountStep new totalChildrenCount: aNumber)
]

{ #category : #accessing }
TBlDevScripterCheckStep >> withInfoAt: aSymbol elementSatisfies: anOneArgBlock [
	^ self elementSatisfies: [ :anElement :aScripterData | 
			(aScripterData includesKey: aSymbol) and: [ 
				 anOneArgBlock value: anElement value: (aScripterData at: aSymbol) ] ]
]
