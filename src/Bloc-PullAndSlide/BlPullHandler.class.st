"
I add an ability to drag (pull) any arbitrary element (the element which add myself as an event handler) within its direct parent by requesting position change.
- Note 1: that some layout do not allow elements to have custom positions which means I have no effect.
- Note 2: the moved element (the pull target) is by default the the element which add myself as an event handler. The relocated element can be explicitely setup with #pullTarget: (if the moved element is not the element which add myself as an eventDispatcher).

The new position of the pulled target is computed as follow:
- if I am setup as an horizontal handler, only the horizontal position is changed. 
- if I am setup as a vertical handler, only the vertical position is changed

By default, I change the location of the pulled object according to the dragging motion.
But one can use relocateX: (relocateY:) to indicate if the abscissa (ordinate) of the pulled target is to be actually changed by myelf or not. As an example, the actual position of the pulled target can be changed externally as an effect of the dragging. In this case, relocateX: (relocateY:) can be used to indicate that this is not my responsibility to change the location of the abscissa (ordinate).


- Example 1

```| element |

element := BlElement new.
element background: Color red.
element size: 75@75.
element addEventHandler: BlPullHandler new.	
```




"
Class {
	#name : #BlPullHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dragStartGlobalPosition',
		'originalPosition',
		'allowedOutOfBounds',
		'direction',
		'pullTarget',
		'relocateX',
		'relocateY'
	],
	#classVars : [
		'Any',
		'Horizontal',
		'Vertical'
	],
	#category : #'Bloc-PullAndSlide-Handlers'
}

{ #category : #'class initialization' }
BlPullHandler class >> initialize [	
	Any := #any.
	Vertical := #vertical.
	Horizontal := #horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> allowOutOfBounds [
	"Allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := true
]

{ #category : #'api - pull handler' }
BlPullHandler >> beFree [
	direction := Any
]

{ #category : #'api - pull handler' }
BlPullHandler >> beHorizontal [
	direction := Horizontal
]

{ #category : #'api - pull handler' }
BlPullHandler >> beVertical [
	direction := Vertical
]

{ #category : #'private - pulling' }
BlPullHandler >> computePullDelta: aDragDelta [
	<return: #Number>
	
	direction = Any
		ifTrue: [ ^ aDragDelta ].
		
	direction = Vertical
		ifTrue: [ ^ 0 @ aDragDelta y ].
		
	direction = Horizontal
		ifTrue: [ ^ aDragDelta x @ 0 ].
		
	^ direction
]

{ #category : #'api - pull handler' }
BlPullHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds"
	
	allowedOutOfBounds := false
]

{ #category : #'event handling' }
BlPullHandler >> dragEndEvent: anEvent [
	"anEvent consumed: true."
	
	pullTarget dispatchEvent: BlPullEndEvent new
]

{ #category : #'event handling' }
BlPullHandler >> dragEvent: anEvent [

	| aStartPosition aCurrentPosition aPreviousPosition dragDelta aNewPosition newX newY |
	dragStartGlobalPosition ifNil: [
		dragStartGlobalPosition := anEvent position ].

	aCurrentPosition := pullTarget globalPointToParentChildren:
		                    anEvent position.
	aStartPosition := pullTarget globalPointToParentChildren:
		                  dragStartGlobalPosition.

	dragDelta := aCurrentPosition - aStartPosition.

	dragDelta := (self computePullDelta: dragDelta) rounded.
	aNewPosition := (originalPosition ifNil: [
		                 originalPosition := pullTarget constraints position ])
	                + dragDelta.
	aPreviousPosition := pullTarget constraints position.
	allowedOutOfBounds ifFalse: [
		| aMaxPosition |
		aMaxPosition := pullTarget hasParent
			                ifTrue: [
			                pullTarget parent extent
			                - anEvent currentTarget extent ]
			                ifFalse: [ 0 @ 0 ].
		aNewPosition := aNewPosition min: aMaxPosition max: 0 @ 0 ].

	newX := relocateX
		        ifTrue: [ aNewPosition x ]
		        ifFalse: [ pullTarget constraints position x ].
	newY := relocateY
		        ifTrue: [ aNewPosition y ]
		        ifFalse: [ pullTarget constraints position y ].
	pullTarget position: newX @ newY.
	anEvent consumed: true.

	self
		onPulled: pullTarget
		from: aPreviousPosition
		to: aNewPosition
		by: dragDelta
		starting: originalPosition
]

{ #category : #'event handling' }
BlPullHandler >> dragStartEvent: anEvent [

	anEvent consumed: true.

	pullTarget := pullTarget ifNil: [ anEvent currentTarget ].
	pullTarget dispatchEvent: BlPullStartEvent new.

	"drag start position in space coordinates"
	dragStartGlobalPosition := anEvent position.

	"element position in parent"
	originalPosition := pullTarget constraints position
]

{ #category : #'api - accessing' }
BlPullHandler >> eventsToHandle [
	^ { BlDragStartEvent . BlDragEvent . BlDragEndEvent }
]

{ #category : #initialization }
BlPullHandler >> initialize [
	super initialize.
	
	allowedOutOfBounds := true.
	direction := Any.
	relocateX := true.
	relocateY := true
]

{ #category : #'event handling' }
BlPullHandler >> onPulled: aPulledElement from: aPreviousPosition to: aNewPosition  by: aDragDelta starting: anOriginalPosition [
	aPulledElement dispatchEvent: (BlPullEvent new
		initialPosition: anOriginalPosition;
		oldPosition: aPreviousPosition;
		newPosition: aNewPosition;
		delta: aDragDelta)
]

{ #category : #accessing }
BlPullHandler >> pullTarget [

	"the element which is moved according to the dragging motion"
	^ pullTarget 
]

{ #category : #accessing }
BlPullHandler >> pullTarget: anElement [

	"Set the element which is moved according to the dragging motion. 
	By default this is the element which add myself as an eventHandler "

	pullTarget := anElement 
]

{ #category : #accessing }
BlPullHandler >> relocateX: aBoolean [

	relocateX := aBoolean
]

{ #category : #accessing }
BlPullHandler >> relocateY: aBoolean [

	relocateY := aBoolean
]
