"
I add an ability to drag (pull) any arbitrary element (the element which add myself as an event handler) within its direct parent by requesting position change.
- Note 1: that some layout do not allow elements to have custom positions which means I have no effect.
- Note 2: the moved element (the pull target) is by default the element which add myself as an event handler. The relocated element can be explicitely setup with #pullTarget: (if the moved element is not the element which add myself as an eventDispatcher).

The new position of the pulled target is computed as follow:
- if I am setup as an horizontal handler, only the horizontal position is changed. 
- if I am setup as a vertical handler, only the vertical position is changed

By default, I change the location of the pulled object according to the dragging motion.
But one can use relocateX: (relocateY:) to indicate if the abscissa (ordinate) of the pulled target is to be actually changed by myself or not. As an example, the actual position of the pulled target can be changed externally as an effect of the dragging. In this case, relocateX: (relocateY:) can be used to indicate that this is not my responsibility to change the location of the abscissa (ordinate).


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
		'direction',
		'allowOutOfBounds',
		'dragStartPosition',
		'target',
		'initialTargetPosition'
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
	"Allow the pulled element to be pulled outside of the parent bounds."
	
	allowOutOfBounds := true
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

{ #category : #'api - pull handler' }
BlPullHandler >> disallowOutOfBounds [
	"Do not allow the pulled element to be pulled outside of the parent bounds."
	
	allowOutOfBounds := false
]

{ #category : #'event handling' }
BlPullHandler >> dispatchPulledTo: currentPosition [

	target dispatchEvent:
		(BlPullEvent new
			initialPosition: dragStartPosition;
			currentPosition: currentPosition;
			yourself)
]

{ #category : #'event handling' }
BlPullHandler >> dragEndEvent: anEvent [

	anEvent consume.
	
	target dispatchEvent: BlPullEndEvent new
]

{ #category : #'event handling' }
BlPullHandler >> dragEvent: aBlDragEvent [

	| newPosition deltaFromStartPosition |
	aBlDragEvent consume.

	deltaFromStartPosition := aBlDragEvent position - dragStartPosition.
	newPosition := initialTargetPosition +
		(self filteredDelta: deltaFromStartPosition).
	
	allowOutOfBounds ifFalse: [
		| maxPosition |
		maxPosition := target parent extent - target extent.
		newPosition := newPosition min: maxPosition max: 0@0 ].

	newPosition := newPosition rounded.
	target position: newPosition.

	self dispatchPulledTo: newPosition
]

{ #category : #'event handling' }
BlPullHandler >> dragStartEvent: anEvent [

	anEvent consume.

	target ifNil: [ target := anEvent currentTarget ].
	target dispatchEvent: BlPullStartEvent new.
	
	dragStartPosition := anEvent position.
	initialTargetPosition := target position.
]

{ #category : #'api - accessing' }
BlPullHandler >> eventsToHandle [

	^ {		BlDragStartEvent.
			BlDragEvent.
			BlDragEndEvent }
]

{ #category : #private }
BlPullHandler >> filteredDelta: aPoint [

	direction = Vertical ifTrue: [ ^ 0 @ aPoint y ].
	direction = Horizontal ifTrue: [ ^ aPoint x @ 0 ].
	^ aPoint 	"direction = Any"
]

{ #category : #initialization }
BlPullHandler >> initialize [

	super initialize.
	
	self allowOutOfBounds.
	self beFree
]

{ #category : #accessing }
BlPullHandler >> target [
	"Answer the element that is moved according to the dragging motion."

	^ target
]

{ #category : #accessing }
BlPullHandler >> target: anElement [
	"Set the element that is moved accordingly to the dragging motion. 
	By default, this is the element that added myself as an event handler."

	target := anElement 
]
