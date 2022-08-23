"
I'm a tool to visually inspect any hit testing differences between Alexandrie and Sparta.

Note: Use should select Sparta Cairo in the Bloc section of System settings.
"
Class {
	#name : #BlHitDifferenceInspector,
	#superclass : #Object,
	#category : #'Bloc-Alexandrie-Tests-Utilities'
}

{ #category : #convenience }
BlHitDifferenceInspector >> allComparisons [
	<script: 'self new allComparisons inspect'>

	^ BlSpaceFixture allFixtureSelectors collect: [ :each | 
		  self pixelComparisonFor: each ]
]

{ #category : #accessing }
BlHitDifferenceInspector >> hitFormFor: aSymbol host: aHost [
		
	| aSpace |
	aSpace := BlSpaceFixture new
		host: aHost;
		perform: aSymbol;
		space.
	^ self hitFormFor: aSymbol space: aSpace
]

{ #category : #accessing }
BlHitDifferenceInspector >> hitFormFor: aSymbol space: aSpace [

	| aForm duration |

	duration := [
		aForm := BAHitFormFactory newFormFor: aSpace
		] timeToRun.

	"Trace to benchmark"
	aSymbol trace.
	' - ' trace.
	aSpace host class label trace.
	': ' trace.
	duration asMilliSeconds trace.
	'ms' traceCr.

	^ aForm
]

{ #category : #accessing }
BlHitDifferenceInspector >> pixelComparisonFor: aSymbol [
	
	^ AePixelComparison
		expectedForm: (self hitFormFor: aSymbol host: BlOSWindowSDL2Host new)
		actualForm: (self hitFormFor: aSymbol host: BAOSWindowSDL2Host new)
		label: aSymbol
]
