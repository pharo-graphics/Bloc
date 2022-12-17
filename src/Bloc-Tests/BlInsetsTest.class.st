Class {
	#name : #BlInsetsTest,
	#superclass : #TestCase,
	#category : 'Bloc-Tests-Basic-Support'
}

{ #category : #tests }
BlInsetsTest >> assertInset: anInsets [
	 
	self 
		assert: anInsets left 		equals: 2;
		assert: anInsets right 		equals: 4;
		assert: anInsets top 		equals: 1;
		assert: anInsets bottom 	equals: 3;
		assert: anInsets width 		equals: 6;
		assert: anInsets height 	equals: 4.
	
	
]

{ #category : #tests }
BlInsetsTest >> testConstruction [

	self assertInset: (BlInsets top: 1 right: 4 bottom: 3 left: 2).
	self assertInset: (BlInsets top: 1 left: 2 bottom: 3 right: 4).
]

{ #category : #tests }
BlInsetsTest >> testEmpty [

	| insets |
	insets := BlInsets empty.

	self 
		assert: insets left 		equals: 0;
		assert: insets right 		equals: 0;
		assert: insets top 		equals: 0;
		assert: insets bottom 	equals: 0;
		assert: insets width 		equals: 0;
		assert: insets height 	equals: 0.
	
	
]

{ #category : #tests }
BlInsetsTest >> testEqual [
	self
		assert:
			(BlInsets
				top: 1
				right: 4
				bottom: 3
				left: 2)
				=
					(BlInsets
						top: 1
						left: 2
						bottom: 3
						right: 4)
]

{ #category : #tests }
BlInsetsTest >> testExpand [
	| insets rectangle |
	insets := BlInsets all: 10.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets expand: rectangle) = (-10 @ -10 corner: 110 @ 110)
]

{ #category : #tests }
BlInsetsTest >> testExpandEmptyDoesNothing [
	| insets rectangle |
	insets := BlInsets empty.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets expand: rectangle) = rectangle.
	self assert: (insets expand: rectangle) == rectangle.
]

{ #category : #tests }
BlInsetsTest >> testInset [
	| insets rectangle |
	insets := BlInsets all: 10.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets inset: rectangle) = (10 @ 10 corner: 90 @ 90)
]

{ #category : #tests }
BlInsetsTest >> testInsetEmptyDoesNothing [
	| insets rectangle |
	insets := BlInsets empty.
	rectangle := 0 @ 0 corner: 100 @ 100.
	self assert: (insets inset: rectangle) = rectangle.
	self assert: (insets inset: rectangle) == rectangle
]

{ #category : #tests }
BlInsetsTest >> testIsEmpty [

	| insets |
	insets := BlInsets empty.
	self assert: insets isEmpty.
	self 
		assert: insets left 		equals: 0;
		assert: insets right 		equals: 0;
		assert: insets top 		equals: 0;
		assert: insets bottom 	equals: 0;
		assert: insets width 		equals: 0;
		assert: insets height 	equals: 0.
	
	
]

{ #category : #tests }
BlInsetsTest >> testSubstraction [

	| res |
	res := (BlInsets top: 1 right: 4 bottom: 3 left: 2) - 
			 (BlInsets top: 1 left: 2 bottom: 3 right: 4).
			
	self assert: res isEmpty
]

{ #category : #tests }
BlInsetsTest >> testSum [

	| res |
	res := (BlInsets top: 1 right: 4 bottom: 3 left: 2) + 
			 (BlInsets top: 1 left: 2 bottom: 3 right: 4).
			
	self assert: res top equals: 2.
	self assert: res left equals: 4.
	self assert: res bottom equals: 6.
	self assert: res right equals: 8.
]
