as yet unclassified
iconNameFromFileName: aFileName
^ (($.split: aFileName) first replaceAll:$-  with: Character space ) asCamelCase asValidSelector