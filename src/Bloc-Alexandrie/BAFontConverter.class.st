"
I convert from a BlFont to a Cairo font.
"
Class {
	#name : #BAFontConverter,
	#superclass : #Object,
	#instVars : [
		'slantConverter',
		'weightConverter',
		'stretchConverter'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'Bloc-Alexandrie-Text'
}

{ #category : #accessing }
BAFontConverter class >> reset [
	<script>

	uniqueInstance := nil
]

{ #category : #accessing }
BAFontConverter class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #initialization }
BAFontConverter >> aeSlantAt: fontSlant [

	^ slantConverter at: fontSlant
]

{ #category : #initialization }
BAFontConverter >> aeStretchAt: fontStretch [

	^ stretchConverter at: fontStretch
]

{ #category : #initialization }
BAFontConverter >> aeWeightAt: fontWeight [

	^ weightConverter at: fontWeight
]

{ #category : #initialization }
BAFontConverter >> faceFor: aBlFont [

	^ AeFontManager globalInstance
		detectFamilyName: aBlFont familyName
		slant: (self aeSlantAt: aBlFont fontSlant)
		weight: (self aeWeightAt: aBlFont fontWeight)
		stretch: (self aeStretchAt: aBlFont fontStretch)
		ifNone: [ AeFontManager globalInstance defaultFace ]
]

{ #category : #initialization }
BAFontConverter >> initialize [

	super initialize.

	slantConverter := IdentityDictionary new
		at: BlFontSlant normal put: AeFontSlant normal;
		at: BlFontSlant italic put: AeFontSlant italic;
		at: BlFontSlant oblique put: AeFontSlant oblique;
		yourself.
	stretchConverter := IdentityDictionary new
		at: BlFontStretch ultraCondensed put: AeFontStretch ultraCondensed;
		at: BlFontStretch extraCondensed put: AeFontStretch extraCondensed;
		at: BlFontStretch condensed put: AeFontStretch condensed;
		at: BlFontStretch semiCondensed put: AeFontStretch semiCondensed;
		at: BlFontStretch normal put: AeFontStretch normal; 
		at: BlFontStretch semiExpanded put: AeFontStretch semiExpanded;
		at: BlFontStretch expanded put: AeFontStretch expanded;
		at: BlFontStretch extraExpanded put: AeFontStretch extraExpanded;
		at: BlFontStretch ultraExpanded put: AeFontStretch ultraExpanded;
		yourself.
	weightConverter := IdentityDictionary new
		at: BlFontWeight thin put: AeFontWeight thin;
		at: BlFontWeight extraLight put: AeFontWeight extraLight;
		at: BlFontWeight light put: AeFontWeight light;
		at: BlFontWeight normal put: AeFontWeight normal;
		at: BlFontWeight medium put: AeFontWeight medium;
		at: BlFontWeight semiBold put: AeFontWeight semiBold;
		at: BlFontWeight bold put: AeFontWeight bold;
		at: BlFontWeight extraBold put: AeFontWeight extraBold;
		at: BlFontWeight black put: AeFontWeight black;
		yourself
]
