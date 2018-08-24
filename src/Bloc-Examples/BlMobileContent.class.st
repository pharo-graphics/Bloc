Class {
	#name : #BlMobileContent,
	#superclass : #BlMobileSubElement,
	#category : 'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #'as yet unclassified' }
BlMobileContent >> createBottomEl [
	^ BlMobileSubElement new
		layout: BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxBottomHeight ];
		addChild: BlMobileHomeButton new;
		yourself
]

{ #category : #'as yet unclassified' }
BlMobileContent >> createGradientPaint [
	^ BlLinearGradientPaint new
		stops:
			{(0.0 -> Color gray).
			(0.3 -> Color darkGray).
			(0.6 -> Color darkGray).
			(1.0 -> Color gray)};
		start: (BlMobilePhone pxSpeakerWidth / 2) @ 0;
		end: (BlMobilePhone pxSpeakerWidth / 2) @ BlMobilePhone pxSpeakerHeight;
		yourself
]

{ #category : #'as yet unclassified' }
BlMobileContent >> createScreenEl [
	^ BlMobileSubElement new
		layout:BlLinearLayout vertical;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxScreenHeight ];
		padding: (BlInsets
			left: BlMobilePhone pxScreenMargin
			right: BlMobilePhone pxScreenMargin);
		addChild: BlMobileSoftware new;
		yourself
]

{ #category : #'as yet unclassified' }
BlMobileContent >> createTopEl [
	^ BlMobileSubElement new
		layout: BlLinearLayout vertical;
		padding: (BlInsets top:  BlMobilePhone pxCameraTopMargin);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical exact: BlMobilePhone pxTopHeight ];
		addChild: BlMobileCamera new;
		addChild: BlMobileSpeaker new;
		yourself
]

{ #category : #'as yet unclassified' }
BlMobileContent >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self background: Color black.
	self border: (BlBorder paint: self createGradientPaint width: 2).
	self constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical matchParent ].
	self
		addChild: self createTopEl;
		addChild: self createScreenEl;
		addChild: self createBottomEl
]
