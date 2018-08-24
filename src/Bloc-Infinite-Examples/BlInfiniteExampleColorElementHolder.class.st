Class {
	#name : #BlInfiniteExampleColorElementHolder,
	#superclass : #BlInfiniteElementHolder,
	#instVars : [
		'color'
	],
	#category : 'Bloc-Infinite-Examples-Core - Colors'
}

{ #category : #accessing }
BlInfiniteExampleColorElementHolder >> color [
	^ color
]

{ #category : #accessing }
BlInfiniteExampleColorElementHolder >> color: aColor [

	color = aColor
		ifTrue: [ ^ self ].

	color := aColor.
	
	"color changed, update element to represent new color"
	itemElement background: color
]

{ #category : #initialization }
BlInfiniteExampleColorElementHolder >> initialize [
	super initialize.

	itemElement := BlElement new
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: 40.
			c margin: (BlInsets bottom: 3) ];
		addEventHandlerOn: BlClickEvent do: [ :e |
			| aPosition |
			aPosition := e target constraints infinite holder dataSourcePosition.
			infiniteElement dataSource removeColorAt: aPosition ];
		yourself
]
