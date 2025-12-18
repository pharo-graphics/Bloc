"
I'm a state in a `BlScrollFlinger`.
"
Class {
	#name : #BlScrollFlingerState,
	#superclass : #Object,
	#instVars : [
		'x',
		'y',
		'dX',
		'dY',
		'hResult',
		'vResult',
		'overscrollX',
		'overscrollY'
	],
	#category : #'Bloc-Infinite-Scrollable-Helpers'
}

{ #category : #accessing }
BlScrollFlingerState >> dX [
	^ dX
]

{ #category : #accessing }
BlScrollFlingerState >> dX: anObject [
	dX := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> dY [
	^ dY
]

{ #category : #accessing }
BlScrollFlingerState >> dY: anObject [
	dY := anObject
]

{ #category : #testing }
BlScrollFlingerState >> didScroll [
	^ hResult isZero not or: [ vResult isZero not ]
]

{ #category : #accessing }
BlScrollFlingerState >> hResult [
	^ hResult
]

{ #category : #accessing }
BlScrollFlingerState >> hResult: anObject [
	hResult := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> overscrollX [
	^ overscrollX
]

{ #category : #accessing }
BlScrollFlingerState >> overscrollX: anObject [
	overscrollX := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> overscrollY [
	^ overscrollY
]

{ #category : #accessing }
BlScrollFlingerState >> overscrollY: anObject [
	overscrollY := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> vResult [
	^ vResult
]

{ #category : #accessing }
BlScrollFlingerState >> vResult: anObject [
	vResult := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> x [
	^ x
]

{ #category : #accessing }
BlScrollFlingerState >> x: anObject [
	x := anObject
]

{ #category : #accessing }
BlScrollFlingerState >> y [
	^ y
]

{ #category : #accessing }
BlScrollFlingerState >> y: anObject [
	y := anObject
]
