package org.asyncutils
{
	/**
	 * Expects a function that accepts as a parameter an Event of the same type as the event dispatcher.
	 * This utility function simply removes the event listener and then executes the passed function.
	 * the once function does the same thing with a shorter name.
	 **/ 
	public function listenOnce(f:Function):Function {
		return function(e:*):void {
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			f(e);
		}
	}
}