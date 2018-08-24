"
I contain examples of a text paragraph
"
Class {
	#name : #BrSingleLineTextParagraphExamples,
	#superclass : #Object,
	#category : 'Bloc-Examples-Text'
}

{ #category : #'font - metrics' }
BrSingleLineTextParagraphExamples >> ascent [
	<gtExample>

	^ 10
]

{ #category : #'font - metrics' }
BrSingleLineTextParagraphExamples >> descent [
	<gtExample>

	^ 5
]

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> emoji [
	<gtExample>

	^ '😃'
]

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> emojiParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self emoji asRopedText.
	
	^ aParagraph
]

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> emptyParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: BlText empty.
	
	^ aParagraph
]

{ #category : #'font - metrics' }
BrSingleLineTextParagraphExamples >> glyphWidth [
	<gtExample>

	^ 10
]

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> haba [
	<gtExample>

	^ 'Haba'
]

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> habaParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := self newParagraph.
	aParagraph text: self haba asRopedText.
	
	^ aParagraph
]

{ #category : #'font - metrics' }
BrSingleLineTextParagraphExamples >> height [
	<gtExample>

	^ 12
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: self glyphWidth @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtBetweenHalfsOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 2.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarBottomLeftPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtFarBottomLeftPointInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth * self haba size * 10) negated @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarBottomPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0 @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarBottomRightPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) @ (self ascent * 10).
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarTopLeftPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) asPoint negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarTopPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@(self ascent * 10) negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarTopRightPointInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: (self ascent * 10) @ (self ascent * 10) negated.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> indexAtFarZeroInEmpty [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredEmpty.
	anIndex := aParagraph indexAtPosition: 0@0.
	
	self assert: anIndex equals: 0.
	
	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtLeftHalfOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 3.0) @ self ascent.
	
	self assert: anIndex equals: 0.

	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtLeftHalfOfForthCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 3) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 3.

	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtLeftHalfOfSecondCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 1) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtLeftHalfOfThirdCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: ((self glyphWidth * 2) + (self glyphWidth / 3.0)) @ self ascent.
	
	self assert: anIndex equals: 2.

	^ anIndex
]

{ #category : #'geometry - haba' }
BrSingleLineTextParagraphExamples >> indexAtRightHalfOfFirstCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: (self glyphWidth / 1.5) @ self ascent.
	
	self assert: anIndex equals: 1.
	
	^ anIndex
]

{ #category : #'paragraph - measuring' }
BrSingleLineTextParagraphExamples >> measuredEmoji [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self emojiParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 1.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent.
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
	self assert: aSpan baseline equals: 0 @ self ascent.
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
BrSingleLineTextParagraphExamples >> measuredEmpty [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self emptyParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 0.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent.
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
	self assert: aSpan baseline equals: 0 @ self ascent.
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
BrSingleLineTextParagraphExamples >> measuredHaba [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self habaParagraph.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 4.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: 0 @ self ascent.
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
	self assert: aSpan baseline equals: 0 @ self ascent.
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
BrSingleLineTextParagraphExamples >> measuredHabaWithPadding [
	<gtExample>
	| aParagraph aLine aSpan |
	
	aParagraph := self habaParagraph.
	aParagraph padding: self padding.
	aParagraph measureOn: self measurer.
	
	self assert: aParagraph measuredEnd equals: 4.
	
	aLine := aParagraph line.
	self assert: aLine ascent equals: self ascent.
	self assert: aLine baseline equals: (0 @ self ascent) + self padding topLeft.
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
	self assert: aSpan baseline equals: (0 @ self ascent) + self padding topLeft.
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

{ #category : #'instance creation' }
BrSingleLineTextParagraphExamples >> measurer [
	<gtExample>
	| aMeasurer |
	
	aMeasurer := BrTextParagraphFixedSpanMeasurer new.
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
BrSingleLineTextParagraphExamples >> newParagraph [
	<gtExample>
	| aParagraph |

	aParagraph := BrSingleLineTextParagraph new.

	self assert: aParagraph containerExtent equals: 0@0.
	self assert: aParagraph hasWidthLimit not.
	self assert: aParagraph hasHeightLimit not.
	self assert: aParagraph wantsAutoRelease.
	
	^ aParagraph
]

{ #category : #'font - metrics' }
BrSingleLineTextParagraphExamples >> padding [
	<gtExample>

	^ BlInsets top: 20 right: 10 bottom: 30 left: 5
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> positionAtIndexInEmpty [
	<gtExample>
	| aParagraph aPoint |
	
	aParagraph := self measuredEmpty.
	aPoint := aParagraph positionAt: 0.
	
	self assert: aPoint equals: 0 @ aParagraph baseline y.
	
	^ aPoint
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarBottomLeftPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) negated @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarBottomPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0 @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarBottomRightPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) @ (self ascent * 10).
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarTopLeftPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) asPoint negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarTopPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@(self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarTopRightPointInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: (self ascent * 10) @ (self ascent * 10) negated.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtFarZeroInEmpty [
	<gtExample>
	| aParagraph aSpan |

	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtPoint: 0@0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]

{ #category : #'geometry - empty' }
BrSingleLineTextParagraphExamples >> spanAtIndexInEmpty [
	<gtExample>
	| aParagraph aSpan |
	
	aParagraph := self measuredEmpty.
	aSpan := aParagraph spanAtIndex: 0.
	
	self assert: aSpan equals: aParagraph line spans first.
	
	^ aSpan
]
