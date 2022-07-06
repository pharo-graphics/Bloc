Extension { #name : #BlInfiniteElement }

{ #category : #'*Bloc-Sparta' }
BlInfiniteElement >> drawChildrenOnSpartaCanvas: aCanvas [
	" draw then decorate eventually (between the background and the childrens)"
	super drawChildrenOnSpartaCanvas: aCanvas.
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
