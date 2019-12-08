Class {
	#name : #BlDevScripterMultipleCheckTask,
	#superclass : #BlDevScripterCompositeTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> childrenCount: aNumber [
	^ self addTask: (BlDevScripterCheckChildrenCountTask new childrenCount: aNumber)
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> click [
	^ self addTask: (BlDevScripterCheckFiredEventsTask new 
		event: BlClickEvent)
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> clickOnChildAt: aNumber [
	^ self addTask: (BlDevScripterCheckFiredEventsTask new 
		event: BlClickEvent; 
		onChildAt: aNumber)
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> defaultLabel [
	^ 'Checks'
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> element: anOneArgBlock [
	^ self addTask: (BlDevScripterCheckElementTask new block: anOneArgBlock)
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> elementOfClass: aClass [
	^ self addTask: (BlDevScripterCheckElementClassTask new 
		elementClass: aClass)
]

{ #category : #initialization }
BlDevScripterMultipleCheckTask >> initialize [
	super initialize.

	
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> totalChildrenCount: aNumber [
	^ self addTask: (BlDevScripterCheckTotalChildrenCountTask new totalChildrenCount: aNumber)
]
