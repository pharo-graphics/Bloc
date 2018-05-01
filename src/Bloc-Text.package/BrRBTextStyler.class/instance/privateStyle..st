private
privateStyle: aText 
    | ast |

    ast := self parse: aText isMethod: workspace isNil.
    ast methodNode compilationContext: (CompilationContext new
            class: (classOrMetaClass ifNil: [UndefinedObject]);
				forSyntaxHighlighting: true;
				bindings: workspace;
            requestor: workspace).
    ast doSemanticAnalysis.


   self style: aText ast: ast.
	self extraStyle: aText ast: ast.

    ^ aText