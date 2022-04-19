Class {
	#name : #FensterSize,
	#superclass : #Object,
	#instVars : [
		'width',
		'height'
	],
	#category : #'Fenster-Geometry'
}

{ #category : #'instance creation' }
FensterSize class >> fromPoint: aPoint [
	^ self width: aPoint x height: aPoint y
]

{ #category : #'instance creation' }
FensterSize class >> width: aWidth height: aHeight [
	^ self new initializeWidth: aWidth height: aHeight
]

{ #category : #comparing }
FensterSize >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ height = anObject height and: [ width = anObject width ]
]

{ #category : #'api - converting' }
FensterSize >> asLogical: aScaleFactor [
	<return: #FensterLogicalSize>
	
	^ self subclassResponsibility
]

{ #category : #'api - converting' }
FensterSize >> asPhysical: aScaleFactor [
	<return: #FensterPhysicalSize>
	
	^ self subclassResponsibility
]

{ #category : #'api - converting' }
FensterSize >> asPoint [
	<return: #Point>

	^ self width @ self height
]

{ #category : #comparing }
FensterSize >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ height hash bitXor: width hash
]

{ #category : #accessing }
FensterSize >> height [
	<return: #Number>

	^ height
]

{ #category : #initialization }
FensterSize >> initialize [
	super initialize.
	
	width := 0.
	height := 0
]

{ #category : #initialization }
FensterSize >> initializeWidth: aWidth height: aHeight [
	width := aWidth.
	height := aHeight
]

{ #category : #testing }
FensterSize >> isZero [
	<return: #Boolean>
	
	^ self width isZero or: [ self height isZero ]
]

{ #category : #printing }
FensterSize >> printOn: aStream [
	aStream
		nextPutAll: self class name;
		nextPutAll: ' { width: ';
		print: self width;
		nextPutAll: ' height: ';
		print: self height;
		nextPutAll: ' }'
]

{ #category : #accessing }
FensterSize >> width [
	<return: #Number>

	^ width
]
