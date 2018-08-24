Class {
	#name : #BlGridFillAlignment,
	#superclass : #BlGridAlignment,
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #alignment }
BlGridFillAlignment >> alignmentValue: anElement viewSize: viewSize [
	^ UNDEFINED
]

{ #category : #alignment }
BlGridFillAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	^ 0
]

{ #category : #testing }
BlGridFillAlignment >> isFill [
	^ true
]

{ #category : #alignment }
BlGridFillAlignment >> sizeInCell: anElement viewSize: viewSize cellSize: cellSize [
	^ cellSize
]
