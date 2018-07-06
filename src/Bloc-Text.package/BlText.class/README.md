I am a data structure independent text abstraction.

I define a public API of the text model. User must only talk with me using provided methods. My subclasses provide implementation based on concrete data structures, for example rope or string.

I only store string and corresponding attributes. I don't know anything about text layout or paragraphs. I should be used together with BrTextParagraph in order to be measured, layered out and rendered. 

I provide a fluent text styling api:

[[[
| text |
text := 'Hello world' asRopedText.
(text from: 1 to: 5) foreground: Color blue.
(text from: 7 to: 11) foreground: Color red.
text	
]]]