I am a factory. My input is a XMLElement coming from a SVG file, my output is a BlElement matchingthe input.
I am used to translate an graphical object from SVG to Bloc.

My instance variable 'definitions' is a Dictionary used to store previously created objects when they have a 'id' attribute, so that they may be re-used in the same SVG file.

Main example of use:
    - BlSVGFactory new generateElementFrom: anXMLElement.

Process explained:
    - the 'generateElementFrom:' method acts as a switch calling the appropriate method in regard to the XMLElement to translate;
    - this called method generates the appropriate BlGeometry with the appropriate parameters, then convert the BlGeometry to a BlElement;
    - the called method sets some specific properties on the BlElement, then calls (in most cases) 'allPropertiesFrom:on:' to set the 'rendering properties' and 'common properties' shared by most objects.