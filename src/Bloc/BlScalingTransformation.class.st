"
Specifies a scale operation by the (x,y,z) scaling vector.

For example, scale(1, 1) would leave an element unchanged, while scale(2, 2) would cause it to appear twice as long in both the X and Y axes, or four times its typical geometric size.

Corresponds to SVG scale() function
https://drafts.csswg.org/css-transforms/#valdef-transform-scale
"
Class {
	#name : #BlScalingTransformation,
	#superclass : #BlAffineTransformation,
	#instVars : [
		'scale'
	],
	#category : 'Bloc-Basic-Transformations'
}

{ #category : #'instance creation' }
BlScalingTransformation class >> scale: aVector [
	^ self new scale: aVector
]

{ #category : #initialization }
BlScalingTransformation >> initialize [
	super initialize.
	
	scale := BlVector one
]

{ #category : #testing }
BlScalingTransformation >> is2D [
	<return: #Boolean>

	^ self scale z closeTo: 1
]

{ #category : #'mathematical functions' }
BlScalingTransformation >> multiplyOn: aBlMatrix [
	aBlMatrix scaleBy: self scale
]

{ #category : #printing }
BlScalingTransformation >> printOn: aStream [
	aStream
		nextPutAll: 'Scaling by '.
		
	self scale printOn: aStream
]

{ #category : #accessing }
BlScalingTransformation >> scale [
	<return: #BlVector>

	^ scale
]

{ #category : #accessing }
BlScalingTransformation >> scale: aVector [
	scale := aVector asScale3D
]
