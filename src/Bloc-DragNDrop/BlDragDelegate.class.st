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

"self halt."
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
					                     aPreviewElement position: aPosition ]";"
				                     "onFinishedDo: [
					                     aPreviewElement removeFromParent ]" ]).

	parent addAnimation: aCancelAnimation

	"didn't include element state in my code picking"
	"self items do: [ :each |
		each sourceElement states
			removeState: BlElementDraggingState uniqueInstance ]"
]

{ #category : #'drag and drop' }
BlDragDelegate >> drag: aDraggedContainer to: aPoint [
	"Drag a container with all previews to a given point in the parent coordinate of the container"

	"horizontal drag&drop, used by GToolkit to reorder tabs on top of its interface"

	"aDraggedContainer position:
		(aPoint - offset) x @ aDraggedContainer measuredBounds position y"

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
BlDragDelegate >> liftAt: aPoint [
	"Lift previews at a given point in space coordinates"
	<return: #BlElement>
	| aContainer |

	aContainer := BlElement new
		layout: BlFrameLayout new;
		beInSingleCompositionLayer;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c horizontal fitContent.
			c vertical fitContent ].

	"aContainer addChildren: (self items collect: [ :aDragItem | aDragItem previewElement ])."
	aContainer addChildren: (self items collect: [ :aDragItem | aDragItem sourceElement removeFromParent. aDragItem sourceElement  ]).

"didn't include element state in my code picking"
	"self items do: [ :each |
		each sourceElement states
			addState: BlElementDraggingState uniqueInstance ]."

	^ aContainer
]

{ #category : #accessing }
BlDragDelegate >> offset [

	^ offset
]

{ #category : #accessing }
BlDragDelegate >> offset: anObject [

	offset := anObject
]

{ #category : #accessing }
BlDragDelegate >> parent [

	^ parent
]

{ #category : #accessing }
BlDragDelegate >> parent: anObject [

	parent := anObject
]
