Class {
	#name : 'BlGridTrailingAlignment',
	#superclass : 'BlGridAlignment',
	#category : 'Bloc-Layout-Grid-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Grid-Utilities'
}

{ #category : 'alignment' }
BlGridTrailingAlignment >> alignmentValue: anElement viewSize: viewSize [
	^ viewSize
]

{ #category : 'alignment' }
BlGridTrailingAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	^ cellDelta
]
