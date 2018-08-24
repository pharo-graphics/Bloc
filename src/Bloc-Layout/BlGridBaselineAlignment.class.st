Class {
	#name : #BlGridBaselineAlignment,
	#superclass : #BlGridAlignment,
	#category : 'Bloc-Layout-Grid-Utilities'
}

{ #category : #alignment }
BlGridBaselineAlignment >> alignmentValue: anElement viewSize: viewSize [
	^ UNDEFINED
]

{ #category : #accessing }
BlGridBaselineAlignment >> bounds [
	^ BlGridLayoutBaselineBounds new
]

{ #category : #alignment }
BlGridBaselineAlignment >> gravityOffset: anElement cellDelta: cellDelta [
	^ 0
]
