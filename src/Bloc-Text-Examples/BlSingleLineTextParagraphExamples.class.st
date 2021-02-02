"
I contain examples of a text paragraph
"
Class {
	#name : #BlSingleLineTextParagraphExamples,
	#superclass : #Object,
	#category : #'Bloc-Text-Examples-Measurement'
}

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> ascent [
	<gtExample>

	^ -10
]

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> descent [
	<gtExample>

	^ 5
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> emoji [
	<gtExample>

	^ '😃'
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> emojiParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self emoji asRopedText.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> emptyParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: BlText empty.
	
	^ aParagraph
]

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> glyphWidth [
	<gtExample>

	^ 10
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> haba [
	<gtExample>

	^ 'Haba'
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> habaParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self haba asRopedText.
	
	^ aParagraph
]

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> height [
	<gtExample>

	^ 12
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> helloWorldParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self helloWorldText.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> helloWorldText [
	<gtExample>
	| aText |

	aText := 'HelloWorld' asRopedText.
	(aText from: 1 to: 5) foreground: Color red.

	^ aText
]

{ #category : #'geometry - HelloWorld' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharacterInHelloWorld [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self measuredHelloWorld.

	theIndices := (0 to: aParagraph text size) collect: [ :anIndex | aParagraph indexAtPosition: (self glyphWidth * anIndex) @ self ascent ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharactersInObjectPrintOn [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self measurer.
	
	theIndices := (0 to: aParagraph text size) collect: [ :anIndex | aParagraph indexAtPosition: (self glyphWidth * anIndex) @ self ascent ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ theIndices
]

{ #category : #'geometry - 100@100.' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharactersInPointWithDot [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self newParagraph.
	aParagraph text: self pointWithDotText.
	aParagraph measureOn: self measurer.
	
	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		| aPoint |
		aPoint := aParagraph positionAt: anIndex.
		aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - 100@100.' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharactersInRealPointWithDot [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self newParagraph.
	aParagraph text: self pointWithDotText.
	aParagraph measureOn: self realMeasurer.
	
	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		| aPoint |
		aPoint := aParagraph positionAt: anIndex.
		aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - tab tab' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharactersInRealTabTab [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self newParagraph.
	aParagraph text: (String tab, String tab) asRopedText.
	aParagraph measureOn: self realMeasurer.
	
	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		| aPoint |
		aPoint := aParagraph positionAt: anIndex.
		aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - tab tab' }
BlSingleLineTextParagraphExamples >> indexAtBetweenAllCharactersInTabTab [
	<gtExample>
	| aParagraph theIndices |

	aParagraph := self newParagraph.
	aParagraph text: (String tab, String tab) asRopedText.
	aParagraph measureOn: self measurer.
	
	theIndices := (0 to: aParagraph text size) collect: [ :anIndex |
		| aPoint |
		aPoint := aParagraph positionAt: anIndex.
		aParagraph indexAtPosition: aPoint ].
	self assert: theIndices equals: (0 to: aParagraph text size) asArray.

	^ aParagraph
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: self glyphWidth @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInHelloWorld [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHelloWorld.
	anIndex := aParagraph indexAtPosition: (self glyphWidth * 1) @ self ascent.

	self assert: anIndex equals: 1.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInObjectPrintOn [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self measurer.
	
	anIndex := aParagraph indexAtPosition: (self glyphWidth * 1) @ self ascent.

	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInRealHelloWorld [
	<gtExample>
	| aParagraph anIndex aPosition |

	aParagraph := self realMeasuredHelloWorld.
	
	aPosition := aParagraph positionAt: 1.
	anIndex := aParagraph indexAtPosition: aPosition.

	self assert: anIndex equals: 1.

	^ aParagraph
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtBetweenHalfsOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 2.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlSingleLineTextParagraphExamples >> indexAtBetweenSeventhAndEighthCharacterInHelloWorld [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHelloWorld.
	
	anIndex := aParagraph indexAtPosition: (self glyphWidth * 7) @ self ascent.

	self assert: anIndex equals: 7.

	^ aParagraph
]

{ #category : #'geometry - Object>>#printOn:' }
BlSingleLineTextParagraphExamples >> indexAtBetweenSeventhAndEighthCharacterInObjectPrintOn [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self newParagraph.
	aParagraph text: self objectPrintOnText.
	aParagraph measureOn: self measurer.
	
	anIndex := aParagraph indexAtPosition: (self glyphWidth * 7) @ self ascent.

	self assert: anIndex equals: 7.

	^ anIndex
]

{ #category : #'geometry - HelloWorld' }
BlSingleLineTextParagraphExamples >> indexAtBetweenSeventhAndEighthCharacterInRealHelloWorld [
	<gtExample>
	| aParagraph anIndex aPosition |

	aParagraph := self realMeasuredHelloWorld.
	
	aPosition := aParagraph positionAt: 7.
	anIndex := aParagraph indexAtPosition: aPosition.

	self assert: anIndex equals: 7.

	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarBottomLeftPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtFarBottomLeftPointInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth * self haba size * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarBottomPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarBottomRightPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarTopLeftPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) asPoint negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarTopPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@(self ascent * 10) negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarTopRightPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) @ (self ascent * 10) negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> indexAtFarZeroInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@0.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtLeftHalfOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 3.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtLeftHalfOfForthCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 3) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 3.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtLeftHalfOfSecondCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 1) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtLeftHalfOfThirdCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 2) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 2.

	^ anIndex
]

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtRightHalfOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 1.5) @ self ascent.
	
	self assert: anIndex equals: 1.
	
	^ anIndex
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraphExamples >> measuredEmoji [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self emojiParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 1.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 1.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: self emoji size * self glyphWidth.
	
	aSpan := aLine spans first.
	self assert: aSpan advance equals: self emoji size * self glyphWidth.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 1. 
	self assert: aSpan height equals: self height.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 1. 
	self assert: aSpan spanStart equals: 1.
	self assert: aSpan textRun equals: self emoji.
	self assert: aSpan textRunEnd equals: 1.
	self assert: aSpan textRunStart equals: 1.
	self assert: aSpan to equals: 1.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: (self emoji size * self glyphWidth).
	
	self assert: aSpan spanLength equals: 1.
	self assert: aSpan textRunLength equals: 1.
	self assert: aSpan isSplitted not.
	
	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraphExamples >> measuredEmpty [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self emptyParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 0.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 0.
	self assert: aLine height equals: 0.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 0.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: 0.
	
	aSpan := aLine spans first.
	self assert: aSpan advance equals: 0.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 0. 
	self assert: aSpan height equals: 0.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 0. 
	self assert: aSpan spanStart equals: 0.
	self assert: aSpan textRun equals: ''.
	self assert: aSpan textRunEnd equals: 0. 
	self assert: aSpan textRunStart equals: 0.
	self assert: aSpan to equals: 0.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: 0.
	
	self assert: aSpan spanLength equals: 0.
	self assert: aSpan textRunLength equals: 0.
	self assert: aSpan isSplitted not.
	
	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraphExamples >> measuredHaba [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self habaParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 4.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 1.
	self assert: aLine to equals: 4.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: self haba size * self glyphWidth.
	
	aSpan := aLine spans first.
	self assert: aSpan advance equals: self haba size * self glyphWidth.
	self assert: aSpan ascent equals: self ascent.
	self assert: aSpan baseline equals: 0 @ self ascent abs.
	self assert: aSpan descent equals: self descent.
	self assert: aSpan from equals: 1. 
	self assert: aSpan height equals: self height.
	self assert: aSpan left equals: 0.
	self assert: aSpan spanEnd equals: 4. 
	self assert: aSpan spanStart equals: 1.
	self assert: aSpan textRun equals: self haba.
	self assert: aSpan textRunEnd equals: 4.
	self assert: aSpan textRunStart equals: 1.
	self assert: aSpan to equals: 4.
	self assert: aSpan top equals: 0.
	self assert: aSpan width equals: (self haba size * self glyphWidth).
	
	self assert: aSpan spanLength equals: 4.
	self assert: aSpan textRunLength equals: 4.
	self assert: aSpan isSplitted not.
	
	^ aParagraph
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraphExamples >> measuredHelloWorld [
	<gtExample>
	| aParagraph aLine aFirstSpan aSecondSpan aText aHello aWorld |
	
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self measurer.
	
	aText := aParagraph text.
	aHello := aText from: 1 to: 5.
	aWorld := aText from: 6 to: 10.
	
	self assert: aParagraph measuredEnd equals: aText size.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent abs.
	self assert: aLine descent equals: self descent.
	self assert: aLine from equals: 1.
	self assert: aLine height equals: self height.
	self assert: aLine left equals: 0.
	self assert: aLine spans size equals: 2.
	self assert: aLine to equals: aText size.
	self assert: aLine top equals: 0.
	self assert: aLine width equals: aText size * self glyphWidth.
	
	"first span"
	aFirstSpan := aLine spans first.
	self assert: aFirstSpan advance equals: aHello size * self glyphWidth.
	self assert: aFirstSpan ascent equals: self ascent.
	self assert: aFirstSpan baseline equals: 0 @ self ascent abs.
	self assert: aFirstSpan descent equals: self descent.
	self assert: aFirstSpan from equals: 1. 
	self assert: aFirstSpan to equals: aHello size.
	self assert: aFirstSpan height equals: self height.
	self assert: aFirstSpan left equals: 0.
	self assert: aFirstSpan spanEnd equals: aHello size. 
	self assert: aFirstSpan spanStart equals: 1.
	self assert: aFirstSpan textRun equals: aHello asString.
	self assert: aFirstSpan textRunEnd equals: aHello size.
	self assert: aFirstSpan textRunStart equals: 1.
	self assert: aFirstSpan top equals: 0.
	self assert: aFirstSpan width equals: (aHello size * self glyphWidth).
	self assert: aFirstSpan spanLength equals: aHello size.
	self assert: aFirstSpan textRunLength equals: aHello size.
	self assert: aFirstSpan isSplitted not.
	
	"second span"
	aSecondSpan := aLine spans second.
	self assert: aSecondSpan advance equals: aWorld size * self glyphWidth.
	self assert: aSecondSpan ascent equals: self ascent.
	self assert: aSecondSpan baseline equals: (aFirstSpan width @ self ascent abs).
	self assert: aSecondSpan descent equals: self descent.
	self assert: aSecondSpan from equals: aHello size + 1. 
	self assert: aSecondSpan to equals: aHello size + aWorld size.
	self assert: aSecondSpan height equals: self height.
	self assert: aSecondSpan left equals: 0.
	self assert: aSecondSpan spanEnd equals: aWorld size. 
	self assert: aSecondSpan spanStart equals: 1.
	self assert: aSecondSpan textRun equals: aWorld asString.
	self assert: aSecondSpan textRunEnd equals: aWorld size.
	self assert: aSecondSpan textRunStart equals: 1.
	self assert: aSecondSpan top equals: 0.
	self assert: aSecondSpan width equals: (aWorld size * self glyphWidth).
	self assert: aSecondSpan spanLength equals: aWorld size.
	self assert: aSecondSpan textRunLength equals: aWorld size.
	self assert: aSecondSpan isSplitted not.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> measurer [
	<gtExample>
	| aMeasurer |
	
	aMeasurer := BlMockedTextMeasurer new.
	aMeasurer ascent: self ascent.
	aMeasurer descent: self descent.
	aMeasurer glyphWidth: self glyphWidth.
	aMeasurer height: self height.
	
	self assert: aMeasurer ascent equals: self ascent.
	self assert: aMeasurer descent equals: self descent.
	self assert: aMeasurer glyphWidth equals: self glyphWidth.
	self assert: aMeasurer height equals: self height.
	
	^ aMeasurer
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> newParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := BlSingleLineTextParagraph new.

	self assert: aParagraph containerExtent equals: 0@0.
	self assert: aParagraph hasWidthLimit not.
	self assert: aParagraph hasHeightLimit not.
	self assert: aParagraph wantsAutoRelease.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> objectPrintOnText [
	<gtExample>
	| aText |

	aText := 'Object>>#printOn:' asRopedText.
	(aText from: 1 to: 6) foreground: Color blue.
	(aText from: 9 to: aText size) foreground: Color magenta.

	^ aText
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> pointWithDotText [
	<gtExample>
	| aText |

	aText := '100@100.' asRopedText.
	(aText from: 1 to: 3) foreground: Color red.
	(aText from: 5 to: 7) foreground: Color red.
	(aText from: 8 to: 8) bold.

	^ aText
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> positionAtIndexInEmpty [
	<gtExample>
	| aParagraph aPoint |
	
	aParagraph := self measuredEmpty.
	aPoint := aParagraph positionAt: 0.
	
	self assert: aPoint equals: 0 @ aParagraph baseline y.
	
	^ aPoint
]

{ #category : #'paragraph - measuring' }
BlSingleLineTextParagraphExamples >> realMeasuredHelloWorld [
	<gtExample>
	| aParagraph aLine aFirstSpan aSecondSpan aText aHello aWorld |
	
	aParagraph := self helloWorldParagraph.
	aParagraph measureOn: self realMeasurer.
	
	aText := aParagraph text.
	aHello := aText from: 1 to: 5.
	aWorld := aText from: 6 to: 10.
	
	self assert: aParagraph measuredEnd equals: aText size.
	
	aLine := aParagraph line.
	self assert: aLine from equals: 1.
	self assert: aLine spans size equals: 2.
	self assert: aLine to equals: aText size.
	
	"first span"
	aFirstSpan := aLine spans first.
	self assert: aFirstSpan from equals: 1. 
	self assert: aFirstSpan to equals: aHello size.
	self assert: aFirstSpan spanEnd equals: aHello size. 
	self assert: aFirstSpan spanStart equals: 1.
	self assert: aFirstSpan textRunEnd equals: aHello size.
	self assert: aFirstSpan textRunStart equals: 1.
	self assert: aFirstSpan spanLength equals: aHello size.
	self assert: aFirstSpan textRunLength equals: aHello size.
	self assert: aFirstSpan isSplitted not.
	
	"second span"
	aSecondSpan := aLine spans second.
	self assert: aSecondSpan from equals: aHello size + 1. 
	self assert: aSecondSpan to equals: aHello size + aWorld size.
	self assert: aSecondSpan spanEnd equals: aWorld size. 
	self assert: aSecondSpan spanStart equals: 1.
	self assert: aSecondSpan textRunEnd equals: aWorld size.
	self assert: aSecondSpan textRunStart equals: 1.
	self assert: aSecondSpan spanLength equals: aWorld size.
	self assert: aSecondSpan textRunLength equals: aWorld size.
	self assert: aSecondSpan isSplitted not.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BlSingleLineTextParagraphExamples >> realMeasurer [
	<gtExample>

	^ BlSpartaCanvasTextMeasurer new canvas: Bloc preferableSpartaCanvas offscreen
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarBottomLeftPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarBottomPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0 @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarBottomRightPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarTopLeftPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) asPoint negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarTopPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@(self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarTopRightPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) @ (self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtFarZeroInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BlSingleLineTextParagraphExamples >> spanAtIndexInEmpty [
	<gtExample>
	| aParagraph aSpan |
	
	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtIndex: 0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]
