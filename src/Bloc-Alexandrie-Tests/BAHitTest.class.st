Class {
	#name : #BAHitTest,
	#superclass : #BAImageMatchTest,
	#category : #'Bloc-Alexandrie-Tests'
}

{ #category : #accessing }
BAHitTest >> actual [

	^ self surfaceForSpace: [ :aSpace | self newHitSurfaceFor: aSpace root ]
]

{ #category : #hooks }
BAHitTest >> expectedImagesSubdirectory [

	^ 'hit'
]

{ #category : #hooks }
BAHitTest >> newHitSurfaceFor: anElement [

	| allElements colors wordByElement surface extent data stride maxX maxY |
	allElements := anElement withAllChildrenBreadthFirst.
	colors := { Color white }, (Color wheel: allElements size - 1).
	wordByElement := IdentityDictionary new: allElements size.
	allElements with: colors do: [ :elem :col | wordByElement at: elem put: (col pixelWordForDepth: 32) ].

	extent := anElement extent asIntegerPoint.
	surface := AeCairoImageSurface extent: extent format: AeCairoSurfaceFormat argb32.
	data := surface data.
	stride := surface stride.
	maxX := extent x - 1.
	maxY := extent y - 1.

	1 to: maxX do: [ :x |
		1 to: maxY do: [ :y |
			| target elementWord offset |
			target := anElement findMouseEventTargetAt: x @ y.
			elementWord := wordByElement at: target ifAbsent: [ 16rFF000000 ].
			offset := (x bitShift: 2) + (y * stride).
			data uint32AtOffset: offset put: elementWord ] ].

	surface markDirty.
	surface flush.
	^ surface
]
