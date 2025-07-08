Class {
	#name : #BlOverlayElementExamples,
	#superclass : #BlExamplesTest,
	#category : #'Bloc-Overlay-Examples'
}

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnParent [
	<gtExample>

	| aContainer anOverlay |
	aContainer := BlElement new
		extent: 500@400;
		border: (BlBorder builder dashed; paint: Color gray; width: 2; build).
	
	anOverlay := BlOverlayElement on: aContainer.
	anOverlay background: (Color gray alpha: 0.2).
	
	aContainer addChild: anOverlay as: #overlay.
	
	^ aContainer
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnParentInSpace [
	<gtExample>

	| aSpace aContainer |
	aContainer := self overlayOnParent.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.

	aSpace pulse.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self
		assert: (aContainer childWithId: #overlay) extent
		equals: 500 @ 400.
	self
		assert: (aContainer childWithId: #overlay) position
		equals: 0 @ 0.

	^ aSpace
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnParentInSpaceWithOffset [
	<gtExample>

	| aSpace aContainer |
	aContainer := self overlayOnParent.
	aContainer position: 50 @ 100.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.

	aSpace pulse.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 50 @ 100.
	self
		assert: (aContainer childWithId: #overlay) extent
		equals: 500 @ 400.
	self
		assert: (aContainer childWithId: #overlay) position
		equals: 0 @ 0.

	^ aSpace
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSibling [
	<gtExample>

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

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInSpace [
	<gtExample>

	| aSpace aContainer |
	aContainer := self overlayOnSibling.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.

	aSpace pulse.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 0 @ 0.
	self
		assert: (aContainer childWithId: #overlay) extent
		equals: 300 @ 200.
	self
		assert: (aContainer childWithId: #overlay) position
		equals: 0 @ 0.

	^ aSpace
]

{ #category : #'examples - overlay' }
BlOverlayElementExamples >> overlayOnSiblingInSpaceWithOffset [
	<gtExample>

	| aSpace aContainer |
	aContainer := self overlayOnSibling.
	aContainer position: 10 @ 20.
	(aContainer childWithId: #sibling) position: 30 @ 40.

	aSpace := BlSpace new.
	aSpace root addChild: aContainer.

	aSpace pulse.

	self assert: aContainer extent equals: 500 @ 400.
	self assert: aContainer position equals: 10 @ 20.
	self
		assert: (aContainer childWithId: #overlay) extent
		equals: 300 @ 200.
	self
		assert: (aContainer childWithId: #overlay) position
		equals: 30 @ 40.

	^ aSpace
]
