Class {
	#name : #BlGridLayoutConstraintsVertical,
	#superclass : #BlGridLayoutConstraintsAxis,
	#category : 'Bloc-Layout-Grid'
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
