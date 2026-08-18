Class {
	#name : 'BlOverlayElementExamples',
	#superclass : 'BlExamplesTest',
	#category : 'Bloc-Overlay-Examples',
	#package : 'Bloc-Overlay-Examples'
}

{ #category : 'helpers' }
BlOverlayElementExamples >> layoutInSpace: anElement [

	| space |
	space := BlSpace new.
	space host: BlHeadlessHost default.
	space root addChild: anElement.
	space show; waitPendingWork.
	space root removeChildren.
	space close; waitPendingWork
]

{ #category : 'examples - overlay' }
BlOverlayElementExamples >> overlayOnParent [
	<sampleInstance>

	| aContainer anOverlay |
	aContainer := BlElement new
		extent: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	anOverlay := BlOverlayElement on: aContainer.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]

{ #category : 'examples' }
BlOverlayElementExamples >> overlayOnParentInSpace [
	<sampleInstance>

	| aContainer |
	aContainer := self overlayOnParent.
	self layoutInSpace: aContainer.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self assert: (aContainer childWithId: #overlay) extent equals: 500 @ 400.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0.

	^ aContainer
]

{ #category : 'examples' }
BlOverlayElementExamples >> overlayOnParentInSpaceWithOffset [
	<sampleInstance>

	| aContainer |
	aContainer := self overlayOnParent.
	aContainer position: 50 @ 100.
	self layoutInSpace: aContainer.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 50 @ 100.
	self assert: (aContainer childWithId: #overlay) extent equals: 500 @ 400.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0.

	^ aContainer
]

{ #category : 'examples - overlay' }
BlOverlayElementExamples >> overlayOnSibling [
	<sampleInstance>

	| aContainer aSibling anOverlay |
	aContainer := BlElement new
		extent: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	aSibling := BlElement new
		extent: 300@200;
		border: (BlBorder paint: Color gray width: 2);
		addEventHandler: BlPullHandler new.
	
	anOverlay := BlOverlayElement on: aSibling.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: aSibling as: #sibling.
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]

{ #category : 'examples' }
BlOverlayElementExamples >> overlayOnSiblingInSpace [
	<sampleInstance>

	| aContainer |
	aContainer := self overlayOnSibling.
	self layoutInSpace: aContainer.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self assert: (aContainer childWithId: #overlay) extent equals: 300 @ 200.
	self assert: (aContainer childWithId: #overlay) position equals: 0 @ 0.

	^ aContainer
]

{ #category : 'examples' }
BlOverlayElementExamples >> overlayOnSiblingInSpaceWithOffset [
	<sampleInstance>

	| aContainer |
	aContainer := self overlayOnSibling.
	aContainer position: 10 @ 20.
	(aContainer childWithId: #sibling) position: 30 @ 40.
	self layoutInSpace: aContainer.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 10 @ 20.
	self assert: (aContainer childWithId: #overlay) extent equals: 300 @ 200.
	self assert: (aContainer childWithId: #overlay) position equals: 30 @ 40.

	^ aContainer
]
