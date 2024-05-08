Class {
	#name : #BlInfiniteDecoration,
	#superclass : #Object,
	#instVars : [
		'computedBounds',
		'decorationInsets',
		'priority'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #'as yet unclassified' }
BlInfiniteDecoration >> aeDraw: anItemElement beneathOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	
]

{ #category : #'as yet unclassified' }
BlInfiniteDecoration >> aeDraw: anItemElement overOn: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"

	
]

{ #category : #'as yet unclassified' }
BlInfiniteDecoration >> aeDrawBeneathOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	anInfiniteElement children sortedByElevation do: [ :child | 
		self aeDraw: child beneathOn: aCanvas in: anInfiniteElement ].

]

{ #category : #'as yet unclassified' }
BlInfiniteDecoration >> aeDrawOverOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"
	anInfiniteElement children sortedByElevation do: [ :child | 
		self aeDraw: child overOn: aCanvas in: anInfiniteElement ].

]

{ #category : #geometry }
BlInfiniteDecoration >> computedBounds [ 
	^ computedBounds ifNil: [ Rectangle origin: 0 asPoint corner: 0 asPoint]
]

{ #category : #geometry }
BlInfiniteDecoration >> decorationInsets [
	"Return the insets (instance of BlInsets) for the given item element. Be aware that only one side is used"

	
	^ decorationInsets 
]

{ #category : #geometry }
BlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement
]

{ #category : #geometry }
BlInfiniteDecoration >> getDecorationsInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ decorationInsets := self requiredInsetsOfChildElement: anElement in: anInfiniteElement 
]

{ #category : #initialization }
BlInfiniteDecoration >> initialize [ 
	super initialize.
	decorationInsets := BlInsets empty
]

{ #category : #updating }
BlInfiniteDecoration >> onLayoutDoneIn: anEditorElement remaining: remainingRectangle [

	| insets rbnds |
	insets := self decorationInsets.
	rbnds := remainingRectangle.
	insets left isZero ifFalse: [ | insetsLeft |
		insetsLeft := insets left .
		computedBounds := rbnds origin corner: rbnds left + insetsLeft @ rbnds bottom.
		^ rbnds left + insetsLeft @ rbnds top extent: rbnds extent ].
	insets top isZero ifFalse: [ 
		^ rbnds left @ rbnds top + insets top corner: rbnds corner ].
	insets right isZero ifFalse: [ | insetsRight |
		insetsRight := insets right + anEditorElement border width.
		computedBounds := rbnds right - insetsRight @ rbnds top corner: rbnds corner.
		^ rbnds origin corner: rbnds right - insetsRight @ rbnds bottom ].
	insets bottom isZero ifFalse: [ ^ rbnds origin corner: rbnds corner right @ rbnds bottom - insets bottom ].
	^ remainingRectangle
]

{ #category : #accessing }
BlInfiniteDecoration >> priority [
	^ priority ifNil: [ priority := 0 ]
	
]

{ #category : #accessing }
BlInfiniteDecoration >> priority: anInteger [
	priority := anInteger
	
]

{ #category : #geometry }
BlInfiniteDecoration >> requiredInsetsOfChildElement: anElement [ 
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]

{ #category : #geometry }
BlInfiniteDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [
	"get the insets for the given item element. Be aware that only one side is used"
	<return: #BlInsets>
	
	^ BlInsets empty
]
