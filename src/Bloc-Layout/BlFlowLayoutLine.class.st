Class {
	#name : 'BlFlowLayoutLine',
	#superclass : 'Object',
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'children',
		'startLength',
		'startBreadth',
		'length',
		'breadth',
		'measurer',
		'index'
	],
	#category : 'Bloc-Layout-Flow-Utilities',
	#package : 'Bloc-Layout',
	#tag : 'Flow-Utilities'
}

{ #category : 'instance creation' }
BlFlowLayoutLine class >> for: aMeasurer [
	^ self new
		measurer: aMeasurer;
		yourself
]

{ #category : 'adding' }
BlFlowLayoutLine >> addFloatFirst: aChild [
	self
		assert: [ aChild isFloating ]
		description: [ 'I can only be used to add floating children!' ].

	children addFirst: aChild.
	
	length := length + aChild length + aChild spacingLength
]

{ #category : 'adding' }
BlFlowLayoutLine >> addFloatLast: aChild [
	self
		assert: [ aChild isFloating ]
		description: [ 'I can only be used to add floating children!' ].

	children addLast: aChild.
	
	length := length + aChild length + aChild spacingLength
]

{ #category : 'adding' }
BlFlowLayoutLine >> addInlineFirst: aChild [
	self
		assert: [ aChild isInline ]
		description: [ 'I can only be used to add inlined children!' ].

	children addFirst: aChild.
	
	length := length + aChild length + aChild spacingLength.
	breadth := breadth max: aChild breadth + aChild spacingBreadth
]

{ #category : 'adding' }
BlFlowLayoutLine >> addInlineLast: aChild [
	self
		assert: [ aChild isInline ]
		description: [ 'I can only be used to add inlined children!' ].

	children addLast: aChild.
	
	length := length + aChild length + aChild spacingLength.
	breadth := breadth max: aChild breadth + aChild spacingBreadth
]

{ #category : 'adding' }
BlFlowLayoutLine >> addTo: theLines [
	"I dispatch to concreate addFirst/addLast based on layout configuration"
	(self orientation isVertical and: [ self direction isRightToLeft ])
		ifTrue: [ theLines addFirst: self ]
		ifFalse: [ theLines addLast: self ].
	index := theLines size
]

{ #category : 'geometry' }
BlFlowLayoutLine >> breadth [
	^ breadth
]

{ #category : 'geometry' }
BlFlowLayoutLine >> breadth: aNumber [
	breadth := aNumber
]

{ #category : 'testing' }
BlFlowLayoutLine >> canFit: aChild [
	^ self length + aChild length + aChild spacingLength <= measurer maxLength
]

{ #category : 'accessing' }
BlFlowLayoutLine >> children [
	^ children
]

{ #category : 'accessing' }
BlFlowLayoutLine >> direction [
	^ measurer direction
]

{ #category : 'accessing' }
BlFlowLayoutLine >> index [
	^ index
]

{ #category : 'accessing' }
BlFlowLayoutLine >> index: anIndex [
	index := anIndex
]

{ #category : 'initialization' }
BlFlowLayoutLine >> initialize [
	super initialize.
	
	children := OrderedCollection new.
	startBreadth := 0.
	startLength := 0.
	length := 0.
	breadth := 0.
	
	"initialized by layoutSpec:"
	measurer := nil
]

{ #category : 'testing' }
BlFlowLayoutLine >> isEmpty [
	^ children isEmpty
]

{ #category : 'geometry' }
BlFlowLayoutLine >> length [
	^ length
]

{ #category : 'geometry' }
BlFlowLayoutLine >> length: aNumber [
	length := aNumber
]

{ #category : 'geometry' }
BlFlowLayoutLine >> lineX [
	^ self orientation lineX: self
]

{ #category : 'geometry' }
BlFlowLayoutLine >> lineY [
	^ self orientation lineY: self
]

{ #category : 'initialization' }
BlFlowLayoutLine >> measurer: aMeasurer [
	measurer := aMeasurer
]

{ #category : 'accessing' }
BlFlowLayoutLine >> orientation [
	^ measurer orientation
]

{ #category : 'accessing' }
BlFlowLayoutLine >> startBreadth [
	^ startBreadth
]

{ #category : 'accessing' }
BlFlowLayoutLine >> startBreadth: aNumber [
	startBreadth := aNumber
]

{ #category : 'accessing' }
BlFlowLayoutLine >> startLength [
	^ startLength
]

{ #category : 'accessing' }
BlFlowLayoutLine >> startLength: aNumber [
	startLength := aNumber
]
