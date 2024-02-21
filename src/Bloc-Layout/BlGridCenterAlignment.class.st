Class {
	#name : #BlGridCenterAlignment,
	#superclass : #BlGridAlignment,
	#category : #'Bloc-Layout-Grid-Utilities'
}

{ #category : #alignment }
BlGridCenterAlignment >> alignmentValue: anElement viewSize: viewSize [
	^ viewSize / 2.0
]

{ #category : #alignment }
BlGridCenterAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	self flag: 'or multiply?'.
	^ cellDelta / 2.0
]
