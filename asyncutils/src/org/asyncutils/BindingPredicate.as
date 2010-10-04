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
			//startWatching();
		}

		public function reset():void
		{
			if (_changeWatcher)
			{
				_changeWatcher.unwatch();
				_changeWatcher = null;
			}
		}

		public function isConditionStillMet():Boolean
		{
			trace("+ BP.isConditionMet() ");
			var property:* = _host;

			if (_chain is Array)
			{
				function buildProperty(propName:String, index:int, array:Array):Boolean
				{
					if (property)
					{
						property = property[propName];
					}
					
					return (property != null);
				}
				
				_chain.every(buildProperty);
				
			}
			else
			{
				property = property[_chain];
			}


			var met:Boolean = _condition.call(null, property)
			trace("- BP.isConditionMet() property = " + property);
			return met;
		}

		internal function startWatching():void
		{
			if (_changeWatcher == null || _changeWatcher.isWatching() == false)
			{
				if (isConditionStillMet())
				{
					notifyExecutor();
				}
				else
				{
					trace(" BP.startWatching() ");
					_changeWatcher = ChangeWatcher.watch(_host, _chain, onChange, _commitOnly);
				}
			}
		}

		private function onChange(event:PropertyChangeEvent):void
		{
			trace("+ BP.onChange() property old: = " + event.oldValue + " new: " + event.newValue);
			// test against condition
			// if passes, notify executor
			if (_condition.call(null, event.newValue))
			{
				notifyExecutor();
			}
		}


		private function notifyExecutor():void
		{
			_executor.conditionMet(this);
			if (_once)
			{
				reset();
			}
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