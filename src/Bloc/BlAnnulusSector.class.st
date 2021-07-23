"
# Annulus sector
I am a sector of an annulus. In mathematics, an annulus (the Latin word for ""little ring"" is anulus / annulus, with plural anuli / annuli) is a ring-shaped object, a region bounded by two concentric circles.
<https://en.wikipedia.org/wiki/Annulus_(mathematics)>

{{gtExample:BlAnnulusSectorExamples>>#default|codeExpanded=false|previewShow=#gtLiveFor:|previewExpanded=true|previewHeight=100}}

See {{gtClass:BlAnnulusSectorExamples}} to learn more

"
Class {
	#name : 'BlAnnulusSector',
	#superclass : 'BlElementVectorGeometry',
	#instVars : [
		'startAngle',
		'endAngle',
		'innerRadius',
		'outerRadius'
	],
	#category : 'Bloc-Basic'
}

{ #category : 'private - geometry' }
BlAnnulusSector >> absoluteInnerRadius [
	<return: #Number>
	
	^ self radius * innerRadius
]

{ #category : 'private - geometry' }
BlAnnulusSector >> absoluteOuterRadius [
	<return: #Number>
	
	^ self radius * outerRadius
]

{ #category : 'private - geometry' }
BlAnnulusSector >> center [
	<return: #Point>
	
	^ self extent / 2.0
]

{ #category : 'accessing' }
BlAnnulusSector >> endAngle [
	^ endAngle
]

{ #category : 'accessing' }
BlAnnulusSector >> endAngle: anAngleInDegrees [
	endAngle := anAngleInDegrees.
	self releaseCache
]

{ #category : 'initialization' }
BlAnnulusSector >> initialize [
	super initialize.
	
	startAngle := 0.
	endAngle := 270.
	innerRadius := 0.45.
	outerRadius := 1.0
]

{ #category : 'accessing' }
BlAnnulusSector >> innerRadius [
	"An inner radius as a fraction of the max radius of the annulus [0..1]"
	<return: #Number>

	^ innerRadius
]

{ #category : 'accessing' }
BlAnnulusSector >> innerRadius: aNumber [
	"Set inner radius as a fraction of the max radius of the annulus [0..1]"
	innerRadius := aNumber min: 1.0 max: 0.0.
	self releaseCache
]

{ #category : 'geometry' }
BlAnnulusSector >> matchExtent: aPoint [
	"Resize geometry to exactly match provided extent as a Point"

	extent := aPoint
]

{ #category : 'accessing' }
BlAnnulusSector >> outerRadius [
	"An outer radius as a fraction of the max radius of the annulus [0..1]"
	<return: #Number>

	^ outerRadius
]

{ #category : 'accessing' }
BlAnnulusSector >> outerRadius: aNumber [
	"Set outer radius as a fraction of the max radius of the annulus [0..1]"
	outerRadius := aNumber min: 1.0 max: 0.0.
	self releaseCache
]

{ #category : 'private - geometry' }
BlAnnulusSector >> pointFromAngle: anAngleInRadians andRadius: aRadius around: aCenter [
	"Convert from spherical coordinates to cartesian coordinates"
	<return: #Point>
	| aX aY |
	
	aX := aCenter x + (aRadius * anAngleInRadians cos).
	aY := aCenter y + (aRadius * anAngleInRadians sin).

	^ aX @ aY
]

{ #category : 'private - geometry' }
BlAnnulusSector >> radius [
	<return: #Number>
	
	^ self extent min / 2.0
]

{ #category : 'accessing' }
BlAnnulusSector >> startAngle [
	^ startAngle
]

{ #category : 'accessing' }
BlAnnulusSector >> startAngle: anAngleInDegrees [
	startAngle := anAngleInDegrees.
	self releaseCache
]
