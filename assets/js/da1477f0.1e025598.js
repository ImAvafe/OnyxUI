"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[2013],{8762:(e,n,o)=>{o.r(n),o.d(n,{assets:()=>c,contentTitle:()=>l,default:()=>d,frontMatter:()=>s,metadata:()=>t,toc:()=>a});const t=JSON.parse('{"id":"utilities","title":"Utilities","description":"Important utilities for UI development.","source":"@site/docs/utilities.md","sourceDirName":".","slug":"/utilities","permalink":"/OnyxUI/docs/utilities","draft":false,"unlisted":false,"editUrl":"https://github.com/ImAvafe/OnyxUI/edit/master/docs/utilities.md","tags":[],"version":"current","sidebarPosition":5,"frontMatter":{"sidebar_position":5},"sidebar":"defaultSidebar","previous":{"title":"Styling Props","permalink":"/OnyxUI/docs/styling-props"},"next":{"title":"Production Usage","permalink":"/OnyxUI/docs/in-production"}}');var r=o(74848),i=o(28453);const s={sidebar_position:5},l="Utilities",c={},a=[{value:"EnsureValue",id:"ensurevalue",level:2},{value:"CombineProps",id:"combineprops",level:2},{value:"Colors",id:"colors",level:2}];function p(e){const n={a:"a",code:"code",h1:"h1",h2:"h2",header:"header",p:"p",pre:"pre",...(0,i.R)(),...e.components};return(0,r.jsxs)(r.Fragment,{children:[(0,r.jsx)(n.header,{children:(0,r.jsx)(n.h1,{id:"utilities",children:"Utilities"})}),"\n",(0,r.jsx)(n.p,{children:"Important utilities for UI development."}),"\n",(0,r.jsx)(n.h2,{id:"ensurevalue",children:(0,r.jsx)(n.a,{href:"/api/Util#EnsureValue",children:"EnsureValue"})}),"\n",(0,r.jsxs)(n.p,{children:["Want to ensure your component props are Fusion ",(0,r.jsx)(n.code,{children:"Value"}),"s? This makes it a one-line operation."]}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-lua",children:'local Util = OnyxUI.Util\nlocal InnerScope = Fusion.innerScope\n\nreturn function(Props)\n  local Scope = InnerScope(Scope, Util)\n\n  local MyProp = Scope:Fallback(Props.MyProp, "Default")\nend\n'})}),"\n",(0,r.jsx)(n.h2,{id:"combineprops",children:(0,r.jsx)(n.a,{href:"/api/Util#CombineProps",children:"CombineProps"})}),"\n",(0,r.jsxs)(n.p,{children:['Let\'s say you have a "CustomButton" component, and you want it to support ',(0,r.jsx)(n.code,{children:"Size"}),", ",(0,r.jsx)(n.code,{children:"Position"}),", and other arbitrary properties. Manually implementing all that boilerplate in the component itself is tedious. So let's have ",(0,r.jsx)(n.code,{children:"CombineProps"})," do the passthrough for us:"]}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-lua",children:'local Util = OnyxUI.Util\nlocal Themer = OnyxUI.Themer\nlocal Components = OnyxUI.Components\nlocal InnerScope = Fusion.innerScope\n\nreturn function(Props)\n  local Scope = InnerScope(Scope, Fusion, Util, Components)\n  local Theme = Themer.Theme:now()\n\n  return Scope:BaseButton(Util.CombineProps(Props, {\n    BackgroundTransparency = 0,\n    CornerRadius = Computed(function(Use)\n      return UDim.new(0, Use(Theme.CornerRadius["1"]))\n    end),\n\n    -- All properties from OnyxUI\'s `BaseButton` component will now work.\n  }))\nend\n'})}),"\n",(0,r.jsx)(n.h2,{id:"colors",children:(0,r.jsx)(n.a,{href:"/api/Util#Colors",children:"Colors"})}),"\n",(0,r.jsxs)(n.p,{children:["Color shorthands imported from ",(0,r.jsx)(n.a,{href:"https://tailwindcss.com/docs/customizing-colors#default-color-palette",children:"TailwindCSS's color palette"}),". So you don't have to worry about color picking anymore."]}),"\n",(0,r.jsx)(n.pre,{children:(0,r.jsx)(n.code,{className:"language-lua",children:'local Util = OnyxUI.Util\n\nreturn function(Props)\n  return Scope:Button {\n    Color = Util.Colors.Red["500"], -- Shade "500" of Colors.Red\n  }\nend\n'})})]})}function d(e={}){const{wrapper:n}={...(0,i.R)(),...e.components};return n?(0,r.jsx)(n,{...e,children:(0,r.jsx)(p,{...e})}):p(e)}},28453:(e,n,o)=>{o.d(n,{R:()=>s,x:()=>l});var t=o(96540);const r={},i=t.createContext(r);function s(e){const n=t.useContext(i);return t.useMemo((function(){return"function"==typeof e?e(n):{...n,...e}}),[n,e])}function l(e){let n;return n=e.disableParentContext?"function"==typeof e.components?e.components(r):e.components||r:s(e.components),t.createElement(i.Provider,{value:n},e.children)}}}]);