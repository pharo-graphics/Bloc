"
I am an `BlEventListener` event listener and I can display halos around an element. Halos then permits to inspect or delete.

You can install me on any `BlSpace` (window) using {{gtMethod:BlSpace>>#withHalos}}.

The {{gtMethod:BlDevHalosEventListener>>#mouseDownEvent:}} checks if `SHIFT` and `ALT` modifiers are pressed during a `BlMouseDownEvent`. You can try to click on the rectangle below while pressing `SHIFT` and `ALT`:

{{gtExample:BlDevHalosEventListenerExamples>>#containerWithRectangle|codeExpanded=false|previewExpanded=true|previewHeight=350|previewShow=#gtLiveFor:}}

Available actions (see implementation at {{gtMethod:BlElementSelection>>#initializeActions}}:
- The red button removes the selected element. 
- The green button displays additional information.
- The yellow button resizes the selected element.
- The blue button inspect the selected element.
- Dragging Halos moves the selected element.
- You can remove Halos by double click inside of the Halos rectangle.

"
Class {
	#name : #BlDevHalosEventListener,
	#superclass : #BlEventListener,
	#category : #'Bloc-DevTool-Core'
}

{ #category : #'mouse handlers' }
BlDevHalosEventListener >> mouseDownEvent: anEvent [
	(anEvent modifiers isShift and: [ anEvent modifiers isAlt ])
		ifTrue: [ BlElementSelection on: anEvent target ]
]
