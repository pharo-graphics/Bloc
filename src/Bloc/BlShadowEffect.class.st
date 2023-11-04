"
I represent an abstract shadow effect applied on an element.

"
Class {
	#name : #BlShadowEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'color',
		'offset'
	],
	#category : 'Bloc-Effect'
}

{ #category : 'accessing' }
BlShadowEffect >> color [

	^ color
]

{ #category : 'geometry' }
BlShadowEffect >> computeBounds: aBlBounds [

	^ aBlBounds expandByMargin: self shadowMargin
]

{ #category : 'geometry' }
BlShadowEffect >> extraShadowSpace [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
BlShadowEffect >> offset [

	^ offset
]

{ #category : 'geometry' }
BlShadowEffect >> shadowMargin [

	| anExtraSpace |
	anExtraSpace := self extraShadowSpace.

	^ BlInsets
		top: ((anExtraSpace - self offset y) max: 0)
		right: ((anExtraSpace + self offset x) max: 0)
		bottom: ((anExtraSpace + self offset y) max: 0)
		left: ((anExtraSpace - self offset x) max: 0)
]
