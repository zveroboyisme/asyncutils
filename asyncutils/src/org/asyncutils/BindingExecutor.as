package org.asyncutils
{
	import flash.events.Event;

	public class BindingExecutor
	{
		public function BindingExecutor()
		{
		}

		public function every(host:Object, chain:Object, commitOnly:Boolean = false):BindingPredicate
		{
			return new BindingPredicate(this, host, chain, commitOnly);
		}

		public function once(host:Object, chain:Object, commitOnly:Boolean = false):BindingPredicate
		{
			return new BindingPredicate(this, host, chain, commitOnly);
		}

		private function wrap(predicate:Function):Function
		{
			return function(event:Event):void
			{

				trace(event.currentTarget + "  " + event.type);
			};
		}
	}
}