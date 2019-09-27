Class {
	#name : #BlRectangleWithArrow,
	#superclass : #BlGeometry,
	#instVars : [
		'direction',
		'cornerRadii',
		'arrowLength',
		'arrowBreadth'
	],
	#classVars : [
		'DOWN',
		'LEFT',
		'RIGHT',
		'UP'
	],
	#category : #'Bloc-Basic'
}

{ #category : #'class initialization' }
BlRectangleWithArrow class >> initialize [
	LEFT := #left.
	UP := #up.
	RIGHT := #right.
	DOWN := #down
]

{ #category : #initialization }
BlRectangleWithArrow >> initialize [
	super initialize.
	
	cornerRadii := BlCornerRadii empty.
	direction := DOWN.
	arrowLength := 5.
	arrowBreadth := 5
]

{ #category : #geometry }
BlRectangleWithArrow >> matchExtent: aPoint [
	extent := aPoint
]
