Class {
	#name : #BlSideBackgroundDecoration,
	#superclass : #BlInfinteSideDecoration,
	#instVars : [
		'background',
		'actualWidth'
	],
	#category : #'Bloc-Infinite-Core'
}

{ #category : #accessing }
BlSideBackgroundDecoration >> actualWidth [ 

	^ actualWidth 
]

{ #category : #accessing }
BlSideBackgroundDecoration >> aeBackgroundBoundsOn: aeCanvas in: anInfiniteElement [

	^ self computedBounds
]

{ #category : #accessing }
BlSideBackgroundDecoration >> background [

	^ background ifNil: [background := self defaultBackground ]
]

{ #category : #accessing }
BlSideBackgroundDecoration >> background: aBackground [

	background := aBackground
]

{ #category : #initialization }
BlSideBackgroundDecoration >> defaultBackground [

	^ (Color veryLightGray alpha: 0.10) asBlBackground
]

{ #category : #initialization }
BlSideBackgroundDecoration >> defaultWidth [

	^ 0
]

{ #category : #initialization }
BlSideBackgroundDecoration >> initialize [
	super initialize.
	actualWidth := self defaultWidth.
	"highest priority"
	priority := 0
]

{ #category : #geometry }
BlSideBackgroundDecoration >> requiredInsetsOfChildElement: anElement in: anInfiniteElement [

	self flag: 'To be finished. this current implementation only work for the left side'.
	^ BlInsets left: self requiredWidth + anInfiniteElement margin left
]

{ #category : #geometry }
BlSideBackgroundDecoration >> requiredWidth [

	^ self actualWidth  
]
