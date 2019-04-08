Class {
	#name : #BlTouchExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Event'
}

{ #category : #examples }
BlTouchExamples class >> multiTouchDemo [
	<script: 'self multiTouchDemo'>
	| container space |
	
	(Smalltalk hasClassNamed: #BlOSWindowHost)
		ifFalse: [ ^ self ].
	
	container := BlElement new.
	container background: Color veryVeryLightGray.
	container constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	container when: BlTouchDownEvent do: [ :anEvent |
		| aNewElement |

		aNewElement := BlElement new.
		aNewElement geometry: BlEllipse new.
		aNewElement size: 100@100.
		aNewElement relocate: anEvent localPosition - (50@50).
		aNewElement background: Color gray.

		anEvent currentTarget addChild: aNewElement ].

	container when: BlTouchUpEvent do: [ :anEvent |
		anEvent currentTarget removeChildAt: anEvent pointerIndex ].

	container when: BlTouchMoveEvent do: [ :anEvent |
		| anElement |
		
		anElement := anEvent currentTarget children at: anEvent pointerIndex.
		anElement relocate: anEvent localPosition - (anElement extent / 2.0) ].

	space := BlSpace new.
	space position: 100@100.
	space title: 'Touch Demo'.
	space host: #BlOSWindowHost asClass default.
	space root addChild: container.
	space show
]
