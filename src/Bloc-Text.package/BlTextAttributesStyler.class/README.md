I am a helper class to ease text styling with the help of attributes.
Developers can add custom attributes by creating corresponding extension method on the instance side of ==TBlTextStylable== trait.

[[[
| text styler |
text := 'Hi John' asRopedText.

styler := BlTextAttributesStyler on: (text from: 3 to: 7).
styler bold;
	italic;
	fontSize: 30;
	fontName: 'Roboto';
	monospace;
	foreground: Color darkGray.
styler style.

text
]]]

==BlText==provides fluent API that makes use of me:
[[[
| text |
text := 'Hi John' asRopedText.
(text from: 3 to: 7)
	stylerDo: [ :aStyler | aStyler bold italic foreground: Color red ].
text
]]]