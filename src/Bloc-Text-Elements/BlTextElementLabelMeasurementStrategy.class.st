Class {
	#name : 'BlTextElementLabelMeasurementStrategy',
	#superclass : 'BlTextElementMeasurementStrategy',
	#category : 'Bloc-Text-Elements',
	#package : 'Bloc-Text-Elements'
}

{ #category : 'measuring' }
BlTextElementLabelMeasurementStrategy >> boundsOf: aParagraph [

	| aMeasuredWidth aMeasuredHeight |

	aMeasuredWidth := aParagraph width.
	aMeasuredHeight := (aParagraph ascent abs + aParagraph descent).

	^ BlBounds origin: 0.0@0.0 extent: aMeasuredWidth @ aMeasuredHeight
]
