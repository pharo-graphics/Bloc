"
I exemplify ${class:BlVector2DDescriptionElement}$.
"
Class {
	#name : #BlVector2DDescriptionElementExamples,
	#superclass : #Object,
	#category : #'Bloc-Extensions-Vector'
}

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> basicVectorDescriptionElement [
	<gtExample>
	| anElement |
	anElement := BlVector2DDescriptionElement new.
	self assert: anElement vector isNil.
	^ anElement
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector0degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 100 y: 0.
	self assert: aVector degrees equals: 0.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector135degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: -100 y: 100.
	self assert: aVector degrees equals: 135.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector180degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: -100 y: 0.
	self assert: aVector degrees equals: 180.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector225degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: -100 y: -100.
	self assert: aVector degrees equals: 225.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector270degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 0 y: -100.
	self assert: aVector degrees equals: 270.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector315degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 100 y: -100.
	self assert: aVector degrees equals: 315.
	^ aVector 
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector45degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 100 y: 100.
	self assert: aVector degrees equals: 45.
	^ aVector
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vector90degrees [
	<gtExample>
	| aVector |
	aVector := BlVector x: 0 y: 100.
	self assert: aVector degrees equals: 90.
	^ aVector
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_0degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector0degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_135degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector135degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_180degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector180degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_225degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector225degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_270degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector270degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_315degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector315degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_45degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector45degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_90degrees [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vector90degrees.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - element' }
BlVector2DDescriptionElementExamples >> vectorDescriptionElement_ZeroLength [
	<gtExample>
	| anElement aVector |
	anElement := self basicVectorDescriptionElement.
	aVector := self vectorZeroLength.
	anElement vector: aVector.
	^ anElement
]

{ #category : #'examples - vector' }
BlVector2DDescriptionElementExamples >> vectorZeroLength [
	<gtExample>
	| aVector |
	aVector := BlVector x: 0 y: 0.
	self assert: aVector length equals: 0.
	^ aVector
]
