Class {
	#name : #BlGridLayoutConstraintsVertical,
	#superclass : #BlGridLayoutConstraintsAxis,
	#package : 'Bloc',
	#tag : 'Layout-Grid'
}

{ #category : #alignment }
BlGridLayoutConstraintsVertical >> alignBottom [
	self specAlignment: BlGridAlignment bottom
]

{ #category : #alignment }
BlGridLayoutConstraintsVertical >> alignCenter [
	self specAlignment: BlGridAlignment center
]

{ #category : #alignment }
BlGridLayoutConstraintsVertical >> alignTop [
	self specAlignment: BlGridAlignment top
]
