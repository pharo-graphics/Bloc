"
!Dashed style

${example:BlTextDecorationStyleExamples>>#dashed}$
"
Class {
	#name : #BlTextDecorationDashedStyle,
	#superclass : #BlTextDecorationStyle,
	#category : #'Bloc-Text-Text-Decoration'
}

{ #category : #accessing }
BlTextDecorationDashedStyle class >> constructor [
	^ #dashed
]

{ #category : #accessing }
BlTextDecorationDashedStyle class >> label [
	^ 'Dashed'
]
