"
I am an event handler that is used for Halos element. For more information about me, see `BlDevHalosEventListener`.

"
Class {
	#name : #BlHaloContainerListener,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'haloContainer'
	],
	#category : #'Bloc-Demo-Halos'
}

{ #category : #'instance creation' }
BlHaloContainerListener class >> on: aSelectionElement [
	^ self new
		haloContainer: aSelectionElement;
		yourself
]

{ #category : #'element handlers' }
BlHaloContainerListener >> elementExtentChangedEvent: anEvent [

	self haloContainer size: self haloContainer selectionExtent
]

{ #category : #'element handlers' }
BlHaloContainerListener >> elementPositionChangedEvent: anEvent [

	self haloContainer position:
		anEvent target positionInSpace - self haloContainer padding topLeft
]

{ #category : #'element handlers' }
BlHaloContainerListener >> elementRemovedFromParentEvent: anEvent [

	self haloContainer close
]

{ #category : #'api - accessing' }
BlHaloContainerListener >> eventsToHandle [
	^ { BlElementExtentChangedEvent . BlElementPositionChangedEvent . BlElementRemovedFromParentEvent }
]

{ #category : #accessing }
BlHaloContainerListener >> haloContainer [
	^ haloContainer
]

{ #category : #accessing }
BlHaloContainerListener >> haloContainer: aBlHaloContainer [
	haloContainer := aBlHaloContainer
]
