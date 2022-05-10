Class {
	#name : #BlLayoutNodeTextMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#instVars : [
		'text',
		'baseline',
		'measurer',
		'boundsMeasurement'
	],
	#category : #'Bloc-Text-Elements'
}

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> baseline [
	<return: #BlTextParagraphBaselineMeasurer>

	^ baseline
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> baseline: aBlTextParagraphBaseline [
	baseline := aBlTextParagraphBaseline
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> boundsMeasurement [
	<return: #BlTextElementMeasurementStrategy>

	^ boundsMeasurement
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> boundsMeasurement: aBlTextElementMeasurementStrategy [
	boundsMeasurement := aBlTextElementMeasurementStrategy
]

{ #category : #'private - measurement' }
BlLayoutNodeTextMeasurement >> computeMaxHeight: anExtentMeasurementSpec for: aLayoutChildNode [
	<return: #Number>
	| aMaxHeight aHeightSpec aPadding |

	aMaxHeight := aLayoutChildNode maxHeight.
	aPadding := aLayoutChildNode padding.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	
	aHeightSpec isUnspecified
		ifFalse: [ aMaxHeight := aMaxHeight min: aHeightSpec size ].

	aMaxHeight := (aMaxHeight - aPadding height) max: 0.
	
	^ aMaxHeight
]

{ #category : #'private - measurement' }
BlLayoutNodeTextMeasurement >> computeMaxWidth: anExtentMeasurementSpec for: aLayoutChildNode [
	<return: #Number>
	| aMaxWidth aWidthSpec aPadding |

	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aMaxWidth := aLayoutChildNode maxWidth.
	aPadding := aLayoutChildNode padding.
	
	"Unspecified means that layout may take as much space horizontally as it wishes"
	aWidthSpec isUnspecified
		ifFalse: [ aMaxWidth := aMaxWidth min: aWidthSpec size ].

	aMaxWidth := (aMaxWidth - aPadding width) max: 0.
	
	^ aMaxWidth
]

{ #category : #measure }
BlLayoutNodeTextMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [

	| anExtentMeasurementSpec aWidthSpec aHeightSpec aMaxWidth aMaxHeight aPadding aParagraph aMeasuredBounds aMeasuredWidth aMeasuredHeight aMeasuredExtent |
	
	anExtentMeasurementSpec := anExtentSpecOrBlock value.
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := aLayoutChildNode padding.

	aMaxWidth := self computeMaxWidth: anExtentMeasurementSpec for: aLayoutChildNode.
	aMaxHeight := self computeMaxHeight: anExtentMeasurementSpec for: aLayoutChildNode.

	aParagraph := BlTextParagraph new
		baseline: self baseline;
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight;
		scale: 1.

	self measurer measureTextParagraph: aParagraph.

	aMeasuredBounds := boundsMeasurement boundsOf: aParagraph.
	aMeasuredWidth := aMeasuredBounds width min: aMaxWidth.
	aMeasuredHeight := aMeasuredBounds height min: aMaxHeight.

	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ 
		aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max: aLayoutChildNode minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max: aLayoutChildNode minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent + (aPadding width @ aPadding height).

	^ BlLayoutNodeTextComputedMeasurement new
		paragraph: aParagraph;
		extent: aMeasuredExtent
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> measurer [
	<return: #BlHostTextMeasurer>

	^ measurer
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> measurer: aBlHostTextMeasurer [
	measurer := aBlHostTextMeasurer
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> text [
	<return: #BlText>

	^ text
]

{ #category : #accessing }
BlLayoutNodeTextMeasurement >> text: aBlText [
	text := aBlText
]
