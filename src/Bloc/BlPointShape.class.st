Class {
	#name : #BlPointShape,
	#superclass : #BlVectorShape,
	#instVars : [
		'point'
	],
	#category : #'Bloc-Basic-Vector Shapes'
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

{ #category : #accessing }
BlPointShape >> point [
	^ point
]

{ #category : #accessing }
BlPointShape >> point: anObject [
	point := anObject
]
