webpackJsonp([3],{0:function(e,t,n){var i,r,o,s,a,l,c,u,d,h,p,f,m,g,v,b,y,w,_,k,x;g=n(4),o=n(2),u=n(5),n(33),n(31),h=n(10),f=n(6),m=n(32),s=n(45),i=n(104),k=n(110),a=k.BootstrapNavBarView,c=k.MainSearchFormView,n(106),l=o.Radio.channel("global"),d=o.Radio.channel("messages"),p=o.Radio.channel("resources"),r="eidolon",w=function(e,t){var n,i,r,o;return o=l.request("main:app:regions"),n=l.request("main:app:appmodel"),i=new m.MainPageLayout,i.on("show",function(e){return function(){var e,n,i,r;return i=new a({model:t}),r=o.get("navbar"),r.show(i),e=new m.MessagesView({collection:d.request("messages")}),n=o.get("messages"),n.show(e)}}(this)),r=o.get("mainview"),r.show(i)},_=function(e,t,n){var i,r,a;return a=t.get("regions"),"modal"in a&&(a.modal=s),r=new o.Marionette.RegionManager,r.addRegions(a),i=r.get("navbar"),i.on("show",function(e){return function(){return l.trigger("appregion:navbar:displayed")}}(this)),l.reply("main:app:object",function(){return e}),l.reply("main:app:regions",function(){return r}),l.reply("main:app:get-region",function(e){return r.get(e)}),e.on("start",function(){var e,i,r,s,a,c;for(i=t.get("frontdoor_app"),l.request("applet:"+i+":route"),a=t.get("applets"),r=0,s=a.length;s>r;r++)e=a[r],c="applet:"+e.appname+":route",l.request(c);return l.request("mainpage:init",t,n),o.history.started?void 0:o.history.start()})},l.reply("main:app:appmodel",function(){return i}),l.reply("mainpage:init",function(e){return function(e,t){var n;return n=l.request("main:app:object"),w(n,t),l.trigger("mainpage:displayed")}}(this)),l.on("appregion:navbar:displayed",function(){var e,t;return t=new c({model:p.request("current-document")}),e=l.request("main:app:get-region","search"),e.show(t)}),v=new u.Application,y=location.pathname,f.str_endswith(y,"@@eidolon")&&(y=y.split("@@eidolon")[0]),"/"===y&&(y=""),b=p.request("get-document",y),p.reply("current-document",function(){return b}),x=b.fetch(),x.done(function(){var e;return _(v,i,b),v.start(),e=b.get("data"),$("title").text(e.attributes.title)}),e.exports=v},104:function(e,t,n){var i,r,o,s,a,l,c,u=function(e,t){function n(){this.constructor=e}for(var i in t)d.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},d={}.hasOwnProperty;i=n(3),c=n(3),s=n(4),r=n(2),o=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return u(t,e),t.prototype.defaults={brand:{name:"Brand",url:"/"},frontdoor_app:"frontdoor",hasUser:!1,frontdoor_sidebar:[{name:"Home",url:"/"}],applets:[],regions:{},routes:[]},t}(r.Model),l={mainview:"body",navbar:"#navbar-view-container",sidebar:"#sidebar",breadcrumbs:"#breadcrumbs",content:"#main-content",messages:"#messages",footer:"#footer",modal:"#modal",usermenu:"#user-menu",search:"#form-search-container"},a=new o({hasUser:!0,brand:{name:"Kotti",url:"/"},applets:[],regions:l}),e.exports=a},105:function(e,t,n){var i,r,o,s,a,l,c,u,d,h,p=function(e,t){function n(){this.constructor=e}for(var i in t)f.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},f={}.hasOwnProperty;i=n(3),r=n(2),l=n(5),h=n(12),a=n(27).MainController,s=r.Radio.channel("global"),c=r.Radio.channel("messages"),u=r.Radio.channel("resources"),d=n(108),o=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return p(t,e),t.prototype.make_main_content=function(){var e;return e=new d.FrontDoorMainView({model:this.current_resource}),this._show_content(e)},t.prototype._view_resource=function(){var e;return e=this.current_resource.fetch(),e.done(function(e){return function(){var t,n,r,o;return t=e.current_resource.get("data"),n=e.current_resource.get("meta"),o="folder_view"===n.default_view?d.FrontDoorMainView:d.FrontDoorMainView,r=new o({model:e.current_resource}),e._show_content(r),i("title").text(t.attributes.title),s.request("make-breadcrumbs",e.current_resource)}}(this))},t.prototype.view_resource=function(e){return this._set_resource(e),this._view_resource()},t.prototype.frontdoor=function(){return this._view_resource()},t.prototype.start=function(){return this.make_main_content()},t}(a),e.exports=o},106:function(e,t,n){var i,r,o,s,a,l,c,u,d,h=function(e,t){function n(){this.constructor=e}for(var i in t)p.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},p={}.hasOwnProperty;i=n(2),a=n(5),d=n(6),r=n(26),o=n(105),s=i.Radio.channel("global"),l=i.Radio.channel("messages"),c=i.Radio.channel("resources"),u=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return h(t,e),t.prototype.appRoutes={"":"view_resource",frontdoor:"view_resource","frontdoor/view":"view_resource","frontdoor/view/*resource":"view_resource"},t}(r),s.reply("applet:frontdoor:route",function(){var e,t;return e=new o(s),e.current_resource=c.request("current-document"),t=new u({controller:e})})},107:function(e,t,n){var i,r,o,s,a,l,c,u,d,h;h=n(8),c=n(12),d=n(11),u=d.navbar_collapse_button,o=d.dropdown_toggle,l=d.frontdoor_url,s=d.editor_url,a=h.renderable(function(e){return h.raw(e.data.attributes.body)}),i=h.renderable(function(e){var t,n;return t=e.data.attributes,n=e.data.type,h.article(".document-view.content",function(){return h.div(".body",function(){return"Document"===n?h.raw(t.body):"MarkDownDocument"===n?h.raw(c(t.body)):console.warn("Don't know how to render "+n)})})}),r=h.renderable(function(e){var t,n;return t=e.data.attributes,n=e.data.relationships.meta,h.article(".document-view.content",function(){return h.h1(t.title),h.p(".lead",t.description),h.h2("Contents"),h.div(".body",function(){return h.table(".table.table-condensed",function(){return h.thead(function(){return h.tr(function(){return h.th("Title"),h.th("Type"),h.th("Creation Date"),h.th("Modification Date")})}),h.tbody(function(){var e,t,i,r,o,s,a;for(o=n.children,s=[],i=0,r=o.length;r>i;i++)e=o[i],a=e.data.relationships.meta.type_info,t=l(e.path),s.push(h.tr(function(){return h.td(function(){return h.a({href:t},e.data.attributes.title)}),h.td(function(){return h.a({href:t},a.title)}),h.td(function(){return h.a({href:t},e.meta.creation_date)}),h.td(function(){return h.a({href:t},e.meta.modification_date)})}));return s})})})})}),e.exports={frontdoor_main:a,DefaultViewTemplate:i,FolderViewTemplate:r}},108:function(e,t,n){var i,r,o,s,a,l,c,u,d,h,p=function(e,t){function n(){this.constructor=e}for(var i in t)f.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},f={}.hasOwnProperty;i=n(2),l=n(5),r=n(107),h=n(29),u=n(6),d=u.remove_trailing_slashes,c=u.make_json_post,n(25),a=i.Radio.channel("global"),s=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return p(t,e),t.prototype.template=r.DefaultViewTemplate,t.prototype.onDomRefresh=function(){return $(".ui-draggable").draggable()},t}(i.Marionette.ItemView),o=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return p(t,e),t.prototype.template=r.FolderViewTemplate,t}(i.Marionette.ItemView),e.exports={FrontDoorMainView:s,FolderView:o}},109:function(e,t,n){var i,r,o,s,a,l,c,u,d,h,p,f;i=n(3),r=n(4),p=n(8),d=n(19),u=d.navbar_collapse_button,o=d.dropdown_toggle,h=n(11),s=h.frontdoor_url,f=h.user_menu_dropdown,f=p.renderable(function(e){var t,n;return t=e.data.relationships.meta,n=t.current_user,null===n?p.li(".pull-right",function(){return p.a({href:"/login"},"Login")}):p.li(".dropdown.pull-right",function(){return o(function(){return p.text(n.title),p.b(".caret")}),p.ul("#user-dropdown.dropdown-menu",function(){return p.li(function(){return p.a({href:n.prefs_url},function(){return p.i(".fa.fa-gears.fa-fw"),p.span("Preferences")})}),p.li(function(){return p.a({href:"/@@dashboard"},function(){return p.i(".fa.fa-dashboard.fa-fw"),p.span("Dashboard")})}),t.has_permission.admin&&(p.li(".divider"),p.li(".dropdown-header",{role:"presentation"},function(){return p.text("Site Setup")}),p.li(function(){return p.a({href:"/@@dashboard#setupusers"},"User Administration")})),p.li(function(){return p.a({href:"/@@logout"},function(){return p.i(".fa.fa-sign-out.fa-fw"),p.span("Logout")})})})})}),c=p.renderable(function(e){var t;return t=e.data.relationships.meta,p.form("#form-search.navbar-form.navbar-right",{role:"search",method:"post",action:t.root_url+"@@search-results"},function(){return p.div(".form-group",function(){return p.input(".form-control",{name:"search-term",type:"search",placeholder:"Search..."})}),p.button(".btn.btn-default",{type:"submit",name:"search-submit",value:"search",style:"display: none;"},function(){return p.raw("&#8594")})})}),l=p.renderable(function(e){var t;return t=e.data.relationships.meta,p.div(".container-fluid",function(){return p.div(".navbar-header",function(){return u("navbar-view-collapse"),p.a(".navbar-brand",{href:"#frontdoor"},t.site_title)}),p.div("#navbar-view-collapse.collapse.navbar-collapse",function(){return p.ul(".nav.navbar-nav",function(){var e,n,i,r,o,a;for(o=t.navitems,a=[],e=0,r=o.length;r>e;e++)i=o[e],n="",i.inside&&(n=".active"),a.push(p.li(n,function(){return p.a({href:s(i.path),title:i.description},i.title)}));return a}),p.ul("#user-menu.nav.navbar-nav.navbar-right",function(){return f(e)}),p.div("#form-search-container")})})}),a=p.renderable(function(e){return p.nav("#navbar-view.navbar.navbar-static-top.navbar-default",{xmlns:"http://www.w3.org/1999/xhtml","xml:lang":"en",role:"navigation"},function(){return l(e)})}),e.exports={nav_pt_search:c,nav_pt:a}},110:function(e,t,n){var i,r,o,s,a,l,c,u=function(e,t){function n(){this.constructor=e}for(var i in t)d.call(t,i)&&(e[i]=t[i]);return n.prototype=t.prototype,e.prototype=new n,e.__super__=t.prototype,e},d={}.hasOwnProperty;i=n(2),a=n(5),c=n(109),o=i.Radio.channel("global"),l=i.Radio.channel("messages"),r=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return u(t,e),t.prototype.template=c.nav_pt,t.prototype.regions={usermenu:"#user-menu",mainmenu:"#main-menu"},t}(i.Marionette.LayoutView),s=function(e){function t(){return t.__super__.constructor.apply(this,arguments)}return u(t,e),t.prototype.template=c.nav_pt_search,t}(i.Marionette.ItemView),e.exports={MainSearchFormView:s,BootstrapNavBarView:r}}});
//# sourceMappingURL=eidolon-a120b071fdca223101c1.js.map