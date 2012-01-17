//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package robotlegs.bender.extensions.mediatorMap.impl
{
	import org.hamcrest.Matcher;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorFactory;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMapping;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMappingConfig;
	import robotlegs.bender.framework.guard.api.IGuardGroup;
	import robotlegs.bender.framework.guard.impl.GuardGroup;
	import robotlegs.bender.framework.hook.api.IHookGroup;
	import robotlegs.bender.framework.hook.impl.HookGroup;

	public class MediatorMapping implements IMediatorMapping, IMediatorMappingConfig
	{

		/*============================================================================*/
		/* Public Properties                                                          */
		/*============================================================================*/

		private var _matcher:Matcher;

		public function get matcher():Matcher
		{
			return _matcher;
		}

		private var _mediatorClass:Class;

		public function get mediatorClass():Class
		{
			return _mediatorClass;
		}

		private var _viewType:Class;

		public function get viewType():Class
		{
			return _viewType;
		}

		private var _guards:IGuardGroup;

		public function get guards():IGuardGroup
		{
			return _guards;
		}

		private var _hooks:IHookGroup;

		public function get hooks():IHookGroup
		{
			return _hooks;
		}

		private var _factory:IMediatorFactory;

		public function get factory():IMediatorFactory
		{
			return _factory;
		}

		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/

		public function MediatorMapping(matcher:Matcher, mediatorClass:Class, factory:IMediatorFactory)
		{
			_matcher = matcher;
			_mediatorClass = mediatorClass;
			_factory = factory;
			_guards = new GuardGroup(factory.injector);
			_hooks = new HookGroup(factory.injector);
		}

		/*============================================================================*/
		/* Public Functions                                                           */
		/*============================================================================*/

		public function asType(viewType:Class):IMediatorMappingConfig
		{
			_viewType = viewType;
			return this;
		}

		public function withFactory(factory:IMediatorFactory):IMediatorMappingConfig
		{
			_factory = factory;
			return this;
		}

		public function withGuards(... guardClasses):IMediatorMappingConfig
		{
			_guards.add.apply(null, guardClasses)
			return this;
		}

		public function withHooks(... hookClasses):IMediatorMappingConfig
		{
			_hooks.add.apply(null, hookClasses)
			return this;
		}
	}
}
