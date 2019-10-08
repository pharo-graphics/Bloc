Class {
	#name : #BlDevScripterMultipleCheckTask,
	#superclass : #BlDevScripterCompositeTask,
	#category : #'Bloc-DevTool-Scripter'
}

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> childrenCount: aNumber [
	^ self addTask: (BlDevScripterCheckChildrenCountTask new childrenCount: aNumber)
]

{ #category : #initialization }
BlDevScripterMultipleCheckTask >> initialize [
	super initialize.

	
]

{ #category : #accessing }
BlDevScripterMultipleCheckTask >> totalChildrenCount: aNumber [
	^ self addTask: (BlDevScripterCheckTotalChildrenCountTask new totalChildrenCount: aNumber)
]
