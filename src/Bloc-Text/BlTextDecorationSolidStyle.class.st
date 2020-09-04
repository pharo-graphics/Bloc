"
!Solid style
${example:BlTextDecorationStyleExamples>>#solid|codeExpanded=false|previewExpanded=true|previewShow=#gtPreviewFor:|previewHeight=50}$
"
Class {
	#name : #BlTextDecorationSolidStyle,
	#superclass : #BlTextDecorationStyle,
	#category : #'Bloc-Text-Text-Decoration'
}

{ #category : #accessing }
BlTextDecorationSolidStyle class >> constructor [
	^ #solid
]

{ #category : #accessing }
BlTextDecorationSolidStyle class >> label [
	^ 'Solid'
]
