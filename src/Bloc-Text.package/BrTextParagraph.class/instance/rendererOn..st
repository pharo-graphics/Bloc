paragraph - rendering
rendererOn: aCanvas
	"Return a renderer that should be used to render a paragraph
	(for example multiline or a single line paragraph renderers)"
	<return: #BrTextParagraphRenderer>

	^ self subclassResponsibility