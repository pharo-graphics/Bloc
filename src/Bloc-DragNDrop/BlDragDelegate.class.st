"
Actual behavior on dragged element. 
"
Class {
	#name : #BlDragDelegate,
	#superclass : #Object,
	#instVars : [
		'items',
		'dragArea',
		'offset',
		'parent'
	],
	#category : #'Bloc-DragNDrop-core'
}

{ #category : #'drag and drop' }
BlDragDelegate >> cancel: aDraggedContainer at: aPoint in: aParentElement [
	"Cancel drag and animate previews"

	| aCancelAnimation |
	self items ifEmpty: [ ^ self ].

	self items do: [ :eachItem |
		| aPreviewElement |
		aPreviewElement := eachItem sourceElement.
		aPreviewElement removeFromParent.
		aPreviewElement position: aPoint.
		parent addChild: aPreviewElement ].

	aCancelAnimation := BlParallelAnimation withAll:
		                    (self items collect: [ :aDragItem |
			                     | aPreviewBounds aSourceBounds aPreviewElement |
			                     aPreviewElement := aDragItem sourceElement.

			                     aPreviewBounds := aPreviewElement bounds inSpace.
			                     aSourceBounds := aDragItem sourceElement bounds inSpace.

			                     BlNumberTransition new
				                     from: aPoint;
				                     to:
					                     aSourceBounds center
					                     - (aPreviewBounds extent / 2.0);
				                     easing: (BlDecelerateInterpolator factor: 2);
				                     duration: 350 milliSeconds;
				                     onStepDo: [ :aPosition |
					                     aPreviewElement position: aPosition ]
				                     ]).

	parent addAnimation: aCancelAnimation
]

{ #category : #'drag and drop' }
BlDragDelegate >> drag: aDraggedContainer to: aPoint [
	"Drag a container with all previews to a given point in the parent coordinate of the container"

	"horizontal drag&drop, used by GToolkit to reorder tabs on top of its interface"

	"aDraggedContainer position:
		(aPoint - offset) x @ aDraggedContainer measuredBounds position y"

	"vertical drag & drop :" 
	"aDraggedContainer position:
		aDraggedContainer measuredBounds position x @ (aPoint - offset) y"

	"normal drag & drop"
	aDraggedContainer position: aPoint - offset
]

{ #category : #accessing }
BlDragDelegate >> dragArea [

	^ dragArea
]

{ #category : #accessing }
BlDragDelegate >> dragArea: anObject [

	dragArea := anObject
]

{ #category : #testing }
BlDragDelegate >> hasDragArea [

	^ dragArea notNil
]

{ #category : #initialization }
BlDragDelegate >> initialize [

	super initialize.

	items := { }
]

{ #category : #accessing }
BlDragDelegate >> items [

	^ items
]

{ #category : #accessing }
BlDragDelegate >> items: aCollectionOfDragItems [

	items := aCollectionOfDragItems
]

{ #category : #'drag and drop' }
BlDragDelegate >> lift [
	"Lift previews at a given point in space coordinates"

	| aContainer |
	aContainer := BlElement new
		              layout: BlFrameLayout new;
		              clipChildren: false;
		              "beInSingleCompositionLayer;"
		              constraintsDo: [ :c |
			              c ignoreByLayout.
			              c horizontal fitContent.
			              c vertical fitContent ].

	"aContainer addChildren: (self items collect: [ :aDragItem | aDragItem previewElement ])."
	aContainer addChildren: (self items collect: [ :aDragItem |
			 aDragItem sourceElement removeFromParent.
			 aDragItem sourceElement ]).

	^ aContainer
]

{ #category : #accessing }
BlDragDelegate >> offset [

	^ offset
]

{ #category : #accessing }
BlDragDelegate >> offset: aPoint [

	offset := aPoint
]

{ #category : #accessing }
BlDragDelegate >> parent [

	^ parent
]

{ #category : #accessing }
BlDragDelegate >> parent: anElement [

	parent := anElement
]
