"
BlMobilePhone open
"
Class {
	#name : #BlMobilePhone,
	#superclass : #BlElement,
	#category : 'Bloc-Examples-Showcase-Mobile Phone'
}

{ #category : #dimensions }
BlMobilePhone class >> mmBodyHeight [
	^  123.8
]

{ #category : #dimensions }
BlMobilePhone class >> mmBodyWidth [
	^ 58.6
]

{ #category : #dimensions }
BlMobilePhone class >> mmBottomHeight [
	^ 16.72
]

{ #category : #dimensions }
BlMobilePhone class >> mmCameraDiameter [
	^ 2.38
]

{ #category : #dimensions }
BlMobilePhone class >> mmCameraTopMargin [
	^ 4.88
]

{ #category : #dimensions }
BlMobilePhone class >> mmHomeButtonDiameter [
	^ 10.90
]

{ #category : #dimensions }
BlMobilePhone class >> mmHomeButtonTopMargin [
	^ 2.91
]

{ #category : #dimensions }
BlMobilePhone class >> mmScreenHeight [
	^ 90.25
]

{ #category : #dimensions }
BlMobilePhone class >> mmScreenMargin [
	^ 3.43
]

{ #category : #dimensions }
BlMobilePhone class >> mmScreenWidth [
	^ 51.6
]

{ #category : #dimensions }
BlMobilePhone class >> mmSpeakerHeight [
	^  2.3
]

{ #category : #dimensions }
BlMobilePhone class >> mmSpeakerWidth [
	^  10.8
]

{ #category : #dimensions }
BlMobilePhone class >> mmTopHeight [
	^ 16.83
]

{ #category : #dimensions }
BlMobilePhone class >> multFactor [
	^ 4.2
]

{ #category : #'instance creation' }
BlMobilePhone class >> open [
	<script: 'self open'>
	BlSpace new
		title: 'iOS Simulator';
		extent: (self pxBodyWidth @ self pxBodyHeight) + (10@10);
		rootDo: [ :r | r 
			layout:(BlLinearLayout vertical );
			addChild: self new ];
		show
]

{ #category : #dimensions }
BlMobilePhone class >> pxBodyHeight [
	^ self mmBodyHeight * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxBodyWidth [
	^ self mmBodyWidth * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxBottomHeight [
	^ self mmBottomHeight * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxCameraDiameter [
	^ self mmCameraDiameter * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxCameraTopMargin [
	^ self mmCameraTopMargin * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxHomeButtonDiameter [
	^ self mmHomeButtonDiameter * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxHomeButtonTopMargin [
	^ self mmHomeButtonTopMargin * self multFactor 
]

{ #category : #dimensions }
BlMobilePhone class >> pxScreenHeight [
	^ self mmScreenHeight * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxScreenMargin [
	^ self mmScreenMargin * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxScreenWidth [
	^ self mmScreenWidth * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxSpeakerHeight [
	^  self mmSpeakerHeight * self multFactor
]

{ #category : #dimensions }
BlMobilePhone class >> pxSpeakerWidth [
	^  self mmSpeakerWidth * self multFactor 
]

{ #category : #dimensions }
BlMobilePhone class >> pxTopHeight [
	^ self mmTopHeight * self multFactor
]

{ #category : #initialization }
BlMobilePhone >> initialize [
	super initialize.
	self border: (BlBorder paint: Color black width: 2).
	self geometry: (BlRectangle cornerRadius: 20).
	self size: self class pxBodyWidth @ self class pxBodyHeight.
	self padding: (BlInsets all: 5).
	self constraintsDo: [ :c| 
		 c linear horizontal alignCenter.
		 c linear vertical alignCenter ].
	self
		addChild: BlMobileContent new;
		addChild: BlMobileGlass new
]
