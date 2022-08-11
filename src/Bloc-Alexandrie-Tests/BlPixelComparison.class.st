"
I am a comparison between forms that should match.

See #isMatch, my main testing method.

My NewTools inspections help humans to understand what's different between two bitmaps that should be equal.

My colaborators are two instances of Form (the expected and the actual bitmap) and a String that serves as label for the comparison.
"
Class {
	#name : #BlPixelComparison,
	#superclass : #Object,
	#instVars : [
		'actualForm',
		'expectedForm',
		'label'
	],
	#category : #'Bloc-Alexandrie-Tests-Utilities'
}

{ #category : #'instance creation' }
BlPixelComparison class >> expectedForm: aForm actualForm: anotherForm label: aString [

	^ self new
		  expectedForm: aForm;
		  actualForm: anotherForm;
		  label: aString;
		  yourself
]

{ #category : #accessing }
BlPixelComparison >> actualForm [

	^ actualForm
]

{ #category : #accessing }
BlPixelComparison >> actualForm: aForm [

	actualForm := aForm
]

{ #category : #'accessing diff' }
BlPixelComparison >> actualVsExpectedMergedDiffForm [
	
	| actualDiffForm expectedDiffForm |
	actualDiffForm := Form extent: actualForm extent depth: actualForm depth.
	expectedDiffForm := Form extent: expectedForm extent depth: expectedForm depth.
	
	1 to: (actualForm width min: expectedForm width) do: [ :x |
		1 to: (actualForm height min: expectedForm height) do: [ :y |

			| currentPoint actualColor expectedColor |
			currentPoint := x@y - (1@1). "Weird: forms are 0-indexed"
			actualColor := actualForm colorAt: currentPoint.
			expectedColor := expectedForm colorAt: currentPoint.
			actualColor = expectedColor ifFalse: [
				actualDiffForm colorAt: currentPoint put: actualColor.
				expectedDiffForm colorAt: currentPoint put: expectedColor ]

			] ].
	
	^ self concatenatedForm: actualDiffForm and: expectedDiffForm

]

{ #category : #'accessing diff' }
BlPixelComparison >> actualVsExpectedMergedForm [

	^ self concatenatedForm: actualForm and: expectedForm
]

{ #category : #private }
BlPixelComparison >> concatenatedForm: aForm and: anotherForm [
	"Answer a Form with both forms separated by a transparent vertical 1-pixel line."

	| mergedForm |
	mergedForm := Form extent: (aForm width + anotherForm width + 1) @ (anotherForm height max: aForm height) depth: 32.
	mergedForm := mergedForm mergeWith: aForm at: 0@0.
	mergedForm := mergedForm mergeWith: anotherForm at: (aForm width + 1) @ 0.
	
	^ mergedForm

]

{ #category : #accessing }
BlPixelComparison >> expectedForm [

	^ expectedForm
]

{ #category : #accessing }
BlPixelComparison >> expectedForm: aForm [

	expectedForm := aForm
]

{ #category : #spec }
BlPixelComparison >> inspectionActualVsExpected: aBuilder [
	<inspectorPresentationOrder: 1 title: 'Actual/Expected'>

	^ aBuilder newMorph
		morph: (self actualVsExpectedMergedForm  magnifyBy:
			self inspectionMagnification) asMorph;
		yourself
]

{ #category : #spec }
BlPixelComparison >> inspectionActualVsExpectedDiff: aBuilder [
	<inspectorPresentationOrder: 2 title: 'Actual/Expected Diff'>

	^ aBuilder newMorph
		  morph: (self actualVsExpectedMergedDiffForm magnifyBy:
				self inspectionMagnification) asMorph;
		  yourself
]

{ #category : #spec }
BlPixelComparison >> inspectionMagnification [

	^ 3
]

{ #category : #testing }
BlPixelComparison >> isMatch [

	^ 0 = (expectedForm pixelCompare: (0@0 corner: expectedForm extent) with: actualForm at: 0@0).
]

{ #category : #accessing }
BlPixelComparison >> label: aString [ 
	
	label := aString
]

{ #category : #printing }
BlPixelComparison >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPut: $(;
		nextPutAll: label;
		space;
		nextPutAll: (self isMatch ifTrue: [ 'match' ] ifFalse: [ 'mismatch' ]);
		nextPut: $)

]
