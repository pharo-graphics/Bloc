Class {
	#name : #BlTextElementLabelMeasurementStrategy,
	#superclass : #BlTextElementMeasurementStrategy,
	#category : #'Bloc-Text-Elements'
}

{ #category : #'as yet unclassified' }
BlTextElementLabelMeasurementStrategy >> boundsOf: aParagraph [
	<return: #BlBounds>
	| aMeasuredWidth aMeasuredHeight |

	aMeasuredWidth := aParagraph width.
	aMeasuredHeight := (aParagraph ascent + aParagraph descent).

	^ BlBounds origin: 0@0 extent: aMeasuredWidth @ aMeasuredHeight
]
