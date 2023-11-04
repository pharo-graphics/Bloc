Class {
	#name : 'BlDisplaySize',
	#superclass : 'Object',
	#instVars : [
		'width',
		'height'
	],
	#category : 'Bloc-Display-Geometry',
	#package : 'Bloc-Display',
	#tag : 'Geometry'
}

{ #category : 'instance creation' }
BlDisplaySize class >> fromPoint: aPoint [

	^ self width: aPoint x height: aPoint y
]

{ #category : 'instance creation' }
BlDisplaySize class >> width: aWidth height: aHeight [

	^ self new
		  initializeWidth: aWidth height: aHeight;
		  yourself
]

{ #category : 'comparing' }
BlDisplaySize >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ height = anObject height and: [ width = anObject width ]
]

{ #category : 'api - converting' }
BlDisplaySize >> asLogical: aScaleFactor [
	
	^ self subclassResponsibility
]

{ #category : 'api - converting' }
BlDisplaySize >> asPhysical: aScaleFactor [
	
	^ self subclassResponsibility
]

{ #category : 'api - converting' }
BlDisplaySize >> asPoint [

	^ self width @ self height
]

{ #category : 'comparing' }
BlDisplaySize >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ height hash bitXor: width hash
]

{ #category : 'accessing' }
BlDisplaySize >> height [

	^ height
]

{ #category : 'initialization' }
BlDisplaySize >> initialize [

	super initialize.

	width := 0.
	height := 0
]

{ #category : 'initialization' }
BlDisplaySize >> initializeWidth: aWidth height: aHeight [

	width := aWidth.
	height := aHeight
]

{ #category : 'testing' }
BlDisplaySize >> isZero [
	
	^ self width isZero or: [ self height isZero ]
]

{ #category : 'printing' }
BlDisplaySize >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPutAll: ' { width: ';
		print: self width;
		nextPutAll: ' height: ';
		print: self height;
		nextPutAll: ' }'
]

{ #category : 'accessing' }
BlDisplaySize >> width [

	^ width
]
