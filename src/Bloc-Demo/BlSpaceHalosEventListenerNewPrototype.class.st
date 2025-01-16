"
I am an `BlEventListener` event listener and I can display halos around an element. Halos then permits to inspect or delete.

You can install me on any `BlSpace` (window) using `BlSpace>>#withHalos`.

The `BlDevHalosEventListener>>#mouseDownEvent:` checks if `SHIFT` and `ALT` modifiers are pressed during a `BlMouseDownEvent`. You can try to click on the rectangle below while pressing `SHIFT` and `ALT`:

{{gtExample:BlDevHalosEventListenerExamples>>#containerWithRectangle|codeExpanded=false|previewExpanded=true|previewHeight=350|previewShow=#gtLiveFor:}}

Available actions (see implementation at `BlElementSelection>>#initializeActions`:
- The red button removes the selected element. 
- The green button displays additional information.
- The yellow button resizes the selected element.
- The blue button inspect the selected element.
- Dragging Halos moves the selected element.
- You can remove Halos by double click inside of the Halos rectangle.

"
Class {
	#name : #BlSpaceHalosEventListenerNewPrototype,
	#superclass : #BlEventListener,
	#instVars : [
		'haloContainer'
	],
	#category : #'Bloc-Demo-Halos'
}

{ #category : #initialization }
BlSpaceHalosEventListenerNewPrototype >> initialize [

	super initialize.
	haloContainer := nil
]

{ #category : #'mouse handlers' }
BlSpaceHalosEventListenerNewPrototype >> mouseDownEvent: anEvent [

	(anEvent modifiers isShift and: [ anEvent modifiers isAlt ])
		ifFalse: [ ^ self ].
	"haloContainer ifNotNil: [
		haloContainer decorated = anEvent target ifFalse: [
			haloContainer close ] ]."

	haloContainer := BlHaloContainer on: anEvent target in: self
]

{ #category : #removing }
BlSpaceHalosEventListenerNewPrototype >> removeHaloContainer [

	haloContainer := nil.
]
