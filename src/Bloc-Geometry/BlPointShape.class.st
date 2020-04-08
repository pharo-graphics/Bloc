Class {
	#name : #BlPointShape,
	#superclass : #BlVectorShape,
	#instVars : [
		'point'
	],
	#category : #'Bloc-Geometry-Shaper'
}

{ #category : #converting }
BlPointShape >> asElement [
	^ BlElement new
		geometry: BlCircle new;
		background: Color gray;
		size: 6@6;
		relocate: (self point - (3@3));
		elevation: (BlRelativeElevation elevation: 10);
		addEventHandler: BlPullHandler new
]

{ #category : #private }
BlPointShape >> moveBy: aDelta [
	self point: self point + aDelta
]

{ #category : #'api - geometry' }
BlPointShape >> myBounds [
	<return: #Rectangle or: nil>
	
	^ self point extent: 0@0
]

{ #category : #converting }
BlPointShape >> normalizeMeIn: aRectangle [

	(aRectangle extent x isZero or: [ aRectangle extent y isZero ])
		ifTrue: [ ^ self ].

	point := (self point - aRectangle origin) / aRectangle extent asFloatPoint
]

{ #category : #accessing }
BlPointShape >> point [
	^ point
]

{ #category : #accessing }
BlPointShape >> point: anObject [
	point := anObject
]

{ #category : #printing }
BlPointShape >> printOn: aStream [
	aStream
		nextPutAll: 'Point at ';
		print: self point
]

{ #category : #converting }
BlPointShape >> scaleMeBy: aScalePoint [
	point := point * aScalePoint
]

{ #category : #converting }
BlPointShape >> scaleMeToFit: aRectangle [
	(aRectangle extent x isZero or: [ aRectangle extent y isZero ])
		ifTrue: [ ^ self ].

	point := point * aRectangle extent.
	point := point + aRectangle origin
]
