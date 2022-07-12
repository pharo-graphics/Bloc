Class {
	#name : #BlTextElementTightMeasurementStrategy,
	#superclass : #BlTextElementMeasurementStrategy,
	#category : #'Bloc-Text-Elements'
}

{ #category : #measuring }
BlTextElementTightMeasurementStrategy >> boundsOf: aParagraph [

	| aMeasuredWidth aMeasuredHeight |

	aMeasuredWidth := aParagraph width.
	aMeasuredHeight :=aParagraph height.

	^ BlBounds origin: aParagraph left @ 0.0 extent: aMeasuredWidth @ aMeasuredHeight
]
