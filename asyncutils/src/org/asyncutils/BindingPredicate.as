package src.org.asyncutils
{
	import mx.binding.utils.ChangeWatcher;
	
	public class BindingPredicate
	{
		private executor:BindingExecutor;
		private host:Object;
		private chain:Object;
		private commitOnly:Boolean;
		private 
		
		public function BindingPredicate(executor:BindingExecutor, host:Object, chain:Object, commitOnly:Boolean=false)
		{
			this.executor = executor;
			this.host = host;
			this.chain = chain;
			this.commitOnly = commitOnly;
		}
		
		public function Is(f:Function):BindingExecutor {
			if (executor) {
				ChangeWatcher.watch(host, chain, f, commitOnly);
			}
		}
		
		public function get and():BindingExecutor {
			return 
		}
	}
}