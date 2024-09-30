"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[1169],{68499:e=>{e.exports=JSON.parse('{"functions":[{"name":"EnsureValue","desc":"Converts the `Value` argument to a `Fusion.Value` object, if it is not one already.","params":[{"name":"Scope","desc":"","lua_type":"Fusion.Scope<any>"},{"name":"Value","desc":"","lua_type":"Fusion.UsedAs<any>"}],"returns":[{"desc":"","lua_type":"Fusion.Value<Fusion.Scope<any>, any>"}],"function_type":"static","source":{"line":11,"path":"src/Util/EnsureValue.luau"}},{"name":"CombineProps","desc":"Combines two sets of props for easy passthrough, adding `Source`\'s props to `Target`. If a prop is already in `Target`, it will be overridden.","params":[{"name":"Source","desc":"","lua_type":"Fusion.PropertyTable"},{"name":"Target","desc":"","lua_type":"Fusion.PropertyTable"},{"name":"ExcludedKeys","desc":"","lua_type":"{ any }?"}],"returns":[{"desc":"","lua_type":"Fusion.PropertyTable"}],"function_type":"static","source":{"line":12,"path":"src/Util/CombineProps.luau"}},{"name":"Fallback","desc":"Defaults the given `Value` to `Fallback` if nil.","params":[{"name":"Value","desc":"","lua_type":"Fusion.UsedAs<any>"},{"name":"Fallback","desc":"","lua_type":"any"}],"returns":[{"desc":"","lua_type":"any"}],"function_type":"static","source":{"line":11,"path":"src/Util/Fallback.luau"}}],"properties":[{"name":"Colors","desc":"Colors imported from [TailwindCSS\'s color palette](https://tailwindcss.com/docs/customizing-colors#default-color-palette).","lua_type":"table","readonly":true,"source":{"line":8,"path":"src/Util/Colors.luau"}}],"types":[],"name":"Util","desc":"Important utilities for UI development.","source":{"line":6,"path":"src/Util/init.luau"}}')}}]);