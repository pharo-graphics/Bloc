"
I bind class to its visual representation - a text element
"
Class {
	#name : #BlInfiniteExampleClassesElementHolder,
	#superclass : #BlInfiniteHolder,
	#instVars : [
		'class'
	],
	#category : 'Bloc-Examples-Infinite'
}

{ #category : #accessing }
BlInfiniteExampleClassesElementHolder >> class: aClass [
	| aText |

	class := aClass.
	aText := class name asRopedText.
	aText attributes: { BrFontSizeAttribute size: 13 }.
	itemElement text: aText
]

{ #category : #initialization }
BlInfiniteExampleClassesElementHolder >> initialize [
	super initialize.

	itemElement := BlTextElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 19.
			c padding: (BlInsets left: 15) ];
		yourself
]
