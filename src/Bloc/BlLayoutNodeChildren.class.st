Class {
	#name : #BlLayoutNodeChildren,
	#superclass : #Array,
	#type : #variable,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> boundingBox [

	| aBoundingBox |
	self isEmpty ifTrue: [ ^ Rectangle left: 0 right: 0 top: 0 bottom: 0 ].

	aBoundingBox := self first bounds.
	self allButFirstDo: [ :aChild |
		aBoundingBox merge: aChild bounds ].

	aBoundingBox expand.
	
	^ aBoundingBox asRectangle
]

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> extent [

	^ self collect: [ :eachChild | eachChild extent ] as: Array
]

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> layoutBounds [

	^ self
		  collect: [ :eachChild | eachChild layoutBounds asRectangle ]
		  as: Array
]

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> normalizePositions [

	| theTopLeft |
	self ifEmpty: [ ^ self ].

	theTopLeft :=
		self
			inject: self first position
			into: [ :topLeft :eachNode |
				topLeft min: eachNode position ].

	self do: [ :eachNode |
		eachNode position: eachNode position - theTopLeft ]
]

{ #category : #'api - geometry' }
BlLayoutNodeChildren >> roundPositions [

	self do: [ :eachNode | eachNode position: eachNode position rounded ]
]

{ #category : #converting }
BlLayoutNodeChildren >> withoutElement [

	^ self collect: [ :eachNode | eachNode withoutElement ]
]

{ #category : #converting }
BlLayoutNodeChildren >> withoutTransformation [

	^ self collect: [ :eachNode | eachNode withoutTransformation ]
]
