Class {
	#name : #BlHostSurfaceRenderer,
	#superclass : #Object,
	#classVars : [
		'IsDebugMode'
	],
	#category : #'Bloc-Universe - Renderer'
}

{ #category : #'as yet unclassified' }
BlHostSurfaceRenderer class >> debugMode: aBoolean [

	IsDebugMode := aBoolean
]

{ #category : #'as yet unclassified' }
BlHostSurfaceRenderer class >> drawDamagedRectangle: damagedRectangle on: aeCanvas [

	IsDebugMode ifTrue: [
		aeCanvas privateAeCairoContext
			rectangle: damagedRectangle;
			strokeSize: 2;
			strokeDashPattern: #(2);
			sourceColor: Color black;
			stroke ]
]

{ #category : #'as yet unclassified' }
BlHostSurfaceRenderer class >> initialize [

	IsDebugMode := false
]

{ #category : #'as yet unclassified' }
BlHostSurfaceRenderer class >> logDamagedRectangle: damagedRectangle [

	IsDebugMode ifTrue: [
		Stdio stdout print: damagedRectangle; lf ]
]

{ #category : #initialization }
BlHostSurfaceRenderer >> initializeForSurface: aSurface [

	self subclassResponsibility
]
