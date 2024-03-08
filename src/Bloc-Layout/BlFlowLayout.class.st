Class {
	#name : #BlFlowLayout,
	#superclass : #BlLayout,
	#traits : 'TBlAlignable',
	#classTraits : 'TBlAlignable classTrait',
	#instVars : [
		'measurer',
		'orientation',
		'horizontalAlignment',
		'verticalAlignment'
	],
	#category : #'Bloc-Layout-Flow'
}

{ #category : #constraints }
BlFlowLayout class >> constraints [
	^ BlFlowLayoutConstraints new
]

{ #category : #factory }
BlFlowLayout class >> horizontal [
	^ self new
		horizontal;
		yourself
]

{ #category : #factory }
BlFlowLayout class >> vertical [
	^ self new
		vertical;
		yourself
]

{ #category : #comparing }
BlFlowLayout >> = anObject [

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	self orientation = anObject orientation ifFalse: [ ^ false ].
	self horizontalAlignment = anObject horizontalAlignment ifFalse: [ ^ false ].
	self verticalAlignment = anObject verticalAlignment ifFalse: [ ^ false ].
	^ true
]

{ #category : #accessing }
BlFlowLayout >> alignment [
	^ self horizontalAlignment + self verticalAlignment
]

{ #category : #initialization }
BlFlowLayout >> defaultHorizontalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment start horizontal
]

{ #category : #initialization }
BlFlowLayout >> defaultOrientation [
	^ BlLayoutOrientation horizontal
]

{ #category : #initialization }
BlFlowLayout >> defaultVerticalAlignment [
	"By default alignment should not influence on layout process,
	so to not deal with nils use null object"
	<return: #BlNullAlignment>
	
	^ BlElementAlignment start vertical
]

{ #category : #accessing }
BlFlowLayout >> horizontal [
	orientation := BlLayoutOrientation horizontal.
	measurer beHorizontal
]

{ #category : #accessing }
BlFlowLayout >> horizontalAlignment [
	^ horizontalAlignment
]

{ #category : #accessing }
BlFlowLayout >> horizontalAlignment: anAlignment [
	horizontalAlignment := anAlignment
]

{ #category : #initialization }
BlFlowLayout >> initialize [
	super initialize.
	
	verticalAlignment := self defaultVerticalAlignment.
	horizontalAlignment := self defaultHorizontalAlignment.
	measurer := BlFlowLayoutMeasurer for: self.
	self orientation: self defaultOrientation
]

{ #category : #testing }
BlFlowLayout >> isOrientable [

	^ true
]

{ #category : #layout }
BlFlowLayout >> layout: anElement in: newBounds context: aBlElementBoundsUpdateContext [
	measurer layout: anElement in: newBounds context: aBlElementBoundsUpdateContext.
	self layoutIgnored: anElement context: aBlElementBoundsUpdateContext
]

{ #category : #measure }
BlFlowLayout >> measure: anElement with: anExtentSpec [
	measurer measure: anElement with: anExtentSpec.
	self measureIgnored: anElement with: anExtentSpec
]

{ #category : #accessing }
BlFlowLayout >> orientation [
	^ orientation
]

{ #category : #accessing }
BlFlowLayout >> orientation: aLayoutOrientation [
	"Dispatches to self horizontal or vertical"
	aLayoutOrientation of: self
]

{ #category : #accessing }
BlFlowLayout >> vertical [
	orientation := BlLayoutOrientation vertical.
	measurer beVertical
]

{ #category : #accessing }
BlFlowLayout >> verticalAlignment [
	^ verticalAlignment
]

{ #category : #accessing }
BlFlowLayout >> verticalAlignment: anAlignment [
	verticalAlignment := anAlignment
]
