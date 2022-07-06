Extension { #name : #BlInfiniteElement }

{ #category : #'*Bloc-Sparta' }
BlInfiniteElement >> drawMeAndChildrenOnSpartaCanvas: aCanvas [
	" draw then decorate (over children)"
	super drawMeAndChildrenOnSpartaCanvas: aCanvas.
	self itemDecorationsDo: [ :d | 
		d drawOnSpartaCanvasOver: aCanvas in: self ]
]

{ #category : #'*Bloc-Sparta' }
BlInfiniteElement >> drawOnSpartaCanvas: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super drawOnSpartaCanvas: aCanvas.
	self itemDecorationsDo: [ :d | 
		d drawOnSpartaCanvas: aCanvas in: self ].

]
