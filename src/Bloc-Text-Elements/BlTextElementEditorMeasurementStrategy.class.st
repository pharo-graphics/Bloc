Class {
	#name : #BlTextElementEditorMeasurementStrategy,
	#superclass : #BlTextElementMeasurementStrategy,
	#category : #'Bloc-Text-Elements'
}

{ #category : #'as yet unclassified' }
BlTextElementEditorMeasurementStrategy >> boundsOf: aParagraph [
	<return: #BlBounds>
	| aMeasuredWidth aMeasuredHeight |

	aMeasuredWidth := aParagraph advance.
	aMeasuredHeight := (aParagraph ascent abs + aParagraph descent).

	^ BlBounds origin: 0.0@0.0 extent: aMeasuredWidth @ aMeasuredHeight
]
