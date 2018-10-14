"
I contain examples of a text paragraph
"
Class {
	#name : #BlSingleLineTextParagraphExamples,
	#superclass : #Object,
	#category : #'Bloc-Examples-Text'
}

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> ascent [
	<gtExample>

	^ 10
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

{ #category : #'geometry - haba' }
BlSingleLineTextParagraphExamples >> indexAtBetweenFirstAndSecondCharacterInHaba [
	<gtExample>
	| aParagraph anIndex |

	aParagraph := self measuredHaba.
	anIndex := aParagraph indexAtPosition: self glyphWidth @ self ascent.
	
	self assert: anIndex equals: 1.

	^ anIndex
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
BlSingleLineTextParagraphExamples >> measuredEmpty [
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
BlSingleLineTextParagraphExamples >> measuredHaba [
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
BlSingleLineTextParagraphExamples >> measuredHabaWithPadding [
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
BlSingleLineTextParagraphExamples >> measurer [
	<gtExample>
	| aMeasurer |
	
	aMeasurer := BlTextParagraphFixedSpanMeasurer new.
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

{ #category : #'font - metrics' }
BlSingleLineTextParagraphExamples >> padding [
	<gtExample>

	^ BlInsets top: 20 right: 10 bottom: 30 left: 5
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
