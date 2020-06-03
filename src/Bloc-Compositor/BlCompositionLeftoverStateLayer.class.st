Class {
	#name : #BlCompositionLeftoverStateLayer,
	#superclass : #BlCompositionContainerLayer,
	#instVars : [
		'state'
	],
	#category : #'Bloc-Compositor-Layers'
}

{ #category : #converting }
BlCompositionLeftoverStateLayer >> asSkiaLayer [
	<return: #SkiaCompositionOffsetLayer>
	| theChildLayers skiaLayer |
	
	skiaLayer := SkiaCompositionLeftoverStateLayer new.
	self state applyOnLayer: skiaLayer.
	theChildLayers := self children collect: [ :eachLayer | eachLayer asSkiaLayer ].
	theChildLayers do: [ :eachLayer | skiaLayer addLayer: eachLayer ].
	
	^ skiaLayer
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> commands [
	<return: #Array of: #BlCompositionPainterStateCommand>
	
	^ self state commands
]

{ #category : #'gt-extension' }
BlCompositionLeftoverStateLayer >> gtStateCommandsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'State commands';
		priority: 4;
		object: [ self state ];
		view: #gtCommandsFor:
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> name [
	^ 'Leftover state'
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> offset: anOffset [
	self children do: [ :eachLayer | eachLayer offset: anOffset ]
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> state [
	^ state
]

{ #category : #accessing }
BlCompositionLeftoverStateLayer >> state: anObject [
	state := anObject
]
