Class {
	#name : #BlVectorShape,
	#superclass : #Object,
	#instVars : [
		'parent',
		'attributes'
	],
	#classVars : [
		'CurveFromPointAttribute',
		'CurveToPointAttribute'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'class initialization' }
BlVectorShape class >> initialize [
	CurveFromPointAttribute := #lineFromPoint.
	CurveToPointAttribute := #lineToPoint
]

{ #category : #enumerating }
BlVectorShape >> allParentsDetect: aBlock ifFound: ifFoundBlock ifNone: ifNoneBlock [
	self allParentsDo: [ :aParent | 
		(aBlock value: aParent)
			ifTrue: [ ^ ifFoundBlock value: aParent ] ].
	^ ifNoneBlock value
]

{ #category : #enumerating }
BlVectorShape >> allParentsDo: aBlock [
	self hasParent
		ifFalse: [ ^ self ].

	aBlock value: self parent.
	self parent allParentsDo: aBlock
]

{ #category : #enumerating }
BlVectorShape >> allShapes [
	^ Array streamContents: [ :aStream | self shapesDo: [ :each | aStream nextPut: each ] ]
]

{ #category : #converting }
BlVectorShape >> appendPathTo: aPathBuilder [
]

{ #category : #converting }
BlVectorShape >> asElementIn: aContainer [
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName [
	^ self attributes at: aName
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName ifAbsent: aValue [
	^ self attributes at: aName ifAbsent: aValue
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName ifAbsentPut: aValue [
	^ self attributes at: aName ifAbsentPut: aValue
]

{ #category : #accessing }
BlVectorShape >> attributeAt: aName put: aValue [
	self attributes at: aName put: aValue
]

{ #category : #accessing }
BlVectorShape >> attributes [
	<return: #Dictionary>

	^ attributes
]

{ #category : #'api - geometry' }
BlVectorShape >> bounds [
	<return: #Rectangle>
	
	^ self allShapes
		ifEmpty: [ Rectangle origin: 0@0 extent: 0@0 ]
		ifNotEmpty: [ :theShapes |
			| theBounds |
			theBounds := theShapes first myBounds.
			theShapes allButFirstDo: [ :eachShape |
				| eachShapeBounds |
				eachShapeBounds := eachShape bounds.
				(theBounds isNil and: [ eachShapeBounds isNotNil ])
					ifTrue: [ theBounds := eachShapeBounds ].
				eachShapeBounds isNotNil
					ifTrue: [ theBounds := theBounds quickMerge: eachShapeBounds ] ].
			theBounds isNil
				ifTrue: [ theBounds := Rectangle origin: 0@0 extent: 0@0 ].
			theBounds ]
]

{ #category : #converting }
BlVectorShape >> buildPathOnSpartaCanvas: aCanvas [
	| aPathBuilder |
	
	aPathBuilder := aCanvas path.
	aPathBuilder moveTo: 0@0.
	self appendPathTo: aPathBuilder.
	^ aPathBuilder finish
]

{ #category : #'gt-extension' }
BlVectorShape >> gtAttributesFor: aView [
	<gtView>
	self attributes ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Attributes' translated;
		items: [ self attributes associations ];
		column: 'Name' 
			item: [ :anAssociation | anAssociation key ];
		column: 'Value' 
			item: [ :anAssociation | anAssociation value ]
]

{ #category : #'gt-extension' }
BlVectorShape >> gtLiveFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: [
			| aContainer |
			
			aContainer := BlVectorShapeContainerElement new.
			aContainer constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ].
			self asElementIn: aContainer.
			aContainer ]
]

{ #category : #testing }
BlVectorShape >> hasParent [
	^ parent isNotNil
]

{ #category : #initialization }
BlVectorShape >> initialize [
	super initialize.
	
	attributes := Dictionary new
]

{ #category : #testing }
BlVectorShape >> isCurve [
	^ false
]

{ #category : #'api - geometry' }
BlVectorShape >> myBounds [
	<return: #Rectangle or: nil>
	
	^ self subclassResponsibility
]

{ #category : #'api - geometry' }
BlVectorShape >> normalize [
	self normalizeIn: self bounds
]

{ #category : #'api - geometry' }
BlVectorShape >> normalizeIn: aRectangle [
	self allShapes asSet do: [ :eachShape | eachShape normalizeMeIn: aRectangle ]
]

{ #category : #'api - geometry' }
BlVectorShape >> normalizeMeIn: aRectangle [
	self subclassResponsibility
]

{ #category : #accessing }
BlVectorShape >> parent [
	<return: #BlCompositeShape>

	^ parent
]

{ #category : #accessing }
BlVectorShape >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
BlVectorShape >> parentDo: aBlock [
	self hasParent
		ifTrue: [ aBlock value: self parent ]
]

{ #category : #accessing }
BlVectorShape >> removeAttributeAt: aName [
	self attributes removeKey: aName ifAbsent: [  ]
]

{ #category : #'api - geometry' }
BlVectorShape >> scaleBy: aScalePoint [
	self allShapes asSet do: [ :eachShape | eachShape scaleMeBy: aScalePoint ]
]

{ #category : #'api - geometry' }
BlVectorShape >> scaleMeBy: aScalePoint [
	self subclassResponsibility
]

{ #category : #'api - geometry' }
BlVectorShape >> scaleMeToFit: aRectangle [
	self subclassResponsibility
]

{ #category : #'api - geometry' }
BlVectorShape >> scaleToFit: aRectangle [
	self allShapes asSet do: [ :eachShape | eachShape scaleMeToFit: aRectangle ]
]

{ #category : #enumerating }
BlVectorShape >> shapesDo: aBlock [
	aBlock value: self
]

{ #category : #'api - geometry' }
BlVectorShape >> value: aRectangle [
	self normalize scaleToFit: aRectangle
]
