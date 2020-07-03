"
I define common check steps.

My users must also use ${class:TBlDevScripterCheckStepCreation}$
"
Trait {
	#name : #TBlDevScripterCheckStep,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> allSatisfy: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection allSatisfy: [ :eachItem | anOneArgBlock cull: eachItem ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> anySatisfies: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection anySatisfy: [ :eachItem | anOneArgBlock cull: eachItem ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> childrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckChildrenCountStep new 
		childrenCount: aNumber;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> click [
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: BlClickEvent;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> do: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckDoStep new block: anOneArgBlock; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementIsOfClass: aClass [
	^ self addStep: (BlDevScripterCheckElementClassStep new 
		elementClass: aClass;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> elementSatisfies: anOneArgBlock [
	^ (self satisfies: anOneArgBlock) referenceSender
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> equals: anEqualsBlock [
	^ self addStep: (BlDevScripterCheckElementEqualsStep new
		equalsBlock: anEqualsBlock;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> nonSatisfies: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: [ :aCollection | 
			aCollection allSatisfy: [ :eachItem | (anOneArgBlock cull: eachItem) not ] ]; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> satisfies: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: anOneArgBlock; referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> totalChildrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckTotalChildrenCountStep new 
		totalChildrenCount: aNumber;
		referenceSender)
]

{ #category : #'steps - checks' }
TBlDevScripterCheckStep >> value: anOneArgBlock equals: anEqualsBlock [
	^ self addStep: (BlDevScripterCheckElementValueStep new
		valueBlock: anOneArgBlock;
		equalsBlock: anEqualsBlock;
		referenceSender)
]
