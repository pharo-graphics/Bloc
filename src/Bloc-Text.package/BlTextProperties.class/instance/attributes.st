accessing
attributes
	<return: #Collection of: #BrTextAttribute>
	
	^ { self background . self emphasis . self fontFamily . self fontSize . self foreground . self weight }
		select: #isNotNil