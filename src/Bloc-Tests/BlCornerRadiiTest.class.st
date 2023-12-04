Class {
	#name : 'BlCornerRadiiTest',
	#superclass : 'TestCase',
	#category : 'Bloc-Tests-Basic-Support',
	#package : 'Bloc-Tests',
	#tag : 'Basic-Support'
}

{ #category : 'tests' }
BlCornerRadiiTest >> testBottomLeft [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii bottomLeft: 10.
	self assert: cornerRadii bottomLeft equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii bottomLeft equals: 5
]

{ #category : 'tests' }
BlCornerRadiiTest >> testBottomRight [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii bottomRight: 10.
	self assert: cornerRadii bottomRight equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii bottomRight equals: 5
]

{ #category : 'tests' }
BlCornerRadiiTest >> testEmpty [
	| cornerRadii |
	
	BlCornerRadii cleanUp.
	cornerRadii := BlCornerRadii empty.
	
	self assert: cornerRadii bottomLeft equals: 0.
	self assert: cornerRadii bottomRight equals: 0.
	self assert: cornerRadii topLeft equals: 0.
	self assert: cornerRadii topRight equals: 0
]

{ #category : 'tests' }
BlCornerRadiiTest >> testMax [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii
		bottomLeft: 5;
		bottomRight: 10;
		topLeft: 15;
		topRight: 20.
	self assert: cornerRadii max equals: 20.
	
	cornerRadii := BlCornerRadii radius: 20.
	self assert: cornerRadii max equals: 20.
]

{ #category : 'tests' }
BlCornerRadiiTest >> testMin [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii
		bottomLeft: 5;
		bottomRight: 10;
		topLeft: 15;
		topRight: 20.
	self assert: cornerRadii min equals: 5.
	
	cornerRadii := BlCornerRadii radius: 20.
	self assert: cornerRadii min equals: 20.
]

{ #category : 'tests' }
BlCornerRadiiTest >> testRadius [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii radius: 10.
	
	self assert: cornerRadii bottomLeft equals: 10.
	self assert: cornerRadii bottomRight equals: 10.
	self assert: cornerRadii topLeft equals: 10.
	self assert: cornerRadii topRight equals: 10.
]

{ #category : 'tests' }
BlCornerRadiiTest >> testTopLeft [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii topLeft: 10.
	self assert: cornerRadii topLeft equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii topLeft equals: 5
]

{ #category : 'tests' }
BlCornerRadiiTest >> testTopRight [
	| cornerRadii |
	
	cornerRadii := BlCornerRadii new.
	cornerRadii topRight: 10.
	self assert: cornerRadii topRight equals: 10.

	cornerRadii := BlCornerRadii radius: 5.
	self assert: cornerRadii topRight equals: 5
]
