/*
	Xindi - http://www.getxindi.com/
	
	Copyright (c) 2012, Simon Bingham
	
	Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, 
	modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software 
	is furnished to do so, subject to the following conditions:
	
	The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
	
	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE 
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR 
	IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

component accessors="true"{

	// ------------------------ DEPENDENCY INJECTION ------------------------ //

	property name="Validator" getter="false";
	
	// ------------------------ PUBLIC METHODS ------------------------ //
	
	/**
	 * I return an entity validator
	 */		
	function getValidator( required Entity ){
		return variables.Validator.getValidator( theObject=arguments.Entity );
	}
	
	/**
     * I populate an entity
	 */	
	void function populate( required entity, required struct memento, boolean trustedSetter=false, string include="", string exclude="" ){
		var populate = true;
		for( var key in arguments.memento ){
			populate = true;
			if( Len( arguments.include ) && !ListFindNoCase( arguments.include, key ) ) populate = false;
			if( Len( arguments.exclude ) && ListFindNoCase( arguments.exclude, key ) ) populate = false;
			if( populate && ( StructKeyExists( arguments.entity, "set" & key ) || arguments.trustedSetter ) ) Evaluate( "arguments.entity.set#key#(arguments.memento[key])" );
		}
	}	
	
}