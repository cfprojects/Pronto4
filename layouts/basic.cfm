<cfparam name="attributes.hideMenu" default="0"/>
<cfif thisTag.ExecutionMode eq 'start'>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Pronto - Project Management</title>
		<link type="text/css" href="scripts/mainstyle.css" rel="stylesheet" media="screen">
	</head>
	
	<body>
		<cfif NOT attributes.hideMenu>
			<div class="mainHeader">
				<div class="headerText">Pronto <span class="headerVersion">v1.0</span></div>
			</div>
			<cfif Len(GetAuthUser())>
				<cfmenu bgcolor="##5280FF" font="Verdana" fontsize="10" childstyle="padding: 10px 10px 10px 10px; font-weight:bold;"
						fontcolor="##FFFFFF" name="mainMenu" selectedfontcolor="##5280FF" 
						selecteditemcolor="##FFFFFF" type="horizontal">
					<cfmenuitem display="Home" href="index.cfm"/>
					<cfmenuitem display="Projects" href="projects.cfm"/>
					<cfmenuitem display="Tasks" href="tasks.cfm"/>
					<cfif isUserInRole('admin')><cfmenuitem display="Users" href="users.cfm"/></cfif>
					<cfmenuitem display="Clients" href="clients.cfm"/>
					<cfmenuitem display="Quicken Tasks Export" href="qExport.cfm"/>
					<cfmenuitem display="Log Out" href="logout.cfm"/>
				</cfmenu>
			</cfif>
		</cfif>
		<div class="mainContent">	
		
</cfif>
<cfif thisTag.ExecutionMode eq 'end'>
		</div>
		
		<br style="clear:both;" />
	</body>
	</html>
</cfif>		