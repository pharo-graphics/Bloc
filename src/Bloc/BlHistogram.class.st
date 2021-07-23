"
# Histogram

I represent a class of historgram-like geometry.
{{gtExample:BlHistogramExamples>>#default|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

See {{gtClass:BlHistogramExamples}} for more examples

"
Class {
	#name : 'BlHistogram',
	#superclass : 'BlElementVectorGeometry',
	#instVars : [
		'values',
		'orientation'
	],
	#classVars : [
		'BottomToTop',
		'LeftToRight',
		'RightToLeft',
		'TopToBottom'
	],
	#category : 'Bloc-Basic'
}

{ #category : 'class initialization' }
BlHistogram class >> initialize [
	LeftToRight := #leftToRight.
	RightToLeft := #rightToLeft.
	BottomToTop := #bottomToTop.
	TopToBottom := #topToBottom
]

{ #category : 'accessing' }
BlHistogram >> beBottomToTop [
	orientation := BottomToTop.
	self releaseCache
]

{ #category : 'accessing' }
BlHistogram >> beLeftToRight [
	orientation := LeftToRight.
	self releaseCache
]

{ #category : 'accessing' }
BlHistogram >> beRightToLeft [
	orientation := RightToLeft.
	self releaseCache
]

{ #category : 'accessing' }
BlHistogram >> beTopToBottom [
	orientation := TopToBottom.
	self releaseCache
]

{ #category : 'private - geometry' }
BlHistogram >> computeDelta [
	(self isLeftToRight or: [ self isRightToLeft ])
		ifTrue: [ ^ 0 @ (self extent y / self values size) asFloat ].
	(self isTopToBottom or: [ self isBottomToTop ])
		ifTrue: [ ^ (self extent x / self values size) asFloat @ 0 ].

	^ 0@0
]

{ #category : 'private - geometry' }
BlHistogram >> computeLengthVector [
	self isLeftToRight
		ifTrue: [ ^ 1@0 ].
	self isRightToLeft
		ifTrue: [ ^ -1@0 ].
	self isTopToBottom
		ifTrue: [ ^ 0@1 ].
	self isBottomToTop
		ifTrue: [ ^ 0@(-1) ].

	^ 0@0
]

{ #category : 'private - geometry' }
BlHistogram >> computeOrigin [
	self isLeftToRight
		ifTrue: [ ^ 0@0 ].
	self isRightToLeft
		ifTrue: [ ^ self extent x @ 0 ].
	self isTopToBottom
		ifTrue: [ ^ 0@0 ].
	self isBottomToTop
		ifTrue: [ ^ 0 @ self extent y ].

	^ 0@0
]

{ #category : 'initialization' }
BlHistogram >> initialize [
	super initialize.
	
	values := #(0.2 0.4 0.6 0.8 1.0 0.9 0.7 0.5 0.3 0.1).
	orientation := BottomToTop
]

{ #category : 'private - geometry' }
BlHistogram >> isBottomToTop [
	^ orientation = BottomToTop
]

{ #category : 'private - geometry' }
BlHistogram >> isLeftToRight [
	^ orientation = LeftToRight
]

{ #category : 'private - geometry' }
BlHistogram >> isRightToLeft [
	^ orientation = RightToLeft
]

{ #category : 'private - geometry' }
BlHistogram >> isTopToBottom [
	^ orientation = TopToBottom
]

{ #category : 'geometry' }
BlHistogram >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : 'accessing' }
BlHistogram >> values [
	^ values
]

{ #category : 'accessing' }
BlHistogram >> values: aCollectionOfFloats [
	values := aCollectionOfFloats.
	self releaseCache
]
