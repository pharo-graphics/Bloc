Class {
	#name : 'BlElementBoundsUpdater',
	#superclass : 'Object',
	#instVars : [
		'changes'
	],
	#package : 'Bloc',
	#tag : 'Basic-Bounds'
}

{ #category : 'api - changes' }
BlElementBoundsUpdater >> changeExtentFrom: aPreviousExtent to: aNewExtent of: anElement [
	(changes
		at: anElement
		ifAbsentPut: [ BlElementBoundsUpdaterChange new element: anElement ])
			changeExtentFrom: aPreviousExtent to: aNewExtent
]

{ #category : 'api - changes' }
BlElementBoundsUpdater >> changePositionFrom: aPreviousPosition to: aNewPosition of: anElement [
	(changes
		at: anElement
		ifAbsentPut: [ BlElementBoundsUpdaterChange new element: anElement ])
			changePositionFrom: aPreviousPosition to: aNewPosition
]

{ #category : 'change reporting' }
BlElementBoundsUpdater >> commitChanges [

	| theAssociations theElements theRoots |
	
	changes associations ifEmpty: [ ^ self ].
		
	theAssociations := changes associations sorted: [ :a :b | a value compositionDepth > b value compositionDepth ].
	theAssociations do: [ :eachAssociation | eachAssociation value commitLocalChanges ].
	theElements := theAssociations 
							select: [ :eachAssociation | eachAssociation value isPositionChanged ]
		               thenCollect: [ :eachAssociation | eachAssociation key ].
	theElements ifEmpty: [ ^ self ].
	
	"<---"
	self flag: 'Workarroud: avoiding #extractRoots: use speed-up position updates a lot'.
	"theElements do: [ :eachRootElement |
		eachRootElement withAllChildrenBreadthFirstDo: [ :eachChild |	eachChild onPositionInSpaceChanged ] ]."
	"--->"
	self flag: 'Original version'.
	"<---"
	self flag: ' It sounds better with #extractRoots: from feenk '.
	theRoots := BlSpace extractRoots: theElements.
	theRoots do: [ :eachRootElement |
		eachRootElement withAllChildrenBreadthFirstDo: [ :eachChild | eachChild onPositionInSpaceChanged ] ]
	"--->"

]

{ #category : 'testing' }
BlElementBoundsUpdater >> hasChanges [ 

	^ changes notEmpty
]

{ #category : 'testing' }
BlElementBoundsUpdater >> hasExtentChanges [ 

	^ changes anySatisfy: [ :c | c isExtentChanged ]
]

{ #category : 'testing' }
BlElementBoundsUpdater >> hasPositionChanges [ 

	^ changes anySatisfy: [ :c | c isPositionChanged ]
]

{ #category : 'initialization' }
BlElementBoundsUpdater >> initialize [
	super initialize.
	
	changes := IdentityDictionary new.
]
