"
# Fenster Position

Represents a position of an object on a display and is given by (x,y) coordinates.
There are two types of position:
	* logical position - defined in dpi independent points
	* physical position - defined in physical pixels
"
Class {
	#name : 'BlDisplayPosition',
	#superclass : 'Object',
	#instVars : [
		'x',
		'y'
	],
	#category : 'Bloc-Display-Geometry',
	#package : 'Bloc-Display',
	#tag : 'Geometry'
}

{ #category : 'instance creation' }
BlDisplayPosition class >> fromPoint: aPoint [

	^ self x: aPoint x y: aPoint y
]

{ #category : 'instance creation' }
BlDisplayPosition class >> x: aX y: aY [

	^ self new
		  initializeX: aX Y: aY;
		  yourself
]

{ #category : 'api - arithmetic' }
BlDisplayPosition >> + aGtFensterPosition [

	^ self class
		x: self x + aGtFensterPosition x
		y: self y + aGtFensterPosition y
]

{ #category : 'api - arithmetic' }
BlDisplayPosition >> - aGtFensterPosition [

	^ self class
		x: self x - aGtFensterPosition x
		y: self y - aGtFensterPosition y
]

{ #category : 'comparing' }
BlDisplayPosition >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ x = anObject x and: [ y = anObject y ]
]

{ #category : 'api - converting' }
BlDisplayPosition >> asLogical: aScaleFactor [
	
	^ self subclassResponsibility
]

{ #category : 'api - converting' }
BlDisplayPosition >> asPhysical: aScaleFactor [
	
	^ self subclassResponsibility
]

{ #category : 'api - converting' }
BlDisplayPosition >> asPoint [

	^ self x @ self y
]

{ #category : 'comparing' }
BlDisplayPosition >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ y hash bitXor: x hash
]

{ #category : 'initialization' }
BlDisplayPosition >> initialize [

	super initialize.

	x := 0.
	y := 0
]

{ #category : 'initialization' }
BlDisplayPosition >> initializeX: aX Y: aY [

	x := aX.
	y := aY
]

{ #category : 'testing' }
BlDisplayPosition >> isZero [
	
	^ self x isZero or: [ self y isZero ]
]

{ #category : 'printing' }
BlDisplayPosition >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' { x: ';
		print: x;
		nextPutAll: ' y: ';
		print: y;
		nextPutAll: ' }'
]

{ #category : 'truncation and round off' }
BlDisplayPosition >> rounded [

	^ self class x: self x floor y: self y floor
]

{ #category : 'accessing' }
BlDisplayPosition >> x [

	^ x
]

{ #category : 'accessing' }
BlDisplayPosition >> y [

	^ y
]
