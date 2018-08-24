"
I am a single red chicken leg with two toes
"
Class {
	#name : #BlChickenLeg,
	#superclass : #BlElement,
	#category : 'Bloc-Examples-Showcase-Chicken'
}

{ #category : #examples }
BlChickenLeg class >> pairOfLegs [
	<gtExample>

	^ BlElement new
		layout: BlLinearLayout horizontal;
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { 
			self singleLeg margin: (BlInsets right: 5).
			self singleLeg margin: (BlInsets left: 5) }
]

{ #category : #examples }
BlChickenLeg class >> singleLeg [
	<gtExample>

	^ self new size: 50 @ 100
]

{ #category : #drawing }
BlChickenLeg >> drawOnSpartaCanvas: aCanvas [
	| aLegPath |
	super drawOnSpartaCanvas: aCanvas.

	aLegPath := aCanvas path
		relative;
		moveTo: (self width / 2) asFloat @ 0;
		lineTo: 0 @ (self height * 2 / 3) asFloat;
		lineTo: self width / 2 * 1.25 negated asFloat @ (self height / 3) asFloat;
		moveTo: (self width / 2 * 1.25 negated asFloat  @ (self height / 3) asFloat) negated;
		lineTo: (self width / 2 * 1.25) asFloat  @ (self height / 3) asFloat ;
		finish.
		
	aCanvas stroke
		path: aLegPath;
		paint: Color red;
		width: 2;
		draw
]
