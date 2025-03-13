"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[9671],{3905:(e,t,n)=>{n.d(t,{Zo:()=>s,kt:()=>y});var r=n(67294);function o(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}function a(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),n.push.apply(n,r)}return n}function i(e){for(var t=1;t<arguments.length;t++){var n=null!=arguments[t]?arguments[t]:{};t%2?a(Object(n),!0).forEach((function(t){o(e,t,n[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):a(Object(n)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(n,t))}))}return e}function l(e,t){if(null==e)return{};var n,r,o=function(e,t){if(null==e)return{};var n,r,o={},a=Object.keys(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||(o[n]=e[n]);return o}(e,t);if(Object.getOwnPropertySymbols){var a=Object.getOwnPropertySymbols(e);for(r=0;r<a.length;r++)n=a[r],t.indexOf(n)>=0||Object.prototype.propertyIsEnumerable.call(e,n)&&(o[n]=e[n])}return o}var p=r.createContext({}),c=function(e){var t=r.useContext(p),n=t;return e&&(n="function"==typeof e?e(t):i(i({},t),e)),n},s=function(e){var t=c(e.components);return r.createElement(p.Provider,{value:t},e.children)},u="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return r.createElement(r.Fragment,{},t)}},d=r.forwardRef((function(e,t){var n=e.components,o=e.mdxType,a=e.originalType,p=e.parentName,s=l(e,["components","mdxType","originalType","parentName"]),u=c(n),d=o,y=u["".concat(p,".").concat(d)]||u[d]||m[d]||a;return n?r.createElement(y,i(i({ref:t},s),{},{components:n})):r.createElement(y,i({ref:t},s))}));function y(e,t){var n=arguments,o=t&&t.mdxType;if("string"==typeof e||o){var a=n.length,i=new Array(a);i[0]=d;var l={};for(var p in t)hasOwnProperty.call(t,p)&&(l[p]=t[p]);l.originalType=e,l[u]="string"==typeof e?e:o,i[1]=l;for(var c=2;c<a;c++)i[c]=n[c];return r.createElement.apply(null,i)}return r.createElement.apply(null,n)}d.displayName="MDXCreateElement"},59881:(e,t,n)=>{n.r(t),n.d(t,{assets:()=>p,contentTitle:()=>i,default:()=>m,frontMatter:()=>a,metadata:()=>l,toc:()=>c});var r=n(87462),o=(n(67294),n(3905));const a={sidebar_position:1},i="Getting Started",l={unversionedId:"intro",id:"intro",title:"Getting Started",description:"OnyxUI is premature software, relying on the premature software Fusion. If that doesn't deter you, get ready to enjoy how easy UI can be. \u2728",source:"@site/docs/intro.md",sourceDirName:".",slug:"/intro",permalink:"/OnyxUI/docs/intro",draft:!1,editUrl:"https://github.com/ImAvafe/OnyxUI/edit/master/docs/intro.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"defaultSidebar",next:{title:"Components",permalink:"/OnyxUI/docs/components"}},p={},c=[{value:"Installation",id:"installation",level:2},{value:"Wally package",id:"wally-package",level:3},{value:"Roblox model",id:"roblox-model",level:3},{value:"Usage Example",id:"usage-example",level:2},{value:"See it in action \u2728",id:"see-it-in-action-",level:2}],s={toc:c},u="wrapper";function m(e){let{components:t,...n}=e;return(0,o.kt)(u,(0,r.Z)({},s,n,{components:t,mdxType:"MDXLayout"}),(0,o.kt)("h1",{id:"getting-started"},"Getting Started"),(0,o.kt)("admonition",{type:"info"},(0,o.kt)("p",{parentName:"admonition"},"  OnyxUI is premature software, relying on the premature software Fusion. If that doesn't deter you, get ready to enjoy how easy UI can be. \u2728")),(0,o.kt)("h2",{id:"installation"},"Installation"),(0,o.kt)("h3",{id:"wally-package"},"Wally package"),(0,o.kt)("ol",null,(0,o.kt)("li",{parentName:"ol"},"Copy the ",(0,o.kt)("a",{parentName:"li",href:"https://wally.run/package/imavafe/onyx-ui"},"Wally details")),(0,o.kt)("li",{parentName:"ol"},"Paste it into your ",(0,o.kt)("inlineCode",{parentName:"li"},"wally.toml")," dependencies"),(0,o.kt)("li",{parentName:"ol"},"Run ",(0,o.kt)("inlineCode",{parentName:"li"},"wally install"))),(0,o.kt)("h3",{id:"roblox-model"},"Roblox model"),(0,o.kt)("admonition",{title:"Important",type:"warning"},(0,o.kt)("p",{parentName:"admonition"},"When using the ",(0,o.kt)("inlineCode",{parentName:"p"},"rbxm"),", you must require the copy of Fusion bundled within it, rather than your own install. Or alternatively, switch to Wally to avoid this altogether.")),(0,o.kt)("ol",null,(0,o.kt)("li",{parentName:"ol"},"Download the ",(0,o.kt)("inlineCode",{parentName:"li"},"OnyxUI.rbxm")," file ",(0,o.kt)("a",{parentName:"li",href:"https://github.com/ImAvafe/OnyxUI/releases/latest"},"listed here")),(0,o.kt)("li",{parentName:"ol"},"Insert ",(0,o.kt)("inlineCode",{parentName:"li"},"OnyxUI.rbxm")," into Roblox Studio")),(0,o.kt)("h2",{id:"usage-example"},"Usage Example"),(0,o.kt)("p",null,"Here's a basic component example, making use of some of OnyxUI's features."),(0,o.kt)("pre",null,(0,o.kt)("code",{parentName:"pre",className:"language-lua"},'local OnyxUI = require(path.to.OnyxUI)\nlocal Fusion = require(path.to.Fusion)\n\nlocal Themer = OnyxUI.Themer\nlocal InnerScope = Fusion.innerScope\nlocal Util = OnyxUI.Util\n\nreturn function(Scope: Fusion.Scope<any>, Props)\n    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)\n    local Theme = Themer.Theme:now()\n\n    return Scope:Card {\n        BackgroundColor3 = Util.Colors.Gray["200"],\n        Padding = Scope:Computed(function(Use)\n            return UDim.new(0, Use(Theme.Spacing["2"]))\n        end),\n    }\nend\n')),(0,o.kt)("h2",{id:"see-it-in-action-"},(0,o.kt)("a",{parentName:"h2",href:"/OnyxUI/docs/in-production"},"See it in action \u2728")))}m.isMDXComponent=!0}}]);