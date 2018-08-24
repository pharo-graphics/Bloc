"
Drag delegate provides drag items when a visual element lifts.
Drag gesture fails if there are no drag items
"
Class {
	#name : #BlDragDelegate,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : 'Bloc-Utilities - Drag&Drop'
}

{ #category : #'drag and drop' }
BlDragDelegate >> cancel: aPoint [
	"Cancel drag and animate previews"	
	| aCancelAnimation |

	aCancelAnimation := BlParallelAnimation with: (self items collect: [ :aDragItem |
		| aPreviewBounds aSourceBounds aPreviewElement |
		aPreviewElement := aDragItem previewElement.
		
		aPreviewBounds := aPreviewElement bounds inSpace.
		aSourceBounds := aDragItem sourceElement bounds inSpace.
		
		BlNumberTransition new
			from: (aPreviewBounds position);
			to: (aSourceBounds center - (aPreviewBounds extent / 2.0));
			easing: (BlDecelerateInterpolator factor: 2);
			duration: 500 milliSeconds;
			onStepDo: [ :aPosition | aPreviewElement relocate: aPosition ];
			onFinishedDo: [ aPreviewElement removeFromParent ].
	]).

	aCancelAnimation start
]

{ #category : #'drag and drop' }
BlDragDelegate >> drag: aPoint [
	"Drag all previews to a given point in parent coordinates of previews"
	
	self items do: [ :aDragItem | aDragItem previewElement relocate: aPoint ]
]

{ #category : #initialization }
BlDragDelegate >> initialize [
	super initialize.

	items := { }
]

{ #category : #accessing }
BlDragDelegate >> items [
	"Drag gesture fails if there are no drag items"
	<return: #SequenceableCollection of: #BlDragItem>

	^ items
]

{ #category : #accessing }
BlDragDelegate >> items: aCollectionOfDragItems [
	items := aCollectionOfDragItems
]

{ #category : #'drag and drop' }
BlDragDelegate >> lift: aPoint in: anElement [
	"Lift previews at a given point in space coordinates"

	anElement addChildren: (self items collect: [ :aDragItem |
		aDragItem previewElement relocate: aPoint
	])
]
