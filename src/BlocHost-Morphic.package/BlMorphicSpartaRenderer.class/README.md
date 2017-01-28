I am a concrete implementation of a BlHostRenderer.
I allow space to be rendered on sparta canvas while being able to display it on morphic canvas.

I use ExternalForm as pixel buffer so that sparta canvas could render directly to it as target surface while allowing morphic canvas to do a direct copy with BitBlt in order to display the result