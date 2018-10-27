Class {
	#name : #BlLinearLayoutNode,
	#superclass : #Object,
	#instVars : [
		'element',
		'orientation',
		'linearConstraints'
	],
	#category : #'Bloc-Layout-Linear-Utilities'
}

{ #category : #'accessing - constraints' }
BlLinearLayoutNode >> breadthConstraints [
	^ self orientation breadthProperties: self element
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> breadthResizer [
	^ self breadthConstraints resizer
]

{ #category : #accessing }
BlLinearLayoutNode >> constraints [
	^ self element constraints
]

{ #category : #accessing }
BlLinearLayoutNode >> element [
	<return: #BlElement>

	^ element
]

{ #category : #testing }
BlLinearLayoutNode >> hasSpaceAfter [
	"Return true if there should be a divider after this node"
	<return: #Boolean>

	^ true
]

{ #category : #testing }
BlLinearLayoutNode >> hasSpaceBefore [
	"Return true if there should be a divider before this node"
	<return: #Boolean>

	^ true
]

{ #category : #initialization }
BlLinearLayoutNode >> initializeWith: anElement orientation: aBlLinearLayoutOrientation [
	element := anElement.
	orientation := aBlLinearLayoutOrientation
]

{ #category : #'accessing - constraints' }
BlLinearLayoutNode >> lengthConstraints [
	^ self orientation lengthProperties: self element
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> lengthResizer [
	^ self lengthConstraints resizer
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> lengthResizer: aResizer [
	self lengthConstraints resizer: aResizer
]

{ #category : #accessing }
BlLinearLayoutNode >> linearConstraints [
	<return: #BlLinearLayoutConstraints>

	^ linearConstraints
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> marginBreadth [
	<return: #Number>

	^ self orientation marginBreadth: self element
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> marginLength [
	<return: #Number>

	^ self orientation marginLength: self element
]

{ #category : #measure }
BlLinearLayoutNode >> measure: anExtentSpec [
	self element measure: anExtentSpec
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> measuredBreadth [
	^ self orientation measuredBreadth: self element
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> measuredLength [
	^ self orientation measuredLength: self element
]

{ #category : #accessing }
BlLinearLayoutNode >> orientation [
	<return: #BlLinearLayoutOrientation>

	^ orientation
]

{ #category : #testing }
BlLinearLayoutNode >> shouldUseExcessSpace [
	<return: #Boolean>

	^ self weight > 0
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> verticalAlignment [
	^ self linearConstraints vertical alignment
]

{ #category : #'accessing - properties' }
BlLinearLayoutNode >> weight [
	"Weight is only applicable if a child matches parent"
	<return: #Number>

	^ self lengthResizer isMatchParent
		ifTrue: [ self linearConstraints weight ]
		ifFalse: [ 0 ]
]
