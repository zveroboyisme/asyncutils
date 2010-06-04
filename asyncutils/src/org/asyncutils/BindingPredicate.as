package org.asyncutils
{
	import mx.binding.utils.ChangeWatcher;
	import mx.events.PropertyChangeEvent;

	internal class BindingPredicate
	{
		private var _executor:BindingExecutor;
		private var _host:Object;
		private var _chain:Object;
		private var _commitOnly:Boolean;
		private var _once:Boolean = true;
		private var _changeWatcher:ChangeWatcher;
		private var _condition:Function;

		public function BindingPredicate(executor:BindingExecutor, condition:Function, host:Object, chain:Object, commitOnly:Boolean = false, once:Boolean = true)
		{
			_executor = executor;
			_condition = condition;
			_host = host;
			_chain = chain;
			_commitOnly = commitOnly;
			_once = once;
		}
		
		public function reset():void
		{
			if (_changeWatcher)
			{
				_changeWatcher.unwatch();
				_changeWatcher = null;
			}	
		}
		
		
		private function startWatching():void
		{
			_changeWatcher = ChangeWatcher.watch(_host, _chain, onChange, _commitOnly);
		}
		
		private function onChange(event:PropertyChangeEvent):void
		{
			// test agains condition
			// if passes, notify executor
		}

/*
		public function Is(f:Function):BindingExecutor
		{
			if (!_executor)
			{
				_executor = new BindingExecutor();
			}
			ChangeWatcher.watch(host, chain, f, commitOnly);
			
			return _executor;
		}
		*/

	}
}