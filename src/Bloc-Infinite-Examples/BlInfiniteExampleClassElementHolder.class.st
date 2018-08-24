Class {
	#name : #BlInfiniteExampleClassElementHolder,
	#superclass : #BlInfiniteElementHolder,
	#instVars : [
		'class'
	],
	#category : 'Bloc-Infinite-Examples-Core - Classes'
}

{ #category : #accessing }
BlInfiniteExampleClassElementHolder >> class: aClass [
	| aText |
	class == aClass
		ifTrue: [ ^ self ].

	class := aClass.
	
	aText := BrRopedText string: class name.
	aText attributes: { BrFontSizeAttribute size: 13 }.
	itemElement text: aText
]

{ #category : #initialization }
BlInfiniteExampleClassElementHolder >> initialize [
	super initialize.

	itemElement := BlTextElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 19.
			c padding: (BlInsets left: 15) ];
		yourself
]
