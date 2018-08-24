"
I am dynamic element transformation in the sense that my transformation matrix may actually depend on some element properties such as #extent or #position.

It means that matrix computation is performed only when requested taking owner element into account.
This also means that the matrix dimension (2D or 3D) should be determined dynamically based on inner transformations
"
Class {
	#name : #BlElementDynamicTransformation,
	#superclass : #BlElementTransformation,
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #computation }
BlElementDynamicTransformation >> computeMatrix [
	"I perform a matrix computation assuming that matrix is initialized with
	a correct type (2D or 3D) and that it is identity"

	self subclassResponsibility
]

{ #category : #initialization }
BlElementDynamicTransformation >> defaultMatrix2D [
	^ BlMatrix2D new
]

{ #category : #initialization }
BlElementDynamicTransformation >> defaultMatrix3D [
	^ BlMatrix3D new
]

{ #category : #private }
BlElementDynamicTransformation >> ensure2D [
	matrix := self defaultMatrix2D
]

{ #category : #private }
BlElementDynamicTransformation >> ensure3D [
	matrix := self defaultMatrix3D
]

{ #category : #private }
BlElementDynamicTransformation >> ensureMatrix [
	self hasMatrix
		ifTrue: [ ^ self ].
	self is2D
		ifTrue: [ self ensure2D ]
		ifFalse: [ self ensure3D ].
	self computeMatrix
]

{ #category : #private }
BlElementDynamicTransformation >> hasMatrix [
	"Return true if any of 2D or 3D matrices exist, false otherwise.
	Note: I am useful for fast exits"
	<return: #Boolean>
	
	^ matrix isNotNil 
]

{ #category : #accessing }
BlElementDynamicTransformation >> matrix [
	<return: #BlMatrix>

	self ensureMatrix.
	^ matrix
]
