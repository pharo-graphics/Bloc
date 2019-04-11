Class {
	#name : #BlExampleSwitchElement,
	#superclass : #BlElement,
	#traits : 'TBlExample',
	#classTraits : 'TBlExample classTrait',
	#instVars : [
		'activated',
		'skin',
		'controller'
	],
	#category : #'Bloc-Examples-Widgets'
}

{ #category : #examples }
BlExampleSwitchElement class >> all [
	<gtExample>
	
	^ BlElement new
		layout: (BlGridLayout vertical rowCount: 4; cellSpacing: 20);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { 
			self withTrackOrange activate.
			self withTrackOrange deactivate.
			self withTrack activate.
			self withTrack deactivate.
			
			self withoutTrackOrange activate.
			self withoutTrackOrange deactivate.
			self withoutTrack activate.
			self withoutTrack deactivate.
			
			self radioOrange activate.
			self radioOrange deactivate.
			self radio activate.
			self radio deactivate.
		}
]

{ #category : #opening }
BlExampleSwitchElement class >> openAll [
	<script: 'self openAll'>
	
	self
		openInWindow: (self all
			relocate: 150@150;
			transformDo: [ :t | t scaleBy: 3 ])
		named: 'Hydra switches'
		extent: 450@450
]

{ #category : #opening }
BlExampleSwitchElement class >> openRadio [
	<script: 'self openRadio'>
	
	self
		openInWindow: (self radio
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 232@165
]

{ #category : #opening }
BlExampleSwitchElement class >> openRadioOrange [
	<script: 'self openRadioOrange'>
	
	self
		openInWindow: (self radioOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 232@165
]

{ #category : #opening }
BlExampleSwitchElement class >> openWithTrack [
	<script: 'self openWithTrack'>
	
	self
		openInWindow: (self withTrack
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 255@165
]

{ #category : #opening }
BlExampleSwitchElement class >> openWithTrackOrange [
	<script: 'self openWithTrackOrange'>
	
	self
		openInWindow: (self withTrackOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 255@165
]

{ #category : #opening }
BlExampleSwitchElement class >> openWithoutTrack [
	<script: 'self openWithoutTrack'>
	
	self
		openInWindow: (self withoutTrack
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 240@165
]

{ #category : #opening }
BlExampleSwitchElement class >> openWithoutTrackOrange [
	<script: 'self openWithoutTrackOrange'>
	
	self
		openInWindow: (self withoutTrackOrange
			relocate: 110@75;
			transformDo: [ :t | t scaleBy: 4 ])
		named: 'Hydra switch'
		extent: 240@165
]

{ #category : #examples }
BlExampleSwitchElement class >> radio [
	<gtExample>
	
	^ self new skin: (BlExampleSwitchSkinRadio new)
]

{ #category : #examples }
BlExampleSwitchElement class >> radioOrange [
	<gtExample>

	^ self new skin: (BlExampleSwitchSkinRadio new color: (Color fromHexString: 'f5dbaa'))
]

{ #category : #opening }
BlExampleSwitchElement class >> spaceBackground [
	^ Color fromHexString: '162425'
]

{ #category : #examples }
BlExampleSwitchElement class >> withTrack [
	<gtExample>
	
	^ self new skin: (BlExampleSwitchSkinWithTrack new)
]

{ #category : #examples }
BlExampleSwitchElement class >> withTrackOrange [
	<gtExample>
	
	^ self new skin: (BlExampleSwitchSkinWithTrack new color: (Color fromHexString: 'f5dbaa'))
]

{ #category : #examples }
BlExampleSwitchElement class >> withoutTrack [
	<gtExample>
	
	^ self new skin: (BlExampleSwitchSkinWithoutTrack new)
]

{ #category : #examples }
BlExampleSwitchElement class >> withoutTrackOrange [
	<gtExample>
	
	^ self new skin: (BlExampleSwitchSkinWithoutTrack new color: (Color fromHexString: 'f5dbaa'))
]

{ #category : #public }
BlExampleSwitchElement >> activate [
	activated := true.
	self dispatchEvent: BlExampleSwitchEventActivated new
]

{ #category : #public }
BlExampleSwitchElement >> activated: aBoolean [
	aBoolean
		ifTrue: [ self activate ]
		ifFalse: [ self deactivate ]
]

{ #category : #accessing }
BlExampleSwitchElement >> controller [
	^ controller
]

{ #category : #accessing }
BlExampleSwitchElement >> controller: aController [
	self removeEventHandler: self controller.
	controller := aController.
	self addEventHandler: self controller
]

{ #category : #public }
BlExampleSwitchElement >> deactivate [	
	activated := false.
	self dispatchEvent: BlExampleSwitchEventDeactivated new
]

{ #category : #initialization }
BlExampleSwitchElement >> defaultController [
	^ BlExampleSwitchController new
]

{ #category : #initialization }
BlExampleSwitchElement >> defaultSkin [
	^ BlExampleSwitchSkinWithTrack new
]

{ #category : #initialization }
BlExampleSwitchElement >> initialize [
	super initialize.
	
	activated := false.
	self skin: self defaultSkin.
	self controller: self defaultController
]

{ #category : #testing }
BlExampleSwitchElement >> isActivated [
	^ activated
]

{ #category : #'instance creation' }
BlExampleSwitchElement >> newSwitchListener [
	^ BlExampleSwitchController new
]

{ #category : #accessing }
BlExampleSwitchElement >> skin [
	^ skin
]

{ #category : #accessing }
BlExampleSwitchElement >> skin: aSkin [
	self removeEventHandler: self skin.
	
	skin := aSkin.
	self addEventHandler: self skin
]
