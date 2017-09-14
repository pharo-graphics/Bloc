I am a subclass of Color that implements the color standard of SVG as specified by W3C ( see https://www.w3.org/TR/SVG/types.html#ColorKeywords ).

I can be instanciated through 3 different ways:

	-> with a color keyword of the standard ( example: SVGColor navy )
	
	-> with a rgb triplet ( example: SVGColor fromRgbString:'rgb(0,0,255))' 
								SVGColor fromRgbString:'rgb(0%,0%,100%))'  )
						
	-> with a HexString with 6 or 3 characters ( example: SVGColor fromHexString:'0000FF' 
													SVGColor fromHexString:'00F'   )
													
My method "fromString:" allows me to choose myself the right instanciation method to use among the ones above.

	-> SVGColor fromString:'navy' <=> SVGColor navy
	
	-> SVGColor fromString:'rgb(0,0,255))'  <=> SVGColor fromRgbString:'rgb(0,0,255))' 
	     SVGColor fromString:'rgb(0%,0%,100%))' <=> SVGColor fromRgbString:'rgb(0%,0%,100%))'
	
	-> SVGColor fromString:'#0000FF' <=>  SVGColor fromHexString:'0000FF' 
	     SVGColor fromString:'#00F' <=> SVGColor fromHexString:'00F'

--------------------------------------------------------------------------------------------------------------------------------------------------

Not much to see on the instance side.