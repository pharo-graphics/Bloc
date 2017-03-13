layout
onMeasure: anExtentMeasurementSpec
	"If I am executed it means that measurement specification changed.
	We have to recreate a text layout with new parameters"
	| aHeightSpec aWidthSpec aMaxHeight aMaxWidth aPadding aMeasuredWidth aMeasuredHeight aMeasuredExtent |

	self
		assert: [ text isNotNil ]
		description: [ 'Text model must be nil!' ].

	(self shouldMeasure: anExtentMeasurementSpec)
		ifFalse: [ ^ self ].

	aMaxWidth := self constraints maxWidth.
	aMaxHeight := self constraints maxHeight.
	aWidthSpec := anExtentMeasurementSpec widthSpec.
	aHeightSpec := anExtentMeasurementSpec heightSpec.
	aPadding := self constraints padding.
	
	"Unspecified means that layout may take as much space horizontally as it wishes"
	aWidthSpec isUnspecified
		ifFalse: [ aMaxWidth := aMaxWidth min: aWidthSpec size ].
		"Unspecified means that layout may take as much space horizontally as it wishes"
	aHeightSpec isUnspecified
		ifFalse: [ aMaxHeight := aMaxHeight min: aHeightSpec size ].
	
	"Exact spec limits max height and width to specific values"
	aWidthSpec isExact ifTrue: [ 
		aMaxWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMaxHeight := aHeightSpec size ].
	
	aMaxWidth := (aMaxWidth - aPadding width) max: 0.
	aMaxHeight := (aMaxHeight - aPadding height) max: 0.
	
	textLayout
		"Create a new text layout"
		ifNil: [ textLayout := self defaultTextParagraph ]
		"or reuse existing"
		ifNotNil: [ textLayout reset ].

	textLayout
		text: self text;
		maxWidth: aMaxWidth;
		maxHeight: aMaxHeight.

	textLayout measureOn: self defaultOffscreenCanvas.
	"text layout is measured at this point"

	aMeasuredWidth := textLayout width.
	aMeasuredHeight := textLayout height.
	
	"If measurement spec is exact I must ignore size measured by textLayout"
	aWidthSpec isExact ifTrue: [ 
		aMeasuredWidth := aWidthSpec size ].
	aHeightSpec isExact ifTrue: [ 
		aMeasuredHeight := aHeightSpec size ].

	"Take minimal width and height into account"
	aMeasuredWidth := aMeasuredWidth max: self constraints minWidth - aPadding width.
	aMeasuredHeight := aMeasuredHeight max: self constraints minHeight - aPadding height.
	aMeasuredExtent := aMeasuredWidth @ aMeasuredHeight.
	"Take padding into account"
	aMeasuredExtent := aMeasuredExtent + (aPadding width @ aPadding height).
	
	"Finally set measured extent"
	self measuredExtent: aMeasuredExtent