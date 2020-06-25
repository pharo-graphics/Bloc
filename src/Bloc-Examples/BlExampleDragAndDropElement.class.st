Class {
	#name : #BlExampleDragAndDropElement,
	#superclass : #BlElement,
	#instVars : [
		'draggable',
		'drop'
	],
	#category : #'Bloc-Examples-Event'
}

{ #category : #accessing }
BlExampleDragAndDropElement >> draggable [
	^ draggable
]

{ #category : #accessing }
BlExampleDragAndDropElement >> drop [
	^ drop
]

{ #category : #initialization }
BlExampleDragAndDropElement >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	draggable := BlExampleEventsCountingElement new
		size: 100@75;
		relocate: 50@50.
		
	drop := BlExampleEventsCountingElement new
		background: Color white;
		border: (BlBorder builder dashed paint: Color lightGray; width: 1; build);
		size: 200@150;
		relocate: 200@100.
		
	self addChildren: { drop . draggable }
]
