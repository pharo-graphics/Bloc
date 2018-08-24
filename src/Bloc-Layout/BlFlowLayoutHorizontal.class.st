Class {
	#name : #BlFlowLayoutHorizontal,
	#superclass : #BlFlowLayoutOrientation,
	#category : 'Bloc-Layout-Flow-Utilities'
}

{ #category : #measuring }
BlFlowLayoutHorizontal >> breadthModeOf: aMeasurer [
	^ aMeasurer heightMode
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> breadthOf: aChild [
	^ aChild height
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> breadthOf: aChild set: aNumber [
	aChild height: aNumber
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> inlineX: aChild [
	^ aChild startLength
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> inlineY: aChild [
	^ aChild startBreadth
]

{ #category : #testing }
BlFlowLayoutHorizontal >> isHorizontal [
	^ true
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> lengthModeOf: aMeasurer [
	^ aMeasurer widthMode
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> lengthOf: aChild [
	^ aChild width
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> lengthOf: aChild set: aNumber [
	aChild width: aNumber
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> lineX: aLine [
	^ aLine startLength
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> lineY: aLine [
	^ aLine startBreadth
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> maxBreadthOf: aMeasurer [
	^ aMeasurer maxHeight
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> maxLengthOf: aMeasurer [
	^ aMeasurer maxWidth
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> spacingBreadthOf: aChild [
	^ aChild marginTop + aChild marginBottom
]

{ #category : #measuring }
BlFlowLayoutHorizontal >> spacingLengthOf: aChild [
	^ aChild marginLeft + aChild marginRight
]
