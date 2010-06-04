package org.asyncutils
{
	import flash.events.Event;

	public class BindingExecutor
	{
		static private var _locked:Boolean = true;
		
		private var _functionToExecute:Function;
		private var _agrsToPass:Array = [];
		
		private var _predicates:Array = [];
		private var _executeOnce:Boolean = true;
		
		public function BindingExecutor()
		{
			// constructor should not be called
			if (_locked)
			{
				throw new Error(" Do not intantiate this class directly.  Use one of the static public functions instead. ");
			}
		}
		
		public function reset():Boolean
		{
			return false;	
		}
		
		public function startWatching():Boolean
		{
			return false;
		}
		
		
		
		static public function execute(f:Function, ... argsToPass):BindingExecutor
		{
			// unlock
			_locked = false;
			// instantiate and lock
			var executor:BindingExecutor = new BindingExecutor();
			_locked = true;
			executor._functionToExecute = f;
			executor._agrsToPass = argsToPass;
			
			return executor;
		}
		
		private function when(condition:Function, host:Object, chain:Object, commitOnly:Boolean = false):BindingExecutor
		{
			_predicates.push( new BindingPredicate(this, condition, host, chain, commitOnly) );
			return this;
		}

		private function every(host:Object, condition:Function, chain:Object, commitOnly:Boolean = false):BindingExecutor
		{
			_predicates.push( new BindingPredicate(this, condition, host, chain, commitOnly) );
			return this;
		}

		public function once(host:Object, condition:Function, chain:Object, commitOnly:Boolean = false):BindingExecutor
		{
			_predicates.push( new BindingPredicate(this, condition, host, chain, commitOnly) );
			return this;
		}

		private function wrap(predicate:Function):Function
		{
			return function(event:Event):void
			{

				trace(event.currentTarget + "  " + event.type);
			};
		}
		
		internal function conditionMet(predicate:BindingPredicate):void
		{
			
		}
	}
}