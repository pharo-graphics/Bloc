"
I am an overlay that provides the mechanism of resizing a referenceElement. I have eight resizing elements for which the dragging logic are defined in the ==BlResizerListener== hierarchy.

Users might want to specify that I should ==preventMouseEvents== in order to still allow the user to interact with the ==referenceElement== even when I am active.
"
Class {
	#name : #BlResizerElement,
	#superclass : #BlOverlayElement,
	#instVars : [
		'topLeft',
		'topCenter',
		'topRight',
		'middleLeft',
		'middleRight',
		'bottomLeft',
		'bottomCenter',
		'bottomRight',
		'resizerListeners'
	],
	#category : 'Bloc-Utilities - Resizable'
}

{ #category : #'api - attaching / detaching' }
BlResizerElement >> attachTo: anElement [
	super attachTo: anElement.

	resizerListeners do: [ :aResizerListener | aResizerListener resizeTarget: anElement ] 
]

{ #category : #'api - accessing handles' }
BlResizerElement >> bottomCenter [
	<return: #BlElement>

	^ bottomCenter
]

{ #category : #'api - accessing handles' }
BlResizerElement >> bottomLeft [
	<return: #BlElement>

	^ bottomLeft
]

{ #category : #'api - accessing handles' }
BlResizerElement >> bottomRight [
	<return: #BlElement>

	^ bottomRight
]

{ #category : #initialization }
BlResizerElement >> defaultLayout [
	^ BlFrameLayout new
]

{ #category : #initialization }
BlResizerElement >> initialize [
	| topLeftResizer topCenterResizer topRightResizer middleLeftResizer middleRightListener bottomLeftListener bottomCenterResizer bottomRightListener |
	super initialize.
	
	self border: (BlBorder paint: (Color blue alpha: 0.1) width: 5).
	
	topLeft := self newHandle.
	topLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	topLeftResizer := BlResizerTopLeftListener new.
	topLeft addEventHandler: topLeftResizer.
	
	topCenter := self newHandle.
	topCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignTop ].
	
	topCenterResizer := BlResizerTopListener new.
	topCenter addEventHandler: topCenterResizer.
	
	topRight := self newHandle.
	topRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignTop ].
	
	topRightResizer := BlResizerTopRightListener new.
	topRight addEventHandler: topRightResizer.
	
	middleLeft := self newHandle.
	middleLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignCenter ].
	
	middleLeftResizer := BlResizerLeftListener new.
	middleLeft addEventHandler: middleLeftResizer.
	
	middleRight := self newHandle.
	middleRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	
	middleRightListener := BlResizerRightListener new.
	middleRight addEventHandler: middleRightListener.
	
	bottomLeft := self newHandle.
	bottomLeft constraintsDo: [ :c |
		c frame horizontal alignLeft.
		c frame vertical alignBottom ].
	
	bottomLeftListener := BlResizerBottomLeftListener new.
	bottomLeft addEventHandler: bottomLeftListener.
	
	bottomCenter := self newHandle.
	bottomCenter constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignBottom ].
	
	bottomCenterResizer := BlResizerBottomListener new.
	bottomCenter addEventHandler: bottomCenterResizer.
	
	bottomRight := self newHandle.
	bottomRight constraintsDo: [ :c |
		c frame horizontal alignRight.
		c frame vertical alignBottom ].

	bottomRightListener := BlResizerBottomRightListener new.
	bottomRight addEventHandler: bottomRightListener.
	
	resizerListeners := { topLeftResizer . topCenterResizer . topRightResizer . middleLeftResizer . middleRightListener . bottomLeftListener . bottomCenterResizer . bottomRightListener }.

	self addChildren: {
		topLeft . topCenter . topRight .
		middleLeft . middleRight .
		bottomLeft . bottomCenter . bottomRight .
	}
]

{ #category : #'api - accessing handles' }
BlResizerElement >> middleLeft [
	<return: #BlElement>

	^ middleLeft
]

{ #category : #'api - accessing handles' }
BlResizerElement >> middleRight [
	<return: #BlElement>

	^ middleRight
]

{ #category : #'instance creation' }
BlResizerElement >> newHandle [
	^ BlElement new
		opacity: 0.5;
		background: (Color white);
		border: (BlBorder paint: Color gray width: 1);
		size: 6@6
]

{ #category : #'api - accessing handles' }
BlResizerElement >> topCenter [
	<return: #BlElement>

	^ topCenter
]

{ #category : #'api - accessing handles' }
BlResizerElement >> topLeft [
	<return: #BlElement>

	^ topLeft
]

{ #category : #'api - accessing handles' }
BlResizerElement >> topRight [
	<return: #BlElement>

	^ topRight
]
