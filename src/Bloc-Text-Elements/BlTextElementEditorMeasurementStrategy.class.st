Class {
	#name : 'BlTextElementEditorMeasurementStrategy',
	#superclass : 'BlTextElementMeasurementStrategy',
	#category : 'Bloc-Text-Elements',
	#package : 'Bloc-Text-Elements'
}

{ #category : 'measuring' }
BlTextElementEditorMeasurementStrategy >> boundsOf: aParagraph [

	| aMeasuredWidth aMeasuredHeight |

	aMeasuredWidth := aParagraph advance.
	aMeasuredHeight := (aParagraph ascent abs + aParagraph descent).

	^ BlBounds origin: 0.0@0.0 extent: aMeasuredWidth @ aMeasuredHeight
]
