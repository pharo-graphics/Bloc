"
This class is part of a new DragHandler prototype
"
Class {
	#name : #BlDragDelegateNew,
	#superclass : #Object,
	#instVars : [
		'items',
		'dragArea',
		'offset',
		'parent',
		'dragStrategy'
	],
	#category : #'Bloc-DragNDrop-core - experiment'
}

{ #category : #'drag and drop' }
BlDragDelegateNew >> cancel: aDraggedContainer at: aPoint in: aParentElement [
	"Cancel drag and animate previews"

	"| aCancelAnimation |"

	self items ifEmpty: [ ^ self ].

	"self halt."
	self items do: [ :eachItem | "aCancelAnimation := BlParallelAnimation withAll:
		                    (self items collect: [ :aDragItem |
			                     | aPreviewBounds aSourceBounds aPreviewElement |
			                     aPreviewElement := aDragItem sourceElement.

			                     aPreviewBounds := aPreviewElement bounds
				                                       inSpace.
			                     aSourceBounds := aDragItem sourceElement
				                                      bounds inSpace.

			                     BlNumberTransition new
				                     from: aPoint;
				                     to:
					                     aSourceBounds center
					                     - (aPreviewBounds extent / 2.0);
				                     easing: (BlDecelerateInterpolator factor: 2);
				                     duration: 350 milliSeconds;
				                     onStepDo: [ :aPosition |
					                     aPreviewElement position: aPosition ] ]).

	parent addAnimation: aCancelAnimation""didn't include element state in my code picking""self items do: [ :each |
		each sourceElement states
			removeState: BlElementDraggingState uniqueInstance ]"
		| aPreviewElement |
		aPreviewElement := eachItem sourceElement.
		aPreviewElement removeFromParent.
		dragStrategy drop: aPreviewElement at: aPoint - offset.
		"aPreviewElement position: aPoint - offset."
		parent addChild: aPreviewElement ]
]

{ #category : #'drag and drop' }
BlDragDelegateNew >> drag: aDraggedContainer to: aPoint [
	"Drag a container with all previews to a given point in the parent coordinate of the container"

	"horizontal drag&drop, used by GToolkit to reorder tabs on top of its interface"

	"aDraggedContainer position:
		(aPoint - offset) x @ aDraggedContainer measuredBounds position y"

	"vertical drag & drop :"

	"aDraggedContainer position:
		aDraggedContainer measuredBounds position x @ (aPoint - offset) y"

	"normal drag & drop"

	dragStrategy drag: aDraggedContainer to: aPoint withOffset: offset.
	"aDraggedContainer position: aPoint - offset"
]

{ #category : #accessing }
BlDragDelegateNew >> dragArea [

	^ dragArea
]

{ #category : #accessing }
BlDragDelegateNew >> dragArea: anObject [

	dragArea := anObject
]

{ #category : #accessing }
BlDragDelegateNew >> dragStrategy [ 

	^ dragStrategy 
]

{ #category : #accessing }
BlDragDelegateNew >> dragStrategy: aBlDragStrategy [

	dragStrategy := aBlDragStrategy 
]

{ #category : #testing }
BlDragDelegateNew >> hasDragArea [
	^ dragArea notNil
]

{ #category : #initialization }
BlDragDelegateNew >> initialize [

	super initialize.
	items := {  }.
	dragStrategy := BlDragDefaultStrategy uniqueInstance 
]

{ #category : #accessing }
BlDragDelegateNew >> items [

	^ items
]

{ #category : #accessing }
BlDragDelegateNew >> items: aCollectionOfDragItems [

	items := aCollectionOfDragItems
]

{ #category : #'drag and drop' }
BlDragDelegateNew >> lift [
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

	"didn't include element state in my code picking"
	"self items do: [ :each |
		each sourceElement states
			addState: BlElementDraggingState uniqueInstance ]."

	^ aContainer
]

{ #category : #accessing }
BlDragDelegateNew >> offset [

	^ offset
]

{ #category : #accessing }
BlDragDelegateNew >> offset: anObject [

	offset := anObject
]

{ #category : #accessing }
BlDragDelegateNew >> parent [

	^ parent
]

{ #category : #accessing }
BlDragDelegateNew >> parent: anObject [

	parent := anObject
]
