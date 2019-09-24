Class {
	#name : #BlLineShape,
	#superclass : #BlCompositeShape,
	#classVars : [
		'LineFromPointAttribute',
		'LineToPointAttribute'
	],
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #'class initialization' }
BlLineShape class >> initialize [
	LineFromPointAttribute := #lineFromPoint.
	LineToPointAttribute := #lineToPoint
]

{ #category : #converting }
BlLineShape >> asElement [
	^ BlLineElement new
		border: (BlBorder paint: Color gray width: 1)
]

{ #category : #converting }
BlLineShape >> asElementIn: aContainer [
	| aFromElement aToElement aLineElement |
	
	aFromElement := aContainer
		elementForShape: self fromPoint
		ifAbsentAdd: #asElement.

	aToElement := aContainer
		elementForShape: self toPoint
		ifAbsentAdd: #asElement.

	aLineElement := aContainer
		elementForShape: self
		ifAbsentAdd: #asElement.
		
	aLineElement
		fromAnchor: (BlElementCenterAnchor element: aFromElement);
		toAnchor: (BlElementCenterAnchor element: aToElement)
]

{ #category : #accessing }
BlLineShape >> fromPoint [
	^ self shapeWithAttribute: LineFromPointAttribute includesValue: self
]

{ #category : #accessing }
BlLineShape >> fromPoint: aPointShape [
	(aPointShape attributeAt: LineFromPointAttribute ifAbsentPut: [ OrderedCollection new ]) add: self.
	self addShape: aPointShape
]

{ #category : #accessing }
BlLineShape >> injectLineAt: aFloat length: aLength [
	<return: #BlVectorShape>
	| aNewShape aLeftSplitPoint aRightSplitPoint aRightLine aLineVector aSplitPoint aLeftLine aCenterLine |
	
	aLineVector := self toPoint point - self fromPoint point.
	aSplitPoint := self fromPoint point + (aLineVector * aFloat).

	aLeftSplitPoint := (BlConnectionPointShape new point: aSplitPoint - (aLength * aLineVector normalized)).
	aRightSplitPoint := (BlConnectionPointShape new point: aSplitPoint + (aLength * aLineVector normalized)).

	aNewShape := BlThreeSegmentPolylineShape new.
	
	aLeftLine := BlLineShape new
		fromPoint: self fromPoint;
		toPoint: aLeftSplitPoint.
		
	aCenterLine := BlLineShape new
		fromPoint: aLeftSplitPoint;
		toPoint: aRightSplitPoint.
		
	aRightLine := BlLineShape new
		fromPoint: aRightSplitPoint;
		toPoint: self toPoint.
		
	(self fromPoint attributeAt: LineFromPointAttribute) remove: self.
	(self toPoint attributeAt: LineToPointAttribute) remove: self.
		
	aNewShape shapes: { aLeftLine . aCenterLine . aRightLine }.
	
	self parentDo: [ :aParentShape | aParentShape replaceShape: self with: aNewShape ].
	
	^ aNewShape
]

{ #category : #accessing }
BlLineShape >> splitAt: aFloat [
	<return: #BlVectorShape>
	| aNewShape aSplitPoint aLeftLine aRightLine |
	
	aSplitPoint := (BlConnectionPointShape new point: self fromPoint point + ((self toPoint point - self fromPoint point) * aFloat)).
	
	aNewShape := BlTwoSegmentPolylineShape new.
	aLeftLine := BlLineShape new
		fromPoint: self fromPoint;
		toPoint: aSplitPoint.
		
	aRightLine := BlLineShape new
		fromPoint: aSplitPoint;
		toPoint: self toPoint.
	
	(self fromPoint attributeAt: LineFromPointAttribute) remove: self.
	(self toPoint attributeAt: LineToPointAttribute) remove: self.
	
	aNewShape shapes: { aLeftLine . aRightLine }.
	
	self parentDo: [ :aParentShape | aParentShape replaceShape: self with: aNewShape ].
	
	^ aNewShape
]

{ #category : #accessing }
BlLineShape >> toPoint [
	^ self shapeWithAttribute: LineToPointAttribute includesValue: self
]

{ #category : #accessing }
BlLineShape >> toPoint: aPointShape [
	(aPointShape attributeAt: LineToPointAttribute ifAbsentPut: [ OrderedCollection new ]) add: self.
	self addShape: aPointShape
]
