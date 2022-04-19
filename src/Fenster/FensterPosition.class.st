"
# Fenster Position

Represents a position of an object on a display and is given by (x,y) coordinates.
There are two types of position:
	* logical position - defined in dpi independent points
	* physical position - defined in physical pixels
"
Class {
	#name : #FensterPosition,
	#superclass : #Object,
	#instVars : [
		'x',
		'y'
	],
	#category : #'Fenster-Geometry'
}

{ #category : #'instance creation' }
FensterPosition class >> fromPoint: aPoint [
	^ self x: aPoint x y: aPoint y
]

{ #category : #'instance creation' }
FensterPosition class >> x: aX y: aY [
	^ self new initializeX: aX Y: aY
]

{ #category : #'api - arithmetic' }
FensterPosition >> + aGtFensterPosition [
	<return: #FensterPosition>

	^ self class
		x: self x + aGtFensterPosition x
		y: self y + aGtFensterPosition y
]

{ #category : #'api - arithmetic' }
FensterPosition >> - aGtFensterPosition [
	<return: #FensterPosition>

	^ self class
		x: self x - aGtFensterPosition x
		y: self y - aGtFensterPosition y
]

{ #category : #comparing }
FensterPosition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ x = anObject x and: [ y = anObject y ]
]

{ #category : #'api - converting' }
FensterPosition >> asLogical: aScaleFactor [
	<return: #FensterLogicalPosition>
	
	^ self subclassResponsibility
]

{ #category : #'api - converting' }
FensterPosition >> asPhysical: aScaleFactor [
	<return: #FensterPhysicalPosition>
	
	^ self subclassResponsibility
]

{ #category : #'api - converting' }
FensterPosition >> asPoint [
	<return: #Point>

	^ self x @ self y
]

{ #category : #comparing }
FensterPosition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ y hash bitXor: x hash
]

{ #category : #initialization }
FensterPosition >> initialize [
	super initialize.
	
	x := 0.
	y := 0
]

{ #category : #initialization }
FensterPosition >> initializeX: aX Y: aY [
	x := aX.
	y := aY
]

{ #category : #testing }
FensterPosition >> isZero [
	<return: #Boolean>
	
	^ self x isZero or: [ self y isZero ]
]

{ #category : #printing }
FensterPosition >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' { x: ';
		print: x;
		nextPutAll: ' y: ';
		print: y;
		nextPutAll: ' }'
]

{ #category : #'truncation and round off' }
FensterPosition >> rounded [
	^ self class
		x: self x floor
		y: self y floor
]

{ #category : #accessing }
FensterPosition >> x [
	<return: #Number>

	^ x
]

{ #category : #accessing }
FensterPosition >> y [
	<return: #Number>

	^ y
]
