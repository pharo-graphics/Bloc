rendering
renderSpan: aSpan on: aCanvas
	| attributes aTransformation aTransformationInverted hasTransformation aTextPainter aBaseline |

	attributes := aSpan attributes.
	aTransformation := aSpan transformation.
	aTransformationInverted := aSpan transformationInverted.
	hasTransformation :=	aTransformation isNotNil and: [ aTransformationInverted isNotNil ].

	aTextPainter := aCanvas text.
	attributes
		do: [ :attribute |
			attribute drawBelowOn: aCanvas with: aSpan.
			attribute applyOnText: aTextPainter with: aSpan ].
	
	aBaseline := hasTransformation
		ifTrue: [ aTransformationInverted transform: (aSpan baseline + aTransformation translation) ]
		ifFalse: [ aSpan baseline ].
	aBaseline := aBaseline + self offset.

	"If transformation is just a translation there is no need
	to changed transformation matrix of a canvas, we can just
	translate a baseline - simply faster"
	(hasTransformation not or: [ aTransformation isPureTranslation ])
		ifTrue: [ 
			hasTransformation
				ifTrue: [ aBaseline := aBaseline + aTransformation translation ].
			self renderSpan: aSpan with: aTextPainter at: aBaseline ]
		ifFalse: [ 
			aCanvas transform during: [ :aTransform | 
				aTransform
					multiplyBy: aTransformation;
					apply.
				self renderSpan: aSpan with: aTextPainter at: aBaseline ] ].

	"And finally let attributes to render above the text"
	attributes
		do: [ :attribute | attribute drawAboveOn: aCanvas with: aSpan ].