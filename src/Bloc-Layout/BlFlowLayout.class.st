Class {
	#name : #BlFlowLayout,
	#superclass : #BlLayout,
	#traits : 'TBlAlignable + TBlOrientableLayout',
	#classTraits : 'TBlAlignable classTrait + TBlOrientableLayout classTrait',
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

{ #category : #accessing }
BlFlowLayout >> alignment [
	^ self horizontalAlignment + self verticalAlignment
]

{ #category : #accessing }
BlFlowLayout >> beHorizontal [

	orientation := BlLayoutOrientation horizontal.
	measurer beHorizontal
]

{ #category : #accessing }
BlFlowLayout >> beVertical [

	orientation := BlLayoutOrientation vertical.
	measurer beVertical
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

	self beHorizontal
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
	measurer := self newMeasurer.
	self orientation: self defaultOrientation
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

{ #category : #initialization }
BlFlowLayout >> newMeasurer [

	^ BlFlowLayoutMeasurer for: self
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

	self beVertical
]

{ #category : #accessing }
BlFlowLayout >> verticalAlignment [
	^ verticalAlignment
]

{ #category : #accessing }
BlFlowLayout >> verticalAlignment: anAlignment [
	verticalAlignment := anAlignment
]
