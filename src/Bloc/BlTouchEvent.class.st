Class {
	#name : 'BlTouchEvent',
	#superclass : 'BlUIEvent',
	#instVars : [
		'pointerId',
		'pointerIndex',
		'delta',
		'pressure'
	],
	#category : 'Bloc-Events'
}

{ #category : 'accessing' }
BlTouchEvent >> delta [
	"Return the distance moved in both x- and y-axis, given in space coordinates"
	<return: #Point>

	^ delta
]

{ #category : 'accessing' }
BlTouchEvent >> delta: aPoint [
	delta := aPoint
]

{ #category : 'testing' }
BlTouchEvent >> isTouch [
	^ true
]

{ #category : 'accessing' }
BlTouchEvent >> pointerId [
	"Return the unique id of a finger"
	<return: #Number>

	^ pointerId
]

{ #category : 'accessing' }
BlTouchEvent >> pointerId: aNumber [
	pointerId := aNumber
]

{ #category : 'accessing' }
BlTouchEvent >> pointerIndex [
	"Return the ordered index of a pointer. Assume user touches the display
	with two fingers, the first finger put on a display receives index '1'
	while the second finger index '2'. Index is different from an id in which id tends to be unique"
	<return: #Number>

	^ pointerIndex
]

{ #category : 'accessing' }
BlTouchEvent >> pointerIndex: aNumber [
	pointerIndex := aNumber
]

{ #category : 'accessing' }
BlTouchEvent >> pressure [
	"Return the quantity of pressure applied, normalized (0...1)"
	<return: #Number>

	^ pressure
]

{ #category : 'accessing' }
BlTouchEvent >> pressure: aNumber [
	pressure := aNumber
]
