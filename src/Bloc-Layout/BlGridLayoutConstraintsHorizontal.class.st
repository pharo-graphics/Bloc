Class {
	#name : #BlGridLayoutConstraintsHorizontal,
	#superclass : #BlGridLayoutConstraintsAxis,
	#package : 'Bloc',
	#tag : 'Layout-Grid'
}

{ #category : #alignment }
BlGridLayoutConstraintsHorizontal >> alignCenter [
	self specAlignment: BlGridAlignment center
]

{ #category : #alignment }
BlGridLayoutConstraintsHorizontal >> alignLeft [
	self specAlignment: BlGridAlignment left
]

{ #category : #alignment }
BlGridLayoutConstraintsHorizontal >> alignRight [
	self specAlignment: BlGridAlignment right
]
