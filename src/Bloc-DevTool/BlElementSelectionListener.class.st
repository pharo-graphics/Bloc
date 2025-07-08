"
I am an event handler that is used for Halos element. For more information about me, see `BlDevHalosEventListener`.

"
Class {
	#name : #BlElementSelectionListener,
	#superclass : #BlCustomEventHandler,
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
BlElementSelectionListener >> elementExtentChangedEvent: anEvent [

	self selection extent: self selection selectionExtent
]

{ #category : #'element handlers' }
BlElementSelectionListener >> elementPositionChangedEvent: anEvent [

	self selection position:
		anEvent target positionInSpace - self selection padding topLeft
]

{ #category : #'element handlers' }
BlElementSelectionListener >> elementRemovedFromParentEvent: anEvent [

	self selection close
]

{ #category : #'api - accessing' }
BlElementSelectionListener >> eventsToHandle [
	^ { BlElementExtentChangedEvent . BlElementPositionChangedEvent . BlElementRemovedFromParentEvent }
]

{ #category : #accessing }
BlElementSelectionListener >> selection [
	^ selection
]

{ #category : #accessing }
BlElementSelectionListener >> selection: aSelectionElement [
	selection := aSelectionElement
]
