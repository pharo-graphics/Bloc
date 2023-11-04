Class {
	#name : #BlFlowLayoutOrientation,
	#superclass : #Object,
	#package : 'Bloc',
	#tag : 'Layout-Flow-Utilities'
}

{ #category : #measuring }
BlFlowLayoutOrientation >> breadthModeOf: aMeasurer [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> breadthOf: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> breadthOf: aChild set: aNumber [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> inlineX: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> inlineY: aChild [
	^ self subclassResponsibility
]

{ #category : #testing }
BlFlowLayoutOrientation >> isHorizontal [
	^ false
]

{ #category : #testing }
BlFlowLayoutOrientation >> isVertical [
	^ false
]

{ #category : #measuring }
BlFlowLayoutOrientation >> lengthModeOf: aMeasurer [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> lengthOf: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> lengthOf: aChild set: aNumber [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> lineX: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> lineY: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> maxBreadthOf: aMeasurer [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> maxLengthOf: aMeasurer [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> spacingBreadthOf: aChild [
	^ self subclassResponsibility
]

{ #category : #measuring }
BlFlowLayoutOrientation >> spacingLengthOf: aChild [
	^ self subclassResponsibility
]
