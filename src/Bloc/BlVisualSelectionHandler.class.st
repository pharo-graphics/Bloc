"
I extend selection handler in the sense that I add a visual selection rectangle that resizes itself during mouse drag.

I simulate Desktop behaviour of most OS

"
Class {
	#name : #BlVisualSelectionHandler,
	#superclass : #BlSelectionHandler,
	#instVars : [
		'selection'
	],
	#category : #'Bloc-Utilities - Selection'
}

{ #category : #'dnd handlers' }
BlVisualSelectionHandler >> dragEndEvent: anEvent [
	super dragEndEvent: anEvent.

	container removeChild: selection
]

{ #category : #'dnd handlers' }
BlVisualSelectionHandler >> dragEvent: anEvent [
	super dragEvent: anEvent.
]

{ #category : #'dnd handlers' }
BlVisualSelectionHandler >> dragStartEvent: anEvent [
	super dragStartEvent: anEvent.

	container addChild: selection
]

{ #category : #accessing }
BlVisualSelectionHandler >> eventsToHandle [
	^ super eventsToHandle, {
		BlMouseDownEvent
	}
]

{ #category : #'mouse handlers' }
BlVisualSelectionHandler >> mouseDownEvent: anEvent [
	| oldSelected |
	
	oldSelected := selected copy.
	selected removeAll.
	oldSelected keysDo: [ :anElement | self handleDeselected: anElement ]
]

{ #category : #installation }
BlVisualSelectionHandler >> onInstalledIn: anElement [
	super onInstalledIn: anElement.

	selection := BlElement new
		extent: 0@0;
		background: (Color blue alpha: 0.1);
		border: (BlBorder builder paint: (Color blue alpha: 0.7); width: 2; build);
		yourself
]

{ #category : #'selection - handling' }
BlVisualSelectionHandler >> selectionChanged [
	| aSelectionBounds |
	super selectionChanged.
	
	aSelectionBounds := BlBounds fromRectangle: ((origin min: corner) corner: (corner max: origin)).
	aSelectionBounds := container globalBoundsToLocal: aSelectionBounds.

	selection
		position: aSelectionBounds origin;
		extent: aSelectionBounds extent
]
