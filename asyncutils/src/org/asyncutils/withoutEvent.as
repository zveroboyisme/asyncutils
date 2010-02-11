package org.asyncutils
{
	/**
	 * Expects a function that accepts no parameters.  This function is going to get executed without the passed
	 * Event as a parameter.
	 * This utility function simply removes the event listener and then executes the passed function.
	 * the once function does the same thing with a shorter name.
	 **/ 
	public function withoutEvent(f:Function):Function {
		return function(e:*):void {
			f();
		}
	}
}