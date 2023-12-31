"
I'm the one who visits node to coloring the code
"
Class {
	#name : #BlRBTextStyler,
	#superclass : #BlTextStyler,
	#traits : 'TRBProgramNodeVisitor',
	#classTraits : 'TRBProgramNodeVisitor classTrait',
	#instVars : [
		'parentheseLevel',
		'bracketLevel',
		'classOrMetaClass',
		'isForWorkspace',
		'workspace',
		'fontName'
	],
	#classInstVars : [
		'styleTable',
		'textAttributes'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #private }
BlRBTextStyler class >> attributeArrayForColor: aColorOrNil emphasis: anEmphasisArray [
	"Return a collection of text or font attributes for given color (or nil)
	and array of requested emphasis styles (#bold, #italic, #oblique or #normal)"
	<return: #Array of: #BlTextAttribute>

	^ Array streamContents: [ :aStream |
		aColorOrNil ifNotNil: [ :aColor |
			aStream nextPut: (self foregroundAttribute: aColor) ].
		anEmphasisArray do: [ :anEmphasis | aStream nextPut: (self emphasisAttribute: anEmphasis) ] ]
]

{ #category : #private }
BlRBTextStyler class >> attributesFor: aSymbol [
	"Return a collection of text or font attributes for a given style name"
	
	"self attributesFor: #default"
	<return: #Array of: #BlTextAttribute>
	
	^ self textAttributes
		at: aSymbol
		ifAbsent: [ #() ]
]

{ #category : #'style tables' }
BlRBTextStyler class >> blueStyleTable [
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
			(invalid 									red)
			(excessCode 							red)
			
			(comment 								(gray darker))
			(unfinishedComment 					(red muchDarker))
			
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
	
			(assignment 							nil)
			(ansiAssignment 						nil)
	
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
												
			(incompleteIdentifier 					blue italic)
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

{ #category : #cleanup }
BlRBTextStyler class >> cleanUp [
	super cleanUp.

	styleTable := nil.
	textAttributes := nil.
]

{ #category : #'style tables' }
BlRBTextStyler class >> darkStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to
	use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used.
	if pixel height is not specified , then the editor font size will be used.
	
	This style is inspired on darkula theme from eclipse: http://eclipsecolorthemes.org/?view=theme&id=15515.  
	"
	<styleTable: 'Dark'>

 ^ #(
			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])" 
			(default 								white)
			(invalid 								red)
			(excessCode 							red)
			
			(comment 								'7D8C93')
			(unfinishedComment 				red)
			
			(#'$' 									('E38C1E' lighter))
			(character 							('E38C1E' lighter))
			(integer 								('FFE54B'))
			(number 								('FFE54B'))
			(#- 									('FFE54B'))
			(symbol 								('E38C1E')) 
			(stringSymbol 						('E38C1E')) 
			(literalArray 						white)
			(string 								('E38C1E'))
												
			(unfinishedString 					red normal)
			(assignment 							nil bold)
			(ansiAssignment 					nil bold)
										
			(literal 								nil italic)
												
			(keyword 								white)
			(binary 								white) 
			(unary 								white)
										
			(#true 								('00CC6E' darker))
			(#false 								('00CC6E' darker))
			(#nil 									('00CC6E' darker))
													
			(#self 								'00CC6E')
			(#super								'00CC6E')
			(#thisContext 						'00CC6E')
			(#return 								'00CC6E' bold)
												
			(patternArg 							'A7E2ED') 
			(methodArg 							'A7E2ED')
			(blockPatternArg 					'A7E2ED' italic)
			(blockArg 							'A7E2ED' italic)
			(argument 							'A7E2ED')
			(blockTempVar 						'A7E2ED')
			(blockPatternTempVar 				'A7E2ED')
								
			(instVar 								'A7E2ED')
			(workspaceVar 						'A7E2ED' bold)
										
			(tempVar 								'A7E2ED')
			(patternTempVar 					'A7E2ED')
										
			(poolConstant 						'A7E2ED' bold)
			(classVar 							'A7E2ED' bold)
			(globalVar 							white bold)
												
		
			(incompleteIdentifier 			'E8E2B7' italic)
			(incompleteKeyword 				'E8E2B7' italic)
			(incompleteBinary 					'E8E2B7' italic) 
			(incompleteUnary 					'E8E2B7' italic)
				
			(undefinedIdentifier 				red)						
			(undefinedKeyword 					red)
			(undefinedBinary 					red) 
			(undefinedUnary 					red) 
			
			(patternKeyword 					nil bold)
			(patternBinary 						nil bold)
			(patternUnary 						nil bold) 
			(blockArgColon 						white)
			(leftParenthesis 					white)
			(rightParenthesis 					white)
			(leftParenthesis1 					(green muchLighter))
			(rightParenthesis1 				(green muchLighter))
			(leftParenthesis2 					(magenta muchLighter))
			(rightParenthesis2 				(magenta muchLighter))
			(leftParenthesis3 					(red muchLighter))
			(rightParenthesis3 				(red muchLighter))
			(leftParenthesis4 					(green lighter))
			(rightParenthesis4 				(green lighter))
			(leftParenthesis5 					(orange lighter))
			(rightParenthesis5 				(orange lighter))
			(leftParenthesis6 					(magenta lighter))
			(rightParenthesis6 				(magenta lighter))
			(leftParenthesis7 					blue)
			(rightParenthesis7 				blue)
			(blockStart 							white)
			(blockEnd 							white)
			(blockStart1 						(green muchLighter))
			(blockEnd1 							(green muchLighter))
			(blockStart2 						(magenta muchLighter))
			(blockEnd2 							(magenta muchLighter))
			(blockStart3 						(red muchLighter))
			(blockEnd3 							(red muchLighter))
			(blockStart4 						(green lighter))
			(blockEnd4 							(green lighter))
			(blockStart5 						(orange lighter))
			(blockEnd5 							(orange lighter))
			(blockStart6 						(magenta lighter))
			(blockEnd6 							(magenta lighter))
			(blockStart7 						blue)
			(blockEnd7 							blue) 
			(arrayStart 							white)
			(arrayEnd 							white)
			(arrayStart1 						white)
			(arrayEnd1 							white)
			(leftBrace 							white)
			(rightBrace 							white)
			(cascadeSeparator 					white bold)
			(statementSeparator 				white bold)
			(methodTempBar 						white)
			(blockTempBar 						white)
			(blockArgsBar 						white)
										
			(externalCallType 								white)
			(externalCallTypePointerIndicator 		white)
			(primitiveOrExternalCallStart 				white bold)
			(primitiveOrExternalCallEnd 				white bold)
			(primitive 										'B4DD6E')
			(pragmaKeyword 									'B4DD6E')
			(pragmaUnary 									'B4DD6E')
			(pragmaBinary 									'B4DD6E') 
			(externalFunctionCallingConvention 		'B4DD6E' bold)
			(module 											'B4DD6E' bold))
]

{ #category : #'style tables' }
BlRBTextStyler class >> defaultStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used."
	<return: #Array>
	^ self blueStyleTable
]

{ #category : #attributes }
BlRBTextStyler class >> emphasisAttribute: anEmphasisAsSymbol [
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
BlRBTextStyler class >> foregroundAttribute: aPaint [
	"Create and return a text foreground attribute for a given paint.
	aPaint can be a color, gradient or any other object that represents a paint
	and is polymorphic with a canvas-specific paint or that knows how to convert
	itself to an actual paint using double dispatch."

	^ BlTextForegroundAttribute paint: aPaint
]

{ #category : #initialization }
BlRBTextStyler class >> initialTextAttributes [
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
BlRBTextStyler class >> initialize [
	"self initialize"
	styleTable := nil.
	textAttributes := nil.
]

{ #category : #accessing }
BlRBTextStyler class >> styleTable [
	"Return a style table used by default by all stylers"
	<return: #Array>

	^ styleTable ifNil: [ styleTable := self defaultStyleTable ]
]

{ #category : #accessing }
BlRBTextStyler class >> styleTable: anArray [ 
	"Set a style table that should be used by default by text stylers"

	styleTable := anArray.
	textAttributes := nil
]

{ #category : #'style tables' }
BlRBTextStyler class >> tangoStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to
	use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used.
	if pixel height is not specified , then the editor font size will be used.
	
	This is a syntax coloring scheme based on the tango desktop icon scheme:
	http://tango.freedesktop.org/Tango_Icon_Theme_Guidelines
	"
	<styleTable: 'Tango'>
								
 ^ #(
			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])" 
			(default 								black)
			(invalid 									red)
			(excessCode 							red)
			
			(comment 								'888a85')
			(unfinishedComment 					(red muchDarker))
			
			(#'$' 									'ce5c00')
			(character 								'ce5c00')
			(integer 								'8f5902')
			(number 								'8f5902')
			(#- 										'8f5902')
			(symbol 								'c4a000') 
			(stringSymbol 							'c4a000') 
			(literalArray 							black)
			(string 									'ce5c00')
												
			(unfinishedString 						red normal)
			(assignment 							nil)
			(ansiAssignment 						nil)
										
			(literal 									'8F5902')
												
			(keyword 								(black))
			(binary 									(black)) 
			(unary 									(black))
										
			(#true 									'8F5902')
			(#false 									'8F5902')
			(#nil 									'8F5902')
													
			(#self 									'4d9a06')
			(#super 								'4d9a06')
			(#thisContext 							'4d9a06')
			(#return 								black bold)
												
			(patternArg 							'2e3426' italic) 
			(methodArg 							'555753' italic)
			(blockPatternArg 						'888a85' bold)
			(blockArg 								'555753' italic)
			(argument 								'555753' italic)
			(blockTempVar 						'555753' italic)
			(blockPatternTempVar 					'888a85' italic)
								
			(instVar 								'204a87')
			(workspaceVar 							'204a87')
										
			(tempVar 								'555753' italic)
			(patternTempVar 						'888a85' italic)
										
			(poolConstant 							'ad7fa8' bold)
			(classVar 								'ad7fa8' bold)
			(globalVar 								'5c3566' bold)
												
			
			(incompleteIdentifier 					blue italic)
			(incompleteKeyword 					blue italic)
			(incompleteBinary 						blue italic) 
			(incompleteUnary 						blue italic)
									
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
			(methodTempBar 						black)
			(blockTempBar 						black)
			(blockArgsBar 							black)
										
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

{ #category : #accessing }
BlRBTextStyler class >> textAttributes [
	"Return a dictionary of text attributes as assocciations of style name and an array of attributes"
	<return: #Dictionary>

	^ textAttributes ifNil: [ textAttributes := self initialTextAttributes ]
]

{ #category : #'style tables' }
BlRBTextStyler class >> vintageStyleTable [
	"color can be a valid argument to Color class>>colorFrom: , or nil to
	use the editor text color.
	Multiple emphases can be specified using an array e.g. #(bold italic).
	If emphasis is not specified, #normal will be used.
	if pixel height is not specified , then the editor font size will be used.
	
	This style is based on old theme and other old environments.  
	"
	<styleTable: 'Vintage'>
								
 ^ #(
			"(symbol color [emphasisSymbolOrArray [textStyleName [pixelHeight]]])" 
			(default 								black)
			(invalid 									red)
			(excessCode 							red)
			
			(comment 								'006400')
			(unfinishedComment 					(red muchDarker))
			
			(#'$' 									('801f91' lighter))
			(character 								('801f91' lighter))
			(integer 								('801f91'))
			(number 								('801f91'))
			(#- 										('801f91'))
			(symbol 								('801f91')) 
			(stringSymbol 							('801f91')) 
			(literalArray 							black)
			(string 									('801f91'))
												
			(unfinishedString 						red normal)
			(assignment 							nil bold)
			(ansiAssignment 						nil bold)
										
			(literal 									nil italic)
												
			(keyword 								black)
			(binary 									black) 
			(unary 									black)
										
			(#true 									('A31515' darker))
			(#false 									('A31515' darker))
			(#nil 									('A31515' darker))
													
			(#self 									'A31515')
			(#super								'A31515')
			(#thisContext 							'A31515')
			(#return 								'A31515' bold)
												
			(patternArg 							(blue muchDarker)) 
			(methodArg 							(blue muchDarker))
			(blockPatternArg 						(blue muchDarker))
			(blockArg 								(blue muchDarker))
			(argument 								(blue muchDarker))
			(blockTempVar 						(blue muchDarker))
			(blockPatternTempVar 					(blue muchDarker))
								
			(instVar 								(blue muchDarker))
			(workspaceVar 							(blue muchDarker) bold)
										
			(tempVar 								(blue muchDarker))
			(patternTempVar 						(blue muchDarker))
										
			(poolConstant 							(blue muchDarker) bold)
			(classVar 								(blue muchDarker) bold)
			(globalVar 								black bold)
												
		
			(incompleteIdentifier 					blue italic)
			(incompleteKeyword 					blue italic)
			(incompleteBinary 						blue italic) 
			(incompleteUnary 						blue italic)
				
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
			(cascadeSeparator 					black bold)
			(statementSeparator 					black bold)
			(methodTempBar 						black)
			(blockTempBar 						black)
			(blockArgsBar 							black)
										
			(externalCallType 						black)
			(externalCallTypePointerIndicator 		black)
			(primitiveOrExternalCallStart 			black bold)
			(primitiveOrExternalCallEnd 			black bold)
			(primitive 								(cyan muchDarker))
			(pragmaKeyword 						(cyan muchDarker))
			(pragmaUnary 							(cyan muchDarker))
			(pragmaBinary 							(cyan muchDarker)) 
			(externalFunctionCallingConvention 	(cyan muchDarker) bold)
			(module 								(cyan muchDarker) bold))
]

{ #category : #formatting }
BlRBTextStyler >> addAttributes: attributes forNode: anRBNode [
	
	"RB bug?"
	(anRBNode start > anRBNode stop)
		ifTrue: [ ^ self ].
	
	self 
		addAttributes: attributes
		from: anRBNode start
		to: anRBNode stop
]

{ #category : #formatting }
BlRBTextStyler >> addAttributes: attributes from: start to: stop [
	text isEmpty
		ifTrue: [ ^ self ].
	
	
	text attributes: attributes
		from: start
		to: stop
]

{ #category : #converting }
BlRBTextStyler >> addAttributesFrom: attributeRuns satisfying: aTestBlock to: aText [

	attributeRuns withStartStopAndValueDo: [:start :stop :attributes | 
		attributes 
			select: aTestBlock 
			thenDo: [ :selectedAttribute| 
				aText
					addAttribute: selectedAttribute
					from: start
					to: stop ]].
		
	^ aText
]

{ #category : #formatting }
BlRBTextStyler >> addStyle: styleSymbol attribute: additionalAttribute forNode: anRBNode [

	self 
		addStyle:styleSymbol
		attributes: { additionalAttribute }
		forNode: anRBNode.
]

{ #category : #formatting }
BlRBTextStyler >> addStyle: styleSymbol attribute: additionalAttribute from: start to: end [

	self
		addAttributes: (self attributesFor: styleSymbol), {additionalAttribute}
		from: start
		to: end
]

{ #category : #formatting }
BlRBTextStyler >> addStyle: styleSymbol attributes: additionalAttributes forNode: anRBNode [

	self 
		addAttributes: (self attributesFor: styleSymbol), additionalAttributes 
		forNode: anRBNode
]

{ #category : #formatting }
BlRBTextStyler >> addStyle: styleSymbol forNode: anRBNode [
	"Style a piece of text that represents a given node for a provided style name"

	self
		addAttributes: (self attributesFor: styleSymbol)
		forNode: anRBNode
]

{ #category : #formatting }
BlRBTextStyler >> addStyle: aStyleSymbol from: aStart to: anEnd [
	"Style a piece of text from aStart to anEnd for a provided style name"

	self
		addAttributes: (self attributesFor: aStyleSymbol)
		from: aStart
		to: anEnd
]

{ #category : #private }
BlRBTextStyler >> attributesFor: aSymbol [
	"Return a collection of text attributes for a given name"
	<return: #Array>

	^ self class attributesFor: aSymbol
]

{ #category : #accessing }
BlRBTextStyler >> classOrMetaClass: aBehavior [

	classOrMetaClass = aBehavior ifTrue: [ ^ self ].
	classOrMetaClass := aBehavior.
	self announceStateChanged
]

{ #category : #private }
BlRBTextStyler >> currentClosedBracketStyleName [
	bracketLevel isZero ifTrue: [ ^ #blockEnd ].
	^ (#blockEnd asString , bracketLevel asString) asSymbol
]

{ #category : #private }
BlRBTextStyler >> currentClosedParenthesisStyleName [
	parentheseLevel isZero ifTrue: [ ^ #rightParenthesis ].
	^ (#rightParenthesis asString , parentheseLevel asString) asSymbol
]

{ #category : #private }
BlRBTextStyler >> currentOpenedBracketStyleName [
	bracketLevel isZero ifTrue: [ ^ #blockStart ].
	^ (#blockStart asString , bracketLevel asString) asSymbol
]

{ #category : #private }
BlRBTextStyler >> currentOpenedParenthesisStyleName [
	parentheseLevel isZero ifTrue: [ ^ #leftParenthesis ].
	^ (#leftParenthesis asString , parentheseLevel asString) asSymbol
]

{ #category : #accessing }
BlRBTextStyler >> fontName [

	^ fontName
]

{ #category : #accessing }
BlRBTextStyler >> fontName: aFontName [

	fontName = aFontName ifTrue: [ ^ self ].
	fontName := aFontName.
	self announceStateChanged
]

{ #category : #accessing }
BlRBTextStyler >> isForWorkspace [
	^ isForWorkspace ifNil: [ workspace notNil ]
]

{ #category : #accessing }
BlRBTextStyler >> isForWorkspace: aBoolean [

	isForWorkspace = aBoolean ifTrue: [ ^self ].
	isForWorkspace := aBoolean.
	self announceStateChanged
]

{ #category : #formatting }
BlRBTextStyler >> literalStyleSymbol: aValue [
	aValue isSymbol
		ifTrue: [ ^ #symbol ].
	aValue isString
		ifTrue: [ ^ #string ].
	aValue isCharacter
		ifTrue: [ ^ #character ].
	aValue isNumber
		ifTrue: [ ^ #number ].
	aValue == true
		ifTrue: [ ^ #true ].
	aValue == false
		ifTrue: [ ^ #false ].
	aValue isNil
		ifTrue: [ ^ #nil ].
	^ #default
]

{ #category : #private }
BlRBTextStyler >> methodOrBlockArgStyleFor: anArgumentNode [
	^ anArgumentNode isDefinedByBlock
		ifTrue: [ #blockArg ]
		ifFalse: [ #methodArg ]
]

{ #category : #private }
BlRBTextStyler >> methodOrBlockTempDeclStyleFor: aSequenceNode [
	^ aSequenceNode scope isBlockScope
		ifTrue: [ #blockPatternTempVar ]
		ifFalse: [ #patternTempVar ]
]

{ #category : #private }
BlRBTextStyler >> methodOrBlockTempStyleFor: aTemporaryNode [

	^ aTemporaryNode isDefinedByBlock
		  ifTrue: [ #blockTempVar ]
		  ifFalse: [ #tempVar ]
]

{ #category : #private }
BlRBTextStyler >> parse: aText isMethod: isMethod [
	|root aString |
	
	aString := aText asString.
	
	isMethod 
		ifTrue: [
			[root := RBParser parseFaultyMethod: aString.
			root methodNode methodClass: classOrMetaClass.
			^root] 
				on: Error 
				do: [^RBParser parseFaultyExpression: aString ]]
		ifFalse:[ ^RBParser parseFaultyExpression: aString ].
]

{ #category : #private }
BlRBTextStyler >> privateStyle: aText [

	| ast compiler |
	compiler := self isForWorkspace
		            ifTrue: [
			            OpalCompiler new
				            context: thisContext;
				            yourself ]
		            ifFalse: [ classOrMetaClass compiler ].
	ast := compiler
		       source: aText asString;
		       "isScripting: self isForWorkspace;"
		       options:
			       #( #+ optionParseErrors #+ optionSkipSemanticWarnings );
		       requestor: workspace;
		       bindings: (workspace
				        ifNotNil: [ workspace bindings ]
				        ifNil: [ SystemDictionary new ]);
		       parse.
	self style: aText ast: ast.
	fontName ifNotNil: [ aText fontName: fontName ].
	^ aText
]

{ #category : #private }
BlRBTextStyler >> privateStyle_my: aText [

	| ast compiler |
	compiler := self isForWorkspace
		            ifTrue: [ 
			            OpalCompiler new
				            context: thisContext;
				            yourself ]
		            ifFalse: [ classOrMetaClass compiler ].
	ast := compiler
		       source: aText asString;
		       noPattern: self isForWorkspace;
		       options:
			       #( + optionParseErrors + optionSkipSemanticWarnings );
		       requestor: workspace;
		       bindings: (workspace
				        ifNotNil: [ workspace bindings ]
				        ifNil: [ SystemDictionary new ]);
		       parse.
	self style: aText ast: ast.
	fontName ifNotNil: [ aText fontName: fontName ].
	^ aText
]

{ #category : #private }
BlRBTextStyler >> privateStyle_orig: aText [

	| ast |
	ast := self parse: aText isMethod: self isForWorkspace not.
	ast methodNode compilationContext: (CompilationContext new
			 class: (classOrMetaClass ifNil: [ UndefinedObject ]);
			 requestor: workspace).
	"Requestor already has support for obtaining the bindings. 
				Adding both the requestor and the bindings creates two scopes
				that are used for looking up variables."
	"bindings: (workspace ifNil: [ Dictionary new ]);"
	ast doSemanticAnalysis.

	fontName ifNotNil: [ aText fontName: fontName ].
	self style: aText ast: ast.
	^ aText
]

{ #category : #private }
BlRBTextStyler >> resolveStyleFor: aVariableNode [

	aVariableNode binding isUndeclaredVariable ifTrue: [ 
		^ (aVariableNode scope hasBindingThatBeginsWith: aVariableNode name)
			  ifTrue: [ #default ]
			  ifFalse: [ #incompleteIdentifier ] ].
	aVariableNode binding ifNil: [ ^ #default ].
	aVariableNode isArgumentVariable ifTrue: [ ^ #methodArg ].
	aVariableNode isTempVariable ifTrue: [ ^ #tempVar ].
	aVariableNode isGlobalVariable ifTrue: [ ^ #globalVar ].
	aVariableNode isInstanceVariable ifTrue: [ ^ #instVar ].
	aVariableNode hasIncompleteIdentifier ifTrue: [ 
		^ #incompleteIdentifier ].
	^ #invalid
]

{ #category : #private }
BlRBTextStyler >> resolveTextLinkFor: aVariableNode [

	aVariableNode binding isGlobalVariable
		ifTrue: [ ^ BlTextClassLink className: aVariableNode name ].
		
	^ BlTextVariableLink variableName: aVariableNode name
]

{ #category : #private }
BlRBTextStyler >> style: aText ast: ast [
	text := aText.
	text attributes: (self attributesFor: #default).
	bracketLevel := 0.
	parentheseLevel := 0.
	[ self visitNode: ast ] ensure: [ 
		text := nil ]
]

{ #category : #private }
BlRBTextStyler >> styleCloseBracket: aBlockNode [
	bracketLevel := bracketLevel - 1.
	(aBlockNode right isZero or: [  aBlockNode value isNil ]) ifTrue:[^ self].
	self addStyle: self currentClosedBracketStyleName from: aBlockNode right to: aBlockNode right
]

{ #category : #private }
BlRBTextStyler >> styleCloseParenthese: aMessageNode [
	aMessageNode parentheses
		ifNotEmpty: [ 
			aMessageNode parentheses
				reverseDo: [ :interval | 
					| pos |
					pos := interval last.
					parentheseLevel := parentheseLevel - 1.
					self addStyle: self currentClosedParenthesisStyleName from: pos to: pos ] ]
]

{ #category : #private }
BlRBTextStyler >> styleOpenBracket: aBlockNode [
	| style |
	style := aBlockNode isFaulty
		ifTrue: [ #invalid ]
		ifFalse: [ self currentOpenedBracketStyleName ].
	self addStyle: style from: aBlockNode left to: aBlockNode left.
	bracketLevel := bracketLevel + 1
]

{ #category : #private }
BlRBTextStyler >> styleOpenParenthese: aMessageNode [
	aMessageNode parentheses
		ifNotEmpty: [ 
			aMessageNode parentheses
				do: [ :interval | 
					| pos |
					pos := interval first.
					self addStyle:  self currentOpenedParenthesisStyleName from: pos to: pos.
					parentheseLevel := parentheseLevel + 1 ] ]
]

{ #category : #private }
BlRBTextStyler >> styleTempBars: aSequenceNode [
	| tempBarAttribute |
	tempBarAttribute := aSequenceNode scope isMethodScope
		ifTrue: [ #methodTempBar ]
		ifFalse: [ #blockTempBar ].
	aSequenceNode leftBar
		ifNotNil: [ :pos | self addStyle: tempBarAttribute from: pos to: pos ].
	aSequenceNode rightBar
		ifNotNil: [ :pos | self addStyle: tempBarAttribute from: pos to: pos ]
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitArgumentNode: anArgumentNode [
	| blockOrMethodArgStyle |
	blockOrMethodArgStyle := self methodOrBlockArgStyleFor: anArgumentNode.
	self addStyle: blockOrMethodArgStyle forNode: anArgumentNode
]

{ #category : #visiting }
BlRBTextStyler >> visitArrayNode: anArrayNode [ 

	anArrayNode children do: [:each | self visitNode: each]
]

{ #category : #visiting }
BlRBTextStyler >> visitAssignmentNode: anAssignmentNode [
	self visitNode: anAssignmentNode variable.
	self visitNode: anAssignmentNode value.
	anAssignmentNode variable binding isWritable
		ifFalse: [ self addStyle: #invalid forNode: anAssignmentNode ]
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitBlockNode: aBlockNode [
	aBlockNode comments do: [ :comment | self addStyle: #comment from: comment start to: comment stop ].
	aBlockNode arguments do: [ :argument | self addStyle: #blockPatternArg forNode: argument ].
	aBlockNode bar ifNotNil: [ :pos | self addStyle: #blockArgsBar from: pos to: pos ].
	aBlockNode colons do: [ :pos | self addStyle: #blockArgColon from: pos to: pos ].
	self styleOpenBracket: aBlockNode.
	self visitNode: aBlockNode body.
	self styleCloseBracket: aBlockNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitCascadeNode: aCascadeNode [
	aCascadeNode messages do: [ :each | self visitNode: each ].
	aCascadeNode semicolons do: [ :pos | self addStyle: #cascadeSeparator from: pos to: pos ]
]

{ #category : #visiting }
BlRBTextStyler >> visitEnglobingErrorNode: anEnglobingErrorNode [
	anEnglobingErrorNode contents do: [ :each | self visitNode: each ]
]

{ #category : #visiting }
BlRBTextStyler >> visitGlobalNode: aSelfNode [
	^ self visitVariableNode: aSelfNode
]

{ #category : #visiting }
BlRBTextStyler >> visitInstanceVariableNode: aSelfNode [
	^ self visitVariableNode: aSelfNode
]

{ #category : #visiting }
BlRBTextStyler >> visitLiteralArrayNode: aRBLiteralArrayNode [
	"in a (valid) byte array all elements are of the same type, style the whole contents
at once, but for ordinary literal arrays, style every node"

	(aRBLiteralArrayNode isForByteArray and: [ aRBLiteralArrayNode isFaulty not ])
		ifTrue: [ self addStyle: #literalArray forNode: aRBLiteralArrayNode ]
		ifFalse: [ aRBLiteralArrayNode contents do: [ :each | self visitNode: each ] ]
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitLiteralNode: aLiteralNode [
	| value |
	value := aLiteralNode value.
	self 
		addStyle: (self literalStyleSymbol: value)
		attribute: (BlTextClassLink class: value class)
		forNode: aLiteralNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitMessageNode: aMessageNode [
	| style link |
	style := #keyword.
	(Symbol findInterned: aMessageNode selector asString)
		ifNil: [ 
			style := (Symbol thatStartsCaseSensitive: aMessageNode selector asString skipping: nil) isNil
				ifTrue: [ #undefinedKeyword ]
				ifFalse: [ #incompleteKeyword ] ].
	link := BlTextMethodLink selector: aMessageNode selector.
	self styleOpenParenthese: aMessageNode.
	aMessageNode selectorParts
		with: aMessageNode keywordsPositions
		do: [ :keyword :position | 
			self
				addStyle: style
				attribute: link
				from: position
				to: position + keyword size - 1 ].
	(aMessageNode isCascaded not or: [ aMessageNode isFirstCascaded ])
		ifTrue: [ self visitNode: aMessageNode receiver ].
	aMessageNode arguments do: [ :each | self visitNode: each ].
	self styleCloseParenthese: aMessageNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitMethodNode: aMethodNode [

	aMethodNode isDoIt ifTrue: [ ^ self visitNode: aMethodNode body ].

	aMethodNode comments do: [ :comment | 
		self addStyle: #comment from: comment start to: comment stop ].
	aMethodNode arguments do: [ :argument | 
		self addStyle: #patternArg forNode: argument ].
	(aMethodNode selectorParts includes: #faulty) ifFalse: [ 
		aMethodNode selectorParts
			with: aMethodNode keywordsPositions
			do: [ :keyword :position | 
				self
					addStyle: #patternKeyword
					from: position
					to: (position + keyword size - 1 min: text size) ] ].

	aMethodNode pragmas do: [ :each | self visitNode: each ].
	self visitNode: aMethodNode body
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitNode: aNode [

	aNode comments ifNotNil: [ 
		aNode comments do: [ :comment | self addStyle: #comment from: comment start to: comment stop ] ].

	^ aNode acceptVisitor: self
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitParseErrorNode: anErrorNode [
	self 
		addStyle: #invalid
		forNode: anErrorNode
]

{ #category : #visiting }
BlRBTextStyler >> visitPatternBlockNode: aRBPatternBlockNode [ 
	self visitArgumentNodes: aRBPatternBlockNode arguments.
	self visitNode: aRBPatternBlockNode body
]

{ #category : #visiting }
BlRBTextStyler >> visitPatternWrapperBlockNode: aRBPatternWrapperBlockNode [ 
	self visitNode: aRBPatternWrapperBlockNode wrappedNode.
	self visitArgumentNodes: aRBPatternWrapperBlockNode arguments.
	self visitNode: aRBPatternWrapperBlockNode body
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitPragmaNode: aPragmaNode [
	aPragmaNode selectorParts with: aPragmaNode keywordsPositions do: [ :keyword : position|
	self 
		addStyle: #pragmaKeyword
		from: position
		to: position + keyword size - 1 ].
	self addStyle: #pragmaKeyword from: aPragmaNode left to: aPragmaNode left.
	self addStyle: #pragmaKeyword from: aPragmaNode right to: aPragmaNode right.	
	aPragmaNode arguments do: [ :each | self visitNode: each ]
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitReturnNode: aReturnNode [ 
	self 
		addStyle: #return
		from: aReturnNode start
		to: aReturnNode stop.
		
	self visitNode: aReturnNode value
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitSelfNode: aSelfNode [
	self 
		addStyle: #self
		forNode: aSelfNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitSequenceNode: aSequenceNode [
	| patternTempStyle |
	patternTempStyle := self methodOrBlockTempDeclStyleFor: aSequenceNode.
	self styleTempBars: aSequenceNode.
	aSequenceNode temporaries
		do: [ :temporary | self addStyle: patternTempStyle forNode: temporary ].
	aSequenceNode statements do: [ :each | self visitNode: each ].
	aSequenceNode periods do: [ :pos | self addStyle: #statementSeparator from: pos to: pos ]
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitSuperNode: aSuperNode [
	self 
		addStyle: #super
		forNode: aSuperNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitTemporaryNode: aTemporaryNode [
	| methodOrBlockTempStyle |
	methodOrBlockTempStyle := self methodOrBlockTempStyleFor: aTemporaryNode.
	self addStyle: methodOrBlockTempStyle forNode: aTemporaryNode
]

{ #category : #visiting }
BlRBTextStyler >> visitTemporaryNodes: aNodeCollection [ 
	"This is triggered when defining the temporaries between the pipes"
	^self visitArgumentNodes: aNodeCollection
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitThisContextNode: aThisContextNode [
	self 
		addStyle: #thisContext
		forNode: aThisContextNode
]

{ #category : #'visiting rb nodes' }
BlRBTextStyler >> visitVariableNode: aVariableNode [
	self 
		addStyle: (self resolveStyleFor: aVariableNode) 
		attribute: (self resolveTextLinkFor:aVariableNode)
		forNode: aVariableNode.
	
	
]

{ #category : #accessing }
BlRBTextStyler >> workspace [
	^ workspace
]

{ #category : #accessing }
BlRBTextStyler >> workspace: aWorkspace [

	workspace = aWorkspace ifTrue: [ ^ self ].
	workspace := aWorkspace.
	self announceStateChanged
]
