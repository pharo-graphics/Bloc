Class {
	#name : #BlDevScripterMultipleCheckStep,
	#superclass : #BlDevScripterCompositeStep,
	#category : #'Bloc-DevTool-Scripter-Steps'
}

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> childrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckChildrenCountStep new childrenCount: aNumber)
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> click [
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: BlClickEvent)
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> clickOnChildAt: aNumber [
	^ self addStep: (BlDevScripterCheckFiredEventsStep new 
		event: BlClickEvent; 
		onChildAt: aNumber)
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> defaultLabel [
	^ 'Checks'
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> element: anOneArgBlock [
	^ self addStep: (BlDevScripterCheckElementStep new block: anOneArgBlock)
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> elementOfClass: aClass [
	^ self addStep: (BlDevScripterCheckElementClassStep new 
		elementClass: aClass)
]

{ #category : #initialization }
BlDevScripterMultipleCheckStep >> initialize [
	super initialize.

	
]

{ #category : #accessing }
BlDevScripterMultipleCheckStep >> totalChildrenCount: aNumber [
	^ self addStep: (BlDevScripterCheckTotalChildrenCountStep new totalChildrenCount: aNumber)
]
