I am used to convert a SVG file to a Bloc object.

Process:
    - I take a SVG File
    - Uses the XMLDOMParser to parse the file to get an XMLDocument and then take its root XMLElement
    - Uses my 'factory' instance variable to translate this XMLElement to a BlElement that I return

Example of uses that return a converted BlElement:
    - BlSVGConverter convertFromString: aString
    - BlSVGConverter convertFromFile: aFileName
    - BlSVGConverter convertFromURL: anUrl