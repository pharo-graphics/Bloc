Class {
	#name : #BlSvgPathSegment,
	#superclass : #Object,
	#instVars : [
		'isAbsolute'
	],
	#category : #'Bloc-Geometry-SVG'
}

{ #category : #'instance creation' }
BlSvgPathSegment class >> absolute [
	^ self new isAbsolute: true
]

{ #category : #'instance creation' }
BlSvgPathSegment class >> absolute: aBoolean [
	^ self new isAbsolute: aBoolean
]

{ #category : #'instance creation' }
BlSvgPathSegment class >> relative [
	^ self new isAbsolute: false
]

{ #category : #executing }
BlSvgPathSegment >> executeOn: aBuilder [
	self subclassResponsibility
]

{ #category : #initialization }
BlSvgPathSegment >> initialize [
	super initialize.
	
	isAbsolute := true
]

{ #category : #accessing }
BlSvgPathSegment >> isAbsolute [
	^ isAbsolute
]

{ #category : #accessing }
BlSvgPathSegment >> isAbsolute: aBoolean [
	isAbsolute := aBoolean
]

{ #category : #printing }
BlSvgPathSegment >> printAbsolute [
	^ self isAbsolute
		ifTrue: [ 'absolute' ]
		ifFalse: [ 'relative' ]
]
