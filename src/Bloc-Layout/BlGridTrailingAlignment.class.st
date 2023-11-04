Class {
	#name : #BlGridTrailingAlignment,
	#superclass : #BlGridAlignment,
	#package : 'Bloc',
	#tag : 'Layout-Grid-Utilities'
}

{ #category : #alignment }
BlGridTrailingAlignment >> alignmentValue: anElement viewSize: viewSize [
	^ viewSize
]

{ #category : #alignment }
BlGridTrailingAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	^ cellDelta
]
