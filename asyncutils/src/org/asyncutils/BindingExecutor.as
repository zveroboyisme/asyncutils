package org.asyncutils
{
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class BindingExecutor
	{
		static private var _locked:Boolean = true;
		
		private var _functionToExecute:Function;
		private var _agrsToPass:Array = [];
		
		private var _predicates:Array = [];
		private var _executeOnce:Boolean = true;
		private var _mapPredicates:Dictionary = new Dictionary(true);
		private var _predicatesWithMetConditions:Number = 0;
		
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

		private function every(condition:Function, host:Object, chain:Object, commitOnly:Boolean = false):BindingExecutor
		{
			_predicates.push( new BindingPredicate(this, condition, host, chain, commitOnly) );
			return this;
		}

		public function once(condition:Function, host:Object, chain:Object, commitOnly:Boolean = false):BindingExecutor
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
			trace("+ BE.conditionMet " + _predicatesWithMetConditions );
			var conditionMet:Boolean = false;
			
			if (_mapPredicates[predicate] == null)
			{
				conditionMet = true;
				_mapPredicates[predicate] = conditionMet;
				_predicatesWithMetConditions++;
			}
			
			
			trace("  BE.conditionMet " + _predicatesWithMetConditions );
			if (_predicatesWithMetConditions == _predicates.length)
			{
				// check if all conditions are still met
				var predicatesWithUnmetCondition:Array = findAllPredicatesWithUnmetConditions();	
				for each (var predicate:BindingPredicate in predicatesWithUnmetCondition)
				{
					predicate.startWatching();
				}
			}
			
			if (_predicatesWithMetConditions == _predicates.length)
			{
				_functionToExecute.apply(null, _agrsToPass);
			}
			
			trace("- BE.conditionMet " + _predicatesWithMetConditions );
		}
		
		// Assumes that all predicates have reported that their respective conditions have been met
		// however, that may not be true for some of the predicates any more
		private function findAllPredicatesWithUnmetConditions():Array
		{
			function checkConditionMet(item:BindingPredicate, index:int, array:Array):Boolean
			{
				var conditionStillMet:Boolean =  item.isConditionStillMet();
				if (conditionStillMet == false)
				{
					// remove them from the map
					// and decrement met count
					delete _mapPredicates[item];
					_predicatesWithMetConditions--;	
				}
				return !conditionStillMet;
			}
			
			return _predicates.filter(checkConditionMet);
		}
	}
}