cursor
moveCursorAt: aTextIndex of: aTextElement in: aParagraphSpan
	| aTextPosition |

	aTextPosition := aParagraphSpan positionAt: aTextIndex.
	
	cursor removeFromParent.
	cursor size: 2 @ aParagraphSpan height.
	cursor position: (aTextPosition - (2 @ aParagraphSpan height / 2.0)).
	cursor textIndex: aTextIndex.

	aTextElement addChild: cursor