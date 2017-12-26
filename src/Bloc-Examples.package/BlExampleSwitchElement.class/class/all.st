examples
all
	<gtExample>
	
	^ BlElement new
		layout: (BlGridLayout vertical rowCount: 4; cellSpacing: 20);
		constraintsDo: [ :c |
			c horizontal fitContent.
			c vertical fitContent ];
		addChildren: { 
			self withTrackOrange activate.
			self withTrackOrange deactivate.
			self withTrack activate.
			self withTrack deactivate.
			
			self withoutTrackOrange activate.
			self withoutTrackOrange deactivate.
			self withoutTrack activate.
			self withoutTrack deactivate.
			
			self radioOrange activate.
			self radioOrange deactivate.
			self radio activate.
			self radio deactivate.
		}