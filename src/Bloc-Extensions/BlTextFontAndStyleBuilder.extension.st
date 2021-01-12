Extension { #name : #BlTextFontAndStyleBuilder }

{ #category : #'*Bloc-Extensions' }
BlTextFontAndStyleBuilder >> gtInfoFor: aView [
	<gtView>
	| aNotSetText |
	
	aNotSetText := 'Not set' asRopedText foreground: Color gray.
	
	^ ({
		#'Family name' -> (self familyName ifNil: [ aNotSetText ]).
		#Size -> (self fontSize ifNil: [ aNotSetText ]).
		#'Default size' -> (defaultFontSize ifNil: [ aNotSetText ]).
		#Slant -> (self fontSlant
			ifNil: [ aNotSetText ]
			ifNotNil: [ ('{1} ({2})') format: { self fontSlant name . self fontSlant value } ]).
		#Stretch -> (self fontStretch
			ifNil: [ aNotSetText ]
			ifNotNil: [ ('{1} ({2})') format: { self fontStretch name . self fontStretch value } ]).
		#Weight -> (self fontWeight
			ifNil: [ aNotSetText ]
			ifNotNil: [ ('{1} ({2})') format: { self fontWeight name . self fontWeight value } ]).
		#Color -> (self color ifNil: [ aNotSetText ]).
		#Decoration -> (self decoration ifNil: [ aNotSetText ]).
	 } asOrderedDictionary gtItemsFor: aView)
			title: 'Info';
			priority: 7;
			send: [ :each | each value == aNotSetText ifTrue: [ nil ] ifFalse: [ each value ] ]
]
