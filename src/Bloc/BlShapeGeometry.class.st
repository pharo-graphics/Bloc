"
I am a geometry that uses a ${class:BlVectorShape}$ object to specify a geometrical area. I can match the extend of the element to which I am attached, when this extent changes.

!!Initialization
Users should use the method ${method:BlShapeGeometry>>#shape:}$ to specify a custom builder for creating ${class:BlVectorShape}$ objects having a given extent. I use this builder to update the geometry when the extent of the attached element changes (${method:BlShapeGeometry>>#extent:}$).
${example:BlShapeGeometryExample>>#geometryWithSimpleRectangleShape|previewExpanded=false|previewHeight=250}$

By default, in case no builder is provided, I use a builder that create an ${class:BlRectangleShape}$ object. Hence, the previous example is equivalent to simply instantiating a ${class:BlShapeGeometry}$ (${method:BlShapeGeometryExample>>#defaultGeometry}$).

Since ${class:BlVectorShape}$ objects are polymorphic with blocks and can fit to fit a given rectangle, instances of ${class:BlVectorShape}$ can also directly be passed to ${method:BlShapeGeometry>>#shape:}$. In this case the extent used to instantiate the shape object is not take into account (${method:BlShapeGeometryExample>>#geometryWithRectangleShareInstance}$).

!!Usage
I can be directly attached to any graphical element, like any other geometry, and I will match the extend of the element. For example, below there are two examples, where the same ${class:BlShapeGeometry}$ is attached to two elements having a different extent.

${example:BlShapeGeometryExample>>#elementWithRectangleGeometry|previewExpanded=true|previewHeight=250}$
${example:BlShapeGeometryExample>>#elementLargeWithRectangleGeometry|previewExpanded=true|previewHeight=250}$
"
Class {
	#name : #BlShapeGeometry,
	#superclass : #BlGeometry,
	#instVars : [
		'shapeBuilder',
		'vectorShape'
	],
	#category : #'Bloc-Basic'
}

{ #category : #private }
BlShapeGeometry >> createVectorShape [
	^ shapeBuilder value: (0@0 extent: extent)
]

{ #category : #geometry }
BlShapeGeometry >> extent: aPoint [
	extent := aPoint.
	vectorShape := self createVectorShape.
	self releaseCache
]

{ #category : #testing }
BlShapeGeometry >> hasShapeBuilder [
	^ shapeBuilder notNil
]

{ #category : #initialization }
BlShapeGeometry >> initialize [
	super initialize.

	shapeBuilder := [ :aRectangle | BlRectangleShape rectangle: aRectangle ].
	vectorShape := self createVectorShape
]

{ #category : #geometry }
BlShapeGeometry >> matchExtent: aPoint [
	self extent: aPoint
]

{ #category : #initialization }
BlShapeGeometry >> shape: aBlockOrVectorShape [
	"Initialize the geometry with a builder used to create a ${class:BlVectorShape}$ object with a given extent. The builder can be any object that understands ==value:==."
		
	self 
		assert: [ aBlockOrVectorShape notNil ] 
		description: 'The shape builder should not be nil.'.
	
	shapeBuilder := aBlockOrVectorShape.
	vectorShape := self createVectorShape.
	self releaseCache
]
