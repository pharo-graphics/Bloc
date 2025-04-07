"
I'm a Bloc text styler that delegates coloring into Pharo system's Shout code styler.

To determine the style of some names, some context is needed (e.g. if a variable or global is defined or undefined). There are two big cases:
* when the text is the source code of a method in a behavior, or
* when the text is a script in a workspace


"
Class {
	#name : #BlPharoCodeStyler,
	#superclass : #BlTextStyler,
	#instVars : [
		'shoutStyler',
		'classOrMetaClass',
		'workspace',
		'fontName',
		'isScripting'
	],
	#category : #'Bloc-Text-Text-Styler'
}

{ #category : #accessing }
BlPharoCodeStyler >> classOrMetaClass: aBehavior [

	classOrMetaClass = aBehavior ifTrue: [ ^ self ].
	classOrMetaClass := aBehavior.

	shoutStyler classOrMetaClass: aBehavior.

	self announceStateChanged
]

{ #category : #migrate }
BlPharoCodeStyler >> fontName [

	^ fontName
]

{ #category : #accessing }
BlPharoCodeStyler >> fontName: aFontName [

	fontName = aFontName ifTrue: [ ^ self ].
	fontName := aFontName.

	self announceStateChanged
]

{ #category : #initialization }
BlPharoCodeStyler >> initialize [

	super initialize.
	
	shoutStyler := BlSHRBTextStyler new
]

{ #category : #testing }
BlPharoCodeStyler >> isForWorkspace [

	self deprecated: 'Use #isScripting'.

	^ self isScripting
]

{ #category : #testing }
BlPharoCodeStyler >> isForWorkspace: aBoolean [

	self deprecated: 'Use #isScripting:'.

	self isScripting: aBoolean
]

{ #category : #testing }
BlPharoCodeStyler >> isScripting [

	^ isScripting ifNil: [ workspace notNil ]
]

{ #category : #testing }
BlPharoCodeStyler >> isScripting: aBoolean [

	isScripting = aBoolean ifTrue: [ ^ self ].
	isScripting := aBoolean.

	shoutStyler isScripting: aBoolean.

	self announceStateChanged
]

{ #category : #private }
BlPharoCodeStyler >> privateStyle: aText [

	| ast compiler |
	compiler := self isScripting
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


	shoutStyler style: aText ast: ast.

	fontName ifNotNil: [ aText fontName: fontName ].

	^ aText
]

{ #category : #accessing }
BlPharoCodeStyler >> workspace: aWorkspace [

	workspace = aWorkspace ifTrue: [ ^ self ].
	workspace := aWorkspace.

	shoutStyler workspace: aWorkspace.

	self announceStateChanged
]
