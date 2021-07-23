Class {
	#name : 'BlElementBoundsUpdater',
	#superclass : 'Object',
	#instVars : [
		'changes'
	],
	#category : 'Bloc-Basic-Bounds'
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
	
	theAssociations := (changes associations sorted: [ :a :b | a key compositionDepth > b key compositionDepth ]).
	
	theAssociations ifNotEmpty: [
		theAssociations first key telemetry
			timeSync: [ 'commitChanges' ]
			during: [ 
				theAssociations do: [ :eachAssociation | eachAssociation value commitLocalChanges ].
				
				theElements := theAssociations
					select: [ :eachAssociation | eachAssociation value isPositionChanged ]
					thenCollect: [ :eachAssociation | eachAssociation key ].

				theRoots := BlSpace extractRoots: theElements.
				theRoots do: [ :eachRootElement |
					eachRootElement telemetry
						timeSync: [ 'onPositionInSpaceChanged ', eachRootElement class name ]
						during: [ eachRootElement withAllChildrenBreadthFirstDo: [ :eachChild | eachChild onPositionInSpaceChanged ] ] ]  ] ]
]

{ #category : 'initialization' }
BlElementBoundsUpdater >> initialize [
	super initialize.
	
	changes := IdentityDictionary new.
]
