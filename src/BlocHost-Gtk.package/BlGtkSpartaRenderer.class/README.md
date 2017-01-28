I am a concrete implementation of a BlHostRenderer.
I allow space to be rendered on sparta canvas while being able to display it on on Gtk3 surface.

I use cairo image surface as pixel buffer so that sparta canvas could render directly to it as target surface