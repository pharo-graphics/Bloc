Class {
	#name : #EightBitFormExperiment,
	#superclass : #Object,
	#instVars : [
		'sprite'
	],
	#category : #'BookletGraphicsBloc-Form'
}

{ #category : #accessing }
EightBitFormExperiment >> eightBitColorWithBitmap [
<bookExample>
	| bitmap array |
	array := ByteArray new: 256.
	16r0 to: 16rff do: [ :i | array at: i + 1 put: i ].
	array := (array groupsOf: 4) collect: [ :each | each asInteger ].

	"bitmap contain 256/8 = 64 items"
	bitmap := Bitmap new: 64.
	1 to: 64 do: [ :i | bitmap at: i put: (array at: i) ].

	"either a 64 line of 4 color (*8 to reach 32 bits)"
	Form extent: 4 @ 64 depth: 8 bits: bitmap.
	"or a square of 16 lines composed of 4 color (to get 32 bits) * 4 time"
	^ (Form extent: 16 @ 16 depth: 8 bits: bitmap) magnifyBy: self magnifyFactor 
]

{ #category : #accessing }
EightBitFormExperiment >> eightBitColorWithoutBitmap [
<bookExample>
	| array |
	array := ByteArray new: 256.

	16r0 to: 16rff do: [ :i | array at: i + 1 put: i ].

	^(Form extent: 4 @ 64 depth: 8) initFromArray:
		((array groupsOf: 4) collect: [ :each | each asInteger ]); magnifyBy: self magnifyFactor 
	
]

{ #category : #accessing }
EightBitFormExperiment >> helloWorldInBitmap [
<bookExample>
	^ (Form extent: 4 @ 3 depth: 8) initFromArray:
		  (('Hello world!' asByteArray groupsOf: 4) collect: [ :each | 
			   each asInteger ]); magnifyBy: self magnifyFactor 
]

{ #category : #initialization }
EightBitFormExperiment >> magnifyFactor [
	^ 15
]
