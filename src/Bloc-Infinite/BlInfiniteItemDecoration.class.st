"
I allow users to add a special drawing and layout offset to specific item elements from the data set. This can be useful for drawing dividers between items, highlights, visual grouping boundaries and more.
"
Class {
	#name : #BlInfiniteItemDecoration,
	#superclass : #Object,
	#category : 'Bloc-Infinite-Basic'
}

{ #category : #drawing }
BlInfiniteItemDecoration >> drawOnSpartaCanvas: aSpartaCanvas in: anInfiniteElement [
	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element.
	Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"
]

{ #category : #drawing }
BlInfiniteItemDecoration >> drawOnSpartaCanvasOver: aSpartaCanvas in: anInfiniteElement [
	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element.
	Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"
]

{ #category : #geometry }
BlInfiniteItemDecoration >> itemOffset: anItemElement in: anInfiniteElement [
	"Retrieve any offsets for the given item element.
	If this ItemDecoration does not affect the positioning of item element, it should return empty insets"
	<return: #BlInsets>
	
	^ BlInsets empty
]
