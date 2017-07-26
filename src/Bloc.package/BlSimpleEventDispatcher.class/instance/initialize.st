initialization
initialize
	super initialize.

	"Note, that we do not expose filters and handlers to the outer worlds with getters because it is not part
	of our public api. Additionally we want to treat shortcutHandler differently. By convention
	shortcutHandler always presents in a simple dispatcher. It is not memory efficient to create an instance
	of handler registry just for a single shortcut handler, that we know, always presents.
	However, shortcut handler is of type handler and *virtually* belongs to handlers registry. It is just
	not visible to users, think of it as implementation detail"
	filters := nil. "BlHandlerRegistry"
	handlers := nil. "BlHandlerRegistry"
	shortcutHandler := BlShortcutHandler new