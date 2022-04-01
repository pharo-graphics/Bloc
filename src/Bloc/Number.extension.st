Extension { #name : #Number }

{ #category : #'*Bloc' }
Number >> asBlocVector [
	"Return a 2D vector of the receiver by using the receiver as the two dimensions."
	
	^ BlVector x: self y: self
]

{ #category : #'*Bloc' }
Number >> asScale3D [
	"Return a 3D vector representing a scale factor"
	<return: #BlVector3D>

	^ BlVector x: self y: self z: 1
]

{ #category : #'*Bloc' }
Number >> asTranslate3D [
	"Return a 3D vector representing a translation vector"
	<return: #BlVector3D>

	^ BlVector x: self y: self z: 0
]

{ #category : #'*Bloc' }
Number >> closeTo: num epsilon: anEpsilon [
	"are these two numbers close?"

	^ (self - num) abs <= anEpsilon
]

{ #category : #'*Bloc' }
Number >> isBlocFinite [
	^ self isInfinite not and: [ self isNaN not ]
]

{ #category : #'*Bloc' }
Number >> isBlocFiniteFloat [
	^ self isFloat and: [ self isInfinite not and: [ self isNaN not ] ]
]

{ #category : #'*Bloc' }
Number >> isBlocPositive [
	^ self >= 0.0
]

{ #category : #'*Bloc' }
Number >> isBlocPositiveFloat [
	^ self isFloat and: [ self >= 0.0 ]
]

{ #category : #'*Bloc' }
Number >> scalarMultiplicate2D: aVector2D [
	"Perform a scalar multiplication of a given 2D vector by me"
	<return: #BlVector>

	^ BlVector
		x: aVector2D x * self
		y: aVector2D y * self
]

{ #category : #'*Bloc' }
Number >> scalarMultiplicate3D: aVector3D [
	"Return a new vector by performing a scalar multiplication of a given 3D vector by me."
	<return: #BlVector>

	^ BlVector
		x: aVector3D x * self
		y: aVector3D y * self
		z: aVector3D z * self
]

{ #category : #'*Bloc' }
Number >> timesCollect: aBlock [
	^ (1 to: self) collect: [ :anIndex | aBlock cull: anIndex ]
]
