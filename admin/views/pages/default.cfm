<cfset local.routes = variables.framework.routes />

<cfoutput>
	<div class="page-header clear"><h1>Pages</h1></div>
	
	#view( "helpers/messages" )#
	
	<table class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>Title</th>
				<th>Last Updated</th>
				<th class="center">View</th>
				<cfif rc.config.page.enableadddelete><th class="center">Add Page</th></cfif>
				<th class="center">Sort Sub Pages</th>
				<cfif rc.config.page.enableadddelete><th class="center">Delete</th></cfif>
			</tr>
		</thead>
		
		<tbody>
			<cfloop query="rc.navigation">
				<cfset local.offset = ( ( rc.navigation.depth - 1 ) * 15 )>
				<tr>
					<td <cfif rc.navigation.depth gt 1>class="chevron-right" style="padding-left:#local.offset+20#px; background-position:#local.offset#px 50%"</cfif>>
						<cfif isRoute( rc.navigation.slug )>
							#rc.navigation.title# <i class="icon-exclamation-sign"></i>
						<cfelse>
							<a href="#buildURL( action='pages.maintain', querystring='pageid/#rc.navigation.pageid#' )#" title="Edit #rc.navigation.title#">#rc.navigation.title#</a>
						</cfif>
					</td>
					<td title="last updated on #DateFormat( rc.navigation.updated, 'medium' )# at #TimeFormat( rc.navigation.updated, 'HH:MM' )#">#getTimeInterval( rc.navigation.updated )# by # rc.navigation.updatedby#</td>
					<td class="center"><a href="#buildURL( action="public:" & rc.navigation.slug )#" title="View" target="_blank"><i class="icon-eye-open"></i></a></td>
					<cfif rc.config.page.enableadddelete><td class="center"><cfif rc.navigation.depth lt rc.config.page.maxlevels and !ListFind( rc.config.page.suppressaddpage, rc.navigation.pageid )><a href="#buildURL( action='pages.maintain', querystring='ancestorid/#rc.navigation.pageid#' )#" title="Add Page"><i class="icon-plus-sign"></i></a></cfif></td></cfif>
					<td class="center"><cfif rc.navigation.descendants gt 1><a href="#buildURL( action='pages.sort', querystring='pageid/#rc.navigation.pageid#' )#" title="Sort"><i class="icon-retweet"></i></a></cfif></td>
					<cfif rc.config.page.enableadddelete><td class="center"><cfif rc.navigation.descendants eq 0 and !ListFind( rc.config.page.suppressdeletepage, rc.navigation.pageid )><a href="#buildURL( 'pages.delete' )#/pageid/#rc.navigation.pageid#" title="Delete"><i class="icon-remove"></i></a></cfif></td></cfif>
				</tr>
			</cfloop>
		</tbody>
	</table>
	
	<p id="routes-alert" style="display:none"><i class="icon-exclamation-sign"></i> You cannot edit or delete this page because it redirects to another website feature.</p>
	
	<p><span class="label label-info">Heads up!</span> Please allow a minute for the navigation to update when adding and removing pages. We've cached it to make it super fast!</p>
</cfoutput>

<script>
jQuery(function($){
	if($('tr>td i.icon-exclamation-sign').length){
		$('#routes-alert').show();
	}
})
</script>