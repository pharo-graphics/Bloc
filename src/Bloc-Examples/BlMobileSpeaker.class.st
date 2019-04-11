Class {
	#name : #BlMobileSpeaker,
	#superclass : #BlMobileSubElement,
	#category : #'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #'as yet unclassified' }
BlMobileSpeaker >> createGradientPaint [
	^ BlLinearGradientPaint new
		stops:
			{ (0.0 -> (Color veryDarkGray alpha: 0.3)).
			(0.3 -> (Color veryDarkGray alpha: 0.7)).
			(0.6 -> (Color veryDarkGray alpha: 0.7)).
			(1.0 -> (Color veryDarkGray alpha: 0.3)) };
		start: (BlMobilePhone pxSpeakerWidth / 2) @ 0;
		end: (BlMobilePhone pxSpeakerWidth / 2) @ BlMobilePhone pxSpeakerHeight;
		yourself
]

{ #category : #initialization }
BlMobileSpeaker >> initialize [
	super initialize.
	self background: Color black lighter.
	self border: (BlBorder paint: self createGradientPaint width: 2).
	self margin: (BlInsets top: 5).
	self constraintsDo: [ :c| c linear horizontal alignCenter  ].
	self size:  BlMobilePhone pxSpeakerWidth @ BlMobilePhone pxSpeakerHeight
]
