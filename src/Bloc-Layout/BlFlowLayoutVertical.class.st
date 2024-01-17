Class {
	#name : 'BlFlowLayoutVertical',
	#superclass : 'BlFlowLayoutOrientation',
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'measuring' }
BlFlowLayoutVertical >> breadthModeOf: aMeasurer [
	^ aMeasurer widthMode
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> breadthOf: aChild [
	^ aChild width
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> breadthOf: aChild set: aNumber [
	aChild width: aNumber
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> inlineX: aChild [
	^ aChild startBreadth
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> inlineY: aChild [
	^ aChild startLength
]

{ #category : 'testing' }
BlFlowLayoutVertical >> isVertical [
	^ true
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> lengthModeOf: aMeasurer [
	^ aMeasurer heightMode
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> lengthOf: aChild [
	^ aChild height
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> lengthOf: aChild set: aNumber [
	aChild height: aNumber
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> lineX: aLine [
	^ aLine startBreadth
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> lineY: aLine [
	^ aLine startLength
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> maxBreadthOf: aMeasurer [
	^ aMeasurer maxWidth
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> maxLengthOf: aMeasurer [
	^ aMeasurer maxHeight
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> spacingBreadthOf: aChild [
	^ aChild marginLeft + aChild marginRight
]

{ #category : 'measuring' }
BlFlowLayoutVertical >> spacingLengthOf: aChild [
	^ aChild marginTop + aChild marginBottom
]
