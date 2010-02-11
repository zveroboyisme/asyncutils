package org.asyncutils
{
	/**
	 * Expects a function that accepts as a parameter an Event of the same type as the event dispatcher.
	 * This utility function simply removes the event listener and then executes the passed function.
	 * Short-hand for listenOnce.
	 **/ 
	public function once(f:Function):Function {
		return function(e:*):void {
			e.currentTarget.removeEventListener(e.type, arguments.callee);
			f(e);
		}
	}
}