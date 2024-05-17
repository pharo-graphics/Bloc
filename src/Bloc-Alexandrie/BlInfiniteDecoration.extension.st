Extension { #name : #BlInfiniteDecoration }

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteDecoration >> aeDraw: anItemElement beneathOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	
]

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteDecoration >> aeDraw: anItemElement overOn: aSpartaCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element for its child element anItemElement. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"

	
]

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteDecoration >> aeDrawBeneathOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn before the item elements are drawn, and will thus appear underneath them"

	anInfiniteElement children sortedByElevation do: [ :child | 
		self aeDraw: child beneathOn: aCanvas in: anInfiniteElement ].

]

{ #category : #'*Bloc-Alexandrie' }
BlInfiniteDecoration >> aeDrawOverOn: aCanvas in: anInfiniteElement [

	"Draw any appropriate decorations into the Sparta Canvas supplied to the Infinite Element. Any content drawn by this method will be drawn after the item elements are drawn, and will thus appear over them"
	anInfiniteElement children sortedByElevation do: [ :child | 
		self aeDraw: child overOn: aCanvas in: anInfiniteElement ].

]
