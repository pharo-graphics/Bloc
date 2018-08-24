Class {
	#name : #BlSvgPathCubicBezierSegment,
	#superclass : #BlSvgPathSegment,
	#instVars : [
		'firstViaPoint',
		'secondViaPoint',
		'curveTo'
	],
	#category : 'Bloc-SVG-Path'
}

{ #category : #comparing }
BlSvgPathCubicBezierSegment >> = anotherObject [

	self == anotherObject
		ifTrue: [ ^ true ].
	(anotherObject isKindOf: self class)
		ifFalse: [ ^ false ].

	^ anotherObject isAbsolute = self isAbsolute
		and: [ anotherObject curveTo = self curveTo
			and: [ anotherObject firstViaPoint = self firstViaPoint
				and: [ anotherObject secondViaPoint = self secondViaPoint ] ] ]
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> curveTo [
	^ curveTo
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> curveTo: anObject [
	curveTo := anObject
]

{ #category : #executing }
BlSvgPathCubicBezierSegment >> executeOn: aBuilder [
	aBuilder curveVia: self firstViaPoint and: self secondViaPoint to: self curveTo 
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> firstViaPoint [
	^ firstViaPoint
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> firstViaPoint: anObject [
	firstViaPoint := anObject
]

{ #category : #comparing }
BlSvgPathCubicBezierSegment >> hash [
	^ ((self isAbsolute hash bitXor: self curveTo hash) bitXor: self firstViaPoint hash) bitXor: self secondViaPoint hash
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> secondViaPoint [
	^ secondViaPoint
]

{ #category : #accessing }
BlSvgPathCubicBezierSegment >> secondViaPoint: anObject [
	secondViaPoint := anObject
]
