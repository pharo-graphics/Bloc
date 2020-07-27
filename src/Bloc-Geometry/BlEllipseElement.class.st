"
I am an ellipse element driven by a center anchor that describes where my center should be.
My extent depends on major and minor radii.

https://en.wikipedia.org/wiki/Ellipse
"
Class {
	#name : #BlEllipseElement,
	#superclass : #BlGeometryElement,
	#instVars : [
		'centerAnchor',
		'majorRadius',
		'minorRadius'
	],
	#category : #'Bloc-Geometry-Ellipse'
}

{ #category : #'instance creation' }
BlEllipseElement class >> radius: aNumber [
	"Create a circle element of a given radius"
	<return: #BlEllipseElement>
	
	^ self new
		majorRadius: aNumber;
		minorRadius: aNumber
]

{ #category : #'anchor - accessing' }
BlEllipseElement >> centerAnchor [
	^ centerAnchor
]

{ #category : #'anchor - accessing' }
BlEllipseElement >> centerAnchor: aBlGeometryAnchor [

	centerAnchor := aBlGeometryAnchor.
	self registerAnchor: aBlGeometryAnchor
]

{ #category : #'anchor - geometry' }
BlEllipseElement >> centerPosition [
	<return: #Point>
	
	^ self centerAnchor positionWithin: self
]

{ #category : #initialization }
BlEllipseElement >> defaultCenterAnchor [
	^ BlAbsolutePositionAnchor position: 100@100
]

{ #category : #initialization }
BlEllipseElement >> initialize [
	super initialize.
	
	visuals := BlCustomVisuals new
		geometry: BlEllipse new.
	
	centerAnchor := self defaultCenterAnchor.
	majorRadius := 75.
	minorRadius := 50
]

{ #category : #layout }
BlEllipseElement >> layoutBounds [
	<return: #Rectangle>
	| aCenterPosition anOrigin aCorner|
	
	aCenterPosition := self centerPosition.
	anOrigin := aCenterPosition - (self majorRadius @ self minorRadius).
	aCorner := aCenterPosition + (self majorRadius @ self minorRadius).
	
	^ anOrigin corner: aCorner
]

{ #category : #accessing }
BlEllipseElement >> majorRadius [
	<return: #Number>

	^ majorRadius
]

{ #category : #accessing }
BlEllipseElement >> majorRadius: aNumber [
	"Set my major radius along X-axis"

	majorRadius := aNumber.
	self requestLayout
]

{ #category : #layout }
BlEllipseElement >> measureGeometry [

	self geometry extent: (self majorRadius @ self minorRadius) * 2
]

{ #category : #accessing }
BlEllipseElement >> minorRadius [
	<return: #Number>

	^ minorRadius
]

{ #category : #accessing }
BlEllipseElement >> minorRadius: aNumber [
	"Set my minor radius along Y-axis"

	minorRadius := aNumber.
	self requestLayout
]
