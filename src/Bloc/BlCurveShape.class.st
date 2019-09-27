Class {
	#name : #BlCurveShape,
	#superclass : #BlCompositeShape,
	#category : #'Bloc-Basic-Vector Shapes'
}

{ #category : #accessing }
BlCurveShape >> fromPoint [
	^ self shapeWithAttribute: CurveFromPointAttribute includesValue: self
]

{ #category : #accessing }
BlCurveShape >> fromPoint: aPointShape [
	(aPointShape attributeAt: CurveFromPointAttribute ifAbsentPut: [ OrderedCollection new ]) add: self.

	self addShape: aPointShape
]

{ #category : #testing }
BlCurveShape >> isCurve [
	^ true
]

{ #category : #accessing }
BlCurveShape >> toPoint [
	^ self shapeWithAttribute: CurveToPointAttribute includesValue: self
]

{ #category : #accessing }
BlCurveShape >> toPoint: aPointShape [
	(aPointShape attributeAt: CurveToPointAttribute ifAbsentPut: [ OrderedCollection new ]) add: self.

	self addShape: aPointShape
]
