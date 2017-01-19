private
createGtkWindowFor: aSpace
	| win |
	win := GtkWindow primNew: GtkWindowType GTK_WINDOW_TOPLEVEL.
	win primSetEvents: GdkEventMask GDK_ALL_EVENTS_MASK value.
	win primRealize.
	win primSetAppPaintable: true.
	^ win