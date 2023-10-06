"
I represent an abstract shadow effect applied on an element.

"
Class {
	#name : #BlShadowEffect,
	#superclass : #BlElementEffect,
	#instVars : [
		'color',
		'offset',
		'isInset'
	],
	#category : #'Bloc-Effect'
}

{ #category : #accessing }
BlShadowEffect >> beInset [
	
	isInset := true
]

{ #category : #accessing }
BlShadowEffect >> beOutset [
	
	isInset := false
]

{ #category : #accessing }
BlShadowEffect >> color [

	^ color
]

{ #category : #geometry }
BlShadowEffect >> computeBounds: aBlBounds [

	^ aBlBounds expandByMargin: self shadowMargin
]

{ #category : #geometry }
BlShadowEffect >> extraShadowSpace [

	^ self subclassResponsibility
]

{ #category : #initialization }
BlShadowEffect >> initialize [

	super initialize.
	
	isInset := false
]

{ #category : #accessing }
BlShadowEffect >> isInset: aBoolean [
	
	^ isInset
]

{ #category : #accessing }
BlShadowEffect >> offset [

	^ offset
]

{ #category : #geometry }
BlShadowEffect >> shadowMargin [

	| anExtraSpace |
	anExtraSpace := self extraShadowSpace.

	^ BlInsets
		top: ((anExtraSpace - self offset y) max: 0)
		right: ((anExtraSpace + self offset x) max: 0)
		bottom: ((anExtraSpace + self offset y) max: 0)
		left: ((anExtraSpace - self offset x) max: 0)
]
