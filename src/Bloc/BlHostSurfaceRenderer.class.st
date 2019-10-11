Class {
	#name : #BlHostSurfaceRenderer,
	#superclass : #Object,
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #initialization }
BlHostSurfaceRenderer >> initializeForSurface: aSurface [
	self subclassResponsibility
]

{ #category : #initialization }
BlHostSurfaceRenderer >> render: aSpace onSurface: aSurface withPainter: aCanvasPainter [
]
