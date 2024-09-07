Class {
	#name : #BlLayoutNodeResizerMeasurement,
	#superclass : #BlLayoutNodeMeasurement,
	#category : #'Bloc-Layouts-Model'
}

{ #category : #measure }
BlLayoutNodeResizerMeasurement >> measure: aLayoutChildNode with: anExtentSpecOrBlock [

	| anExtentSpec width measuredWidth height measuredHeight |

	anExtentSpec := anExtentSpecOrBlock value.

   width := 0.0 max: (anExtentSpec widthSpec size).
	measuredWidth :=
		(anExtentSpec widthSpec mode
			measurement: aLayoutChildNode horizontalResizer
			with: width) size.

	height := 0.0 max: (anExtentSpec heightSpec size).
	measuredHeight :=
		(anExtentSpec heightSpec mode
			measurement: aLayoutChildNode verticalResizer
			with: height) size.

	^ BlLayoutNodeComputedMeasurement
		position: aLayoutChildNode constraints position
		extent: (measuredWidth @ measuredHeight)
]
