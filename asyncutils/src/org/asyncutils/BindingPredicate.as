package org.asyncutils
{
	import mx.binding.utils.ChangeWatcher;

	public class BindingPredicate
	{
		private var _executor:BindingExecutor;
		private var host:Object;
		private var chain:Object;
		private var commitOnly:Boolean;

		public function BindingPredicate(executor:BindingExecutor, host:Object, chain:Object, commitOnly:Boolean = false)
		{
			this._executor = executor;
			this.host = host;
			this.chain = chain;
			this.commitOnly = commitOnly;
		}

		public function Is(f:Function):BindingExecutor
		{
			if (!_executor)
			{
				_executor = new BindingExecutor();
			}
			ChangeWatcher.watch(host, chain, f, commitOnly);
			
			return _executor;
		}

		public function get and():BindingExecutor
		{
			return _executor;
		}
	}
}