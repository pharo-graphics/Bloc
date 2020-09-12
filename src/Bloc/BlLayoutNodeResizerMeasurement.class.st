Class {
	#name : #BlLayoutNodeResizerMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#category : #'Bloc-Layouts-Basic'
}

{ #category : #measure }
BlLayoutNodeResizerMeasurement >> measure: aLayoutChildNode with: anExtentSpec [
	<return: #BlLayoutNodeMeasurement>
	| width measuredWidth height measuredHeight |

   width := 0.0 max: (anExtentSpec widthSpec size).
	measuredWidth := (anExtentSpec widthSpec mode measurement: aLayoutChildNode horizontalResizer with: width) size.

	height := 0.0 max: (anExtentSpec heightSpec size).
	measuredHeight := (anExtentSpec heightSpec mode measurement: aLayoutChildNode verticalResizer with: height) size.

	^ BlLayoutNodeComputedMeasurement new
		extent: (measuredWidth @ measuredHeight);
		position: aLayoutChildNode constraints position
]
