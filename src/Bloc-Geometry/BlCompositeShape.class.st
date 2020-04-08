Class {
	#name : #BlCompositeShape,
	#superclass : #BlVectorShape,
	#instVars : [
		'shapes'
	],
	#category : #'Bloc-Geometry-Shaper'
}

{ #category : #'api - shapes' }
BlCompositeShape >> addShape: aShape [
	aShape parent: self.
	shapes add: aShape
]

{ #category : #converting }
BlCompositeShape >> asElementIn: aContainer [
	self shapes do: [ :each | each asElementIn: aContainer ]
]

{ #category : #'gt-extension' }
BlCompositeShape >> gtShapesFor: aView [
	<gtView>
	
	^ aView columnedTree
		title: 'Shapes';
		priority: 10;
		items: [ {self} ];
		expandAll;
		children: [ :each | (each  respondsTo: #shapes) 
			ifTrue: [each shapes]
			ifFalse: [{}]];
		column: 'Preview' do: [ :aColumn |
			aColumn
				noResize;
				rowStencil: [ :eachShape |
					| container |
					container := BlVectorShapeContainerElement new
						layout: BlFitLayout new;
						constraintsDo: [:c | c horizontal fitContent. c vertical fitContent].
					(eachShape asElementIn: container).
					BlElement new
						size: 50@30;
						margin: (BlInsets top: 2 bottom: 2);
						addChild: container asScalableElement ] ];
		column: 'Shape' item: [ :each | each ]
]

{ #category : #initialization }
BlCompositeShape >> initialize [
	super initialize.
	
	shapes := OrderedCollection new
]

{ #category : #'api - geometry' }
BlCompositeShape >> myBounds [
	<return: #Rectangle or: nil>
	
	^ nil
]

{ #category : #'api - geometry' }
BlCompositeShape >> normalizeMeIn: aRectangle [
]

{ #category : #'api - shapes' }
BlCompositeShape >> replaceShape: anOldShape with: aNewShape [
	
	(shapes includes: anOldShape)
		ifFalse: [ ^ self error: 'No such shape to replace' ].

	aNewShape attributes addAll: anOldShape attributes.

	anOldShape parent: nil.
	aNewShape parent: self.

	shapes replaceAll: anOldShape with: aNewShape
]

{ #category : #'api - geometry' }
BlCompositeShape >> scaleMeBy: aScalePoint [
]

{ #category : #'api - geometry' }
BlCompositeShape >> scaleMeToFit: aRectangle [
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName includesValue: aValue [
	^ self allShapes detect: [ :each | each attributes
		at: aName
		ifPresent: [ :eachValue | eachValue includes: aValue ]
		ifAbsent: [ false ] ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapeWithAttribute: aName value: aValue [
	^ self allShapes detect: [ :each | each attributes
		at: aName
		ifPresent: [ :eachValue | eachValue = aValue ]
		ifAbsent: [ false ] ]
]

{ #category : #accessing }
BlCompositeShape >> shapes [
	^ shapes
]

{ #category : #accessing }
BlCompositeShape >> shapes: aCollectionOfShapes [
	shapes := aCollectionOfShapes asOrderedCollection.
	shapes do: [ :each | each parent: self ]
]

{ #category : #'api - shapes' }
BlCompositeShape >> shapesDo: aBlock [
	aBlock value: self.
	self shapes do: [ :each | each shapesDo: aBlock ]
]
