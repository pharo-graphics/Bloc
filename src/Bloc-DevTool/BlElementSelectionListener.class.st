"
I am an event handler that is used for Halos element. For more information about me, see ${class:BlDevHalosEventListener}$.
"
Class {
	#name : #BlElementSelectionListener,
	#superclass : #BlElementEventListener,
	#instVars : [
		'selection'
	],
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'instance creation' }
BlElementSelectionListener class >> on: aSelectionElement [
	^ self new
		selection: aSelectionElement;
		yourself
]

{ #category : #'element handlers' }
BlElementSelectionListener >> elementExtentChanged: anEvent [

	self selection size: self selection selectionExtent
]

{ #category : #'element handlers' }
BlElementSelectionListener >> elementPositionChanged: anEvent [

	self selection relocate: anEvent target positionInSpace - self selection padding topLeft
]

{ #category : #'element handlers' }
BlElementSelectionListener >> elementRemoved: anEvent [

	self selection close
]

{ #category : #accessing }
BlElementSelectionListener >> selection [
	^ selection
]

{ #category : #accessing }
BlElementSelectionListener >> selection: aSelectionElement [
	selection := aSelectionElement
]
