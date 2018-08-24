"
I contains examples of how to add dragging ability to elements
"
Class {
	#name : #BlDragExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Drag&Drop'
}

{ #category : #'instance creation' }
BlDragExamples >> box [
	<gtExample>
	
	^ BlElement new
		background: Color red;
		size: 50@50
]

{ #category : #'instance creation' }
BlDragExamples >> container [
	<gtExample>

	^ BlElement new
		size: 600@400;
		background: Color veryVeryLightGray;
		yourself
]

{ #category : #'instance creation' }
BlDragExamples >> dragHandler [
	<gtExample>

	^ BlPullHandler new
]

{ #category : #'examples - drag' }
BlDragExamples >> draggable [
	<gtExample>

	^ self box addEventHandler: self dragHandler
]

{ #category : #'examples - drag' }
BlDragExamples >> draggableInParent [
	<gtExample>
	
	^ self container
		relocate: 50@50;
		addChild: (self draggable relocate: 75@60);
		yourself
]
