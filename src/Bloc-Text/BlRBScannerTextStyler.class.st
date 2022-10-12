Class {
	#name : #BlRBScannerTextStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'parentheseLevel',
		'bracketLevel',
		'isForWorkspace',
		'workspace',
		'fontName',
		'classOrMetaClass'
	],
	#classInstVars : [
		'styleTable',
		'textAttributes'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #private }
BlRBScannerTextStyler class >> attributeArrayForColor: aColorOrNil emphasis: anEmphasisArray [
	"Return a collection of text or font attributes for given color (or nil)
	and array of requested emphasis styles (#bold, #italic, #oblique or #normal)"
	<return: #Array of: #BlTextAttribute>

	^ Array streamContents: [ :aStream |
		aColorOrNil ifNotNil: [ :aColor |
			aStream nextPut: (self foregroundAttribute: aColor) ].
		anEmphasisArray do: [ :anEmphasis | aStream nextPut: (self emphasisAttribute: anEmphasis) ] ]
]

{ #category : #private }
BlRBScannerTextStyler class >> attributesFor: aSymbol [
	"Return a collection of text or font attributes for a given style name"
	
	"self attributesFor: #default"
	<return: #Array of: #BlTextAttribute>
	
	^ self textAttributes
		at: aSymbol
		ifAbsent: [ #() ]
]

{ #category : #'style tables' }
BlRBScannerTextStyler class >> blueStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to
	use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used.
	if pixel height is not specified , then the editor font size will be used.
	"
	<styleTable: 'Blue'>
								
			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])" 
 ^ #(
			(default 								black)
			(invalid 								red)
			(excessCode 							red)
			
			(comment 								(gray darker))
			(unfinishedComment 				(red muchDarker))
			
			(#'$' 									(red muchDarker))
			(character 								(red muchDarker))
			(integer 								(red muchDarker))
			(number 								(red muchDarker)) 
			(#- 										(red muchDarker))
			(symbol 								(magenta muchDarker)) 
			(stringSymbol 							(magenta muchDarker)) 
			(literalArray 							(magenta muchDarker))
			(string 									(magenta muchDarker) normal)										
			(unfinishedString 						red normal)
	
			(assignment 							(red muchDarker))
			(ansiAssignment 					(red muchDarker))
	
			(literal 									nil italic)
			(keyword 								(black))
			(binary 									(black)) 
			(unary 									(black))
										
			(#self 									(cyan muchDarker ))
			(#super 								(cyan muchDarker ))
			(#true 									(red muchDarker))
			(#false 									(red muchDarker))
			(#nil 									(red muchDarker))
			(#thisContext 							(cyan muchDarker ))
			(#return 								(cyan muchDarker ) bold)
			(patternArg 							(blue muchDarker)) 
			(methodArg 							(blue muchDarker))
			(blockPatternArg 						(blue muchDarker))
			(blockArg 								(blue muchDarker))
			(argument 								(blue muchDarker))
			(blockTempVar 						(blue muchDarker))
			(blockPatternTempVar 					(blue muchDarker))
			(instVar 								(blue muchDarker))
			(workspaceVar 							(blue muchDarker))
		
			(tempVar 								(blue muchDarker))
			(patternTempVar 						(blue muchDarker))
			(poolConstant 							(blue muchDarker))
			(classVar 								(blue muchDarker))
			(globalVar 								(blue muchDarker))
												
			(identifier 								(blue muchDarker))
			(incompleteIdentifier 				blue italic)
			(incompleteKeyword 					nil  italic)
			(incompleteBinary 						nil  italic) 
			(incompleteUnary 						nil  italic)					
				
			(undefinedIdentifier 					red)						
			(undefinedKeyword 					red)
			(undefinedBinary 						red) 
			(undefinedUnary 						red) 
	
			(patternKeyword 						nil bold)
			(patternBinary 							nil bold)
			(patternUnary 							nil bold) 
			(blockArgColon 						black)
			(leftParenthesis 						black)
			(rightParenthesis 						black)
			(leftParenthesis1 						(green muchDarker))
			(rightParenthesis1 						(green muchDarker))
			(leftParenthesis2 						(magenta muchDarker))
			(rightParenthesis2 						(magenta muchDarker))
			(leftParenthesis3 						(red muchDarker))
			(rightParenthesis3 						(red muchDarker))
			(leftParenthesis4 						(green darker))
			(rightParenthesis4 						(green darker))
			(leftParenthesis5 						(orange darker))
			(rightParenthesis5 						(orange darker))
			(leftParenthesis6 						(magenta darker))
			(rightParenthesis6 						(magenta darker))
			(leftParenthesis7 						blue)
			(rightParenthesis7 						blue)
			(blockStart 								black)
			(blockEnd 								black)
			(blockStart1 							(green muchDarker))
			(blockEnd1 								(green muchDarker))
			(blockStart2 							(magenta muchDarker))
			(blockEnd2 								(magenta muchDarker))
			(blockStart3 							(red muchDarker))
			(blockEnd3 								(red muchDarker))
			(blockStart4 							(green darker))
			(blockEnd4 								(green darker))
			(blockStart5 							(orange darker))
			(blockEnd5 								(orange darker))
			(blockStart6 							(magenta darker))
			(blockEnd6 								(magenta darker))
			(blockStart7 							blue)
			(blockEnd7 								blue) 
			(arrayStart 								black)
			(arrayEnd 								black)
			(arrayStart1 							black)
			(arrayEnd1 								black)
			(leftBrace 								black)
			(rightBrace 								black)
			(cascadeSeparator 					black)
			(statementSeparator 					black)
			(methodTempBar 						(black))
			(blockTempBar 						(black))
			(blockArgsBar 							(black))
										
			(externalCallType 						black)
			(externalCallTypePointerIndicator 		black)
			(primitiveOrExternalCallStart 			black bold)
			(primitiveOrExternalCallEnd 			black bold)
			(primitive 								(green muchDarker))
			(pragmaKeyword 						(green muchDarker))
			(pragmaUnary 							(green muchDarker))
			(pragmaBinary 							(green muchDarker)) 
			(externalFunctionCallingConvention 	(green muchDarker) bold)
			(module 								(green muchDarker) bold))
]

{ #category : #'style tables' }
BlRBScannerTextStyler class >> defaultStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used."
	<return: #Array>
	^ self blueStyleTable
]

{ #category : #attributes }
BlRBScannerTextStyler class >> emphasisAttribute: anEmphasisAsSymbol [
	"Create and return a text emphasis attribute for a given emphasis.
	anEmphasisAsSymbol can be either #bold #italic #oblique or #normal"
	<return: #BlTextAttribute>
	
	anEmphasisAsSymbol = #bold
		ifTrue: [ ^ BlFontWeightAttribute bold ].
	
	anEmphasisAsSymbol = #italic
		ifTrue: [ ^ BlFontEmphasisAttribute italic ].
		
	anEmphasisAsSymbol = #oblique
		ifTrue: [ ^ BlFontEmphasisAttribute oblique ].
		
	anEmphasisAsSymbol = #normal
		ifTrue: [ ^ BlFontEmphasisAttribute normal ].
	
	anEmphasisAsSymbol = #light
		ifTrue: [ ^ BlFontWeightAttribute light ].

	self error: 'Unknown emphasis: ', anEmphasisAsSymbol asString
]

{ #category : #attributes }
BlRBScannerTextStyler class >> foregroundAttribute: aPaint [
	"Create and return a text foreground attribute for a given paint.
	aPaint can be a color, gradient or any other object that represents a paint
	and is polymorphic with a canvas-specific paint or that knows how to convert
	itself to an actual paint using double dispatch (e.g. asSpartaPaintOn:)"
	<return: #BlTextForegroundAttribute>

	^ BlTextForegroundAttribute paint: aPaint
]

{ #category : #private }
BlRBScannerTextStyler class >> hasAttributesFor: aSymbol [
	"Return true if I have attributes for a given style name"
	
	"self hasAttributesFor: #default"
	<return: #Boolean>
	
	^ self textAttributes includesKey: aSymbol
]

{ #category : #initialization }
BlRBScannerTextStyler class >> initialTextAttributes [
	| theAttributes |

	theAttributes := IdentityDictionary new.

	self styleTable do: [ :aStyleRow |
		| aStyle emphasis attrArray color |

		aStyle := aStyleRow first.
		color := Color colorFrom: (aStyleRow at: 2 ifAbsent: [ nil ]).
		emphasis := (Array with: (aStyleRow at: 3 ifAbsent: [ #normal ])) flattened.

		attrArray := self
			attributeArrayForColor: color
			emphasis: emphasis.

		theAttributes at: aStyle put: attrArray ].

	^ theAttributes
]

{ #category : #initialization }
BlRBScannerTextStyler class >> initialize [
	"self initialize"
	styleTable := nil.
	textAttributes := nil.
]

{ #category : #accessing }
BlRBScannerTextStyler class >> styleTable [
	"Return a style table used by default by all stylers"
	<return: #Array>

	^ styleTable ifNil: [ styleTable := self defaultStyleTable ]
]

{ #category : #accessing }
BlRBScannerTextStyler class >> textAttributes [
	"Return a dictionary of text attributes as assocciations of style name and an array of attributes"
	<return: #Dictionary>

	^ textAttributes ifNil: [ textAttributes := self initialTextAttributes ]
]

{ #category : #adding }
BlRBScannerTextStyler >> addAttributes: attributes from: start to: stop [

	text isEmpty ifTrue: [ ^ self ].
	text attributes: attributes from: start to: stop
]

{ #category : #adding }
BlRBScannerTextStyler >> addStyle: aSymbol forToken: aToken [
	"Style a piece of text from aStart to anEnd for a provided style name"

	self
		addAttributes: (self attributesFor: aSymbol)
		from: aToken start
		to: aToken stop
]

{ #category : #adding }
BlRBScannerTextStyler >> addStyle: aStyleSymbol from: aStart to: anEnd [
	"Style a piece of text from aStart to anEnd for a provided style name"

	self
		addAttributes: (self attributesFor: aStyleSymbol)
		from: aStart
		to: anEnd
]

{ #category : #adding }
BlRBScannerTextStyler >> addStyleForToken: aToken [
	"Style a piece of text from aStart to anEnd for a provided style name"

	self
		addAttributes: (self attributesFor: aToken value asSymbol)
		from: aToken start
		to: aToken stop
]

{ #category : #private }
BlRBScannerTextStyler >> attributesFor: aSymbol [
	"Return a collection of text attributes for a given name"
	<return: #Array>

	^ self class attributesFor: aSymbol
]

{ #category : #accessing }
BlRBScannerTextStyler >> classOrMetaClass: aBehavior [

	classOrMetaClass = aBehavior ifTrue: [ ^ self ].
	classOrMetaClass := aBehavior.
	self announceStateChanged
]

{ #category : #accessing }
BlRBScannerTextStyler >> fontName: aFontName [

	fontName = aFontName ifTrue: [ ^ self ].
	fontName := aFontName.
	self announceStateChanged
]

{ #category : #testing }
BlRBScannerTextStyler >> hasAttributesFor: aSymbol [

	^ self class hasAttributesFor: aSymbol
]

{ #category : #accessing }
BlRBScannerTextStyler >> isForWorkspace: aBoolean [

	isForWorkspace = aBoolean ifTrue: [ ^self ].
	isForWorkspace := aBoolean.
	self announceStateChanged
]

{ #category : #private }
BlRBScannerTextStyler >> privateStyle: aText [

	| tokens |
	text := aText.
	text attributes: (self attributesFor: #default).
	bracketLevel := 0.
	parentheseLevel := 0.
	[ 
	| scanner |
	scanner := RBScanner
		           on: text readStream
		           errorBlock: [ :str :pos :sca | 
			           'nothing to do'
			           "'*****' traceCr.
			           str traceCr.
			           ('Scanner error at ' , pos asString) traceCr.
			           '*****' traceCr" ].
	tokens := scanner contents.
	tokens do: [ :t | self visit: t ].
	fontName ifNotNil: [ text fontName: fontName ] ] ensure: [ 
		text := nil ].
	^ aText
]

{ #category : #visiting }
BlRBScannerTextStyler >> styleCloseOpen: aSymbol token: aToken [

	| selector |
	aSymbol = #'[' ifTrue: [ 
		selector := #blockStart.
		selector := selector , bracketLevel asString.
		bracketLevel := bracketLevel + 1 ].
	aSymbol = #']' ifTrue: [ 
		selector := #blockEnd.
		bracketLevel := bracketLevel - 1.
		selector := selector , bracketLevel asString ].
	aSymbol = #'(' ifTrue: [ 
		selector := #leftParenthesis.
		selector := selector , parentheseLevel asString.
		parentheseLevel := parentheseLevel + 1 ].
	aSymbol = #')' ifTrue: [ 
		selector := 'rightParenthesis'.
		parentheseLevel := parentheseLevel - 1.
		selector := selector , parentheseLevel asString ].
	^ self addStyle: selector asSymbol forToken: aToken
]

{ #category : #private }
BlRBScannerTextStyler >> visit: aToken [

	aToken comments ifNotNil: [ 
		aToken comments do: [ :comment | self addStyle: #comment from: comment start to: comment stop ] ].

	^ aToken acceptVisitor: self
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitAssignmentToken: aToken [

	self visitToken: aToken.
	self addStyle: #assignment forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitBinarySelectorToken: aToken [

	self visitToken: aToken.
	self addStyle: #keyword forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitCommentToken: aToken [

	self addStyle: #comment forToken: aToken
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitEOFToken: aToken [

	self visitToken: aToken.
	self addStyle: #invalid forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitErrorToken: aToken [

	self visitToken: aToken.
	self addStyle: #invalid forToken: aToken
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitIdentifierToken: aToken [

	self visitToken: aToken.
	(self hasAttributesFor: aToken value asSymbol)
		ifTrue: [ self addStyle: aToken value asSymbol forToken: aToken ]
		ifFalse: [ self addStyle: #default forToken: aToken ]
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitKeywordToken: aToken [

	self visitToken: aToken.
	self addStyle: #keyword forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitLiteralArrayToken: aToken [

	self visitToken: aToken.
	^ self styleCloseOpen: #'(' token: aToken
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitLiteralToken: aToken [

	| value |
	self visitToken: aToken.
	value := aToken value.
	value isSymbol ifTrue: [ 
		(value isValidSelector and: [ value ~~ #'||' ])
			ifTrue: [ ^ self addStyle: #literal forToken: aToken ]
			ifFalse: [ ^ self addStyle: #keyword forToken: aToken ].
		^ self ].
	value class == Character ifTrue: [ 
		^ self addStyle: #character forToken: aToken ].
	((value isKindOf: Boolean) or: [ value isNil ]) ifTrue: [ 
		^ self addStyle: #true forToken: aToken ].

	aToken value first = $' ifTrue: [ 
		self addStyle: #string forToken: aToken ].
	self addStyle: #literal forToken: aToken
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitMultiKeywordLiteralToken: aToken [

	self visitToken: aToken.
	self addStyle: #invalid forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitNumberLiteralToken: aToken [

	self visitToken: aToken.
	self addStyle: #number forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitPatternBlockToken: aToken [

	self visitToken: aToken.
	self addStyle: #patternTempVar forToken: aToken
	
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitSpecialCharacterToken: aToken [

	| v |
	self visitToken: aToken.
	v := aToken value asSymbol.
	(#( #'(' #')' #'[' #']' ) includes: v) ifTrue: [ ^ self styleCloseOpen: v token: aToken ].
	(self hasAttributesFor: aToken value asSymbol)
		ifTrue: [ self addStyle: aToken value asSymbol forToken: aToken ]
		ifFalse: [ self addStyle: #literalArray forToken: aToken ]
]

{ #category : #visiting }
BlRBScannerTextStyler >> visitToken: aToken [
	aToken comments ifNotNil: [ 
		aToken comments do: [ :comment | self addStyle: #comment from: comment start to: comment stop ] ].

]

{ #category : #accessing }
BlRBScannerTextStyler >> workspace: aWorkspace [

	workspace = aWorkspace ifTrue: [ ^ self ].
	workspace := aWorkspace.
	self announceStateChanged
]
