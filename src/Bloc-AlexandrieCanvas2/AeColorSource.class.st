Class {
	#name : 'AeColorSource',
	#superclass : 'Object',
	#instVars : [
		'r',
		'g',
		'b',
		'a'
	],
	#category : 'Bloc-AlexandrieCanvas2'
}

{ #category : 'hook' }
AeColorSource >> applyOn: cairoContext [

	cairoContext sourceColorR: r g: g b: b
]

{ #category : 'accessing' }
AeColorSource >> color: aColor [

	r := aColor red.
	g := aColor green.
	b := aColor blue.
	a := aColor alpha.
	a < 1.0 ifTrue: [ self error: 'not implemented yet' ].

]

{ #category : 'as yet unclassified' }
AeColorSource >> paintOn: cairoContext [ 

	self applyOn: cairoContext.
	cairoContext paint
]
