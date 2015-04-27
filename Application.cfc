<cfcomponent displayname="Application" output="true" hint="Handle the application.">
  
	<!--- Set up the application. --->
	<cfscript>
		this.name = "Pronto";
		this.clientManagement = 'yes';
		this.sessionManagement = true;
		this.sessiontimeout = #CreateTimeSpan(0,2,30,0)#;
		this.setclientcookies = "yes"; 
		this.loginstorage = "session";
	</cfscript>
 
	<!--- Define the page request properties. --->
	<cfsetting requesttimeout="20" showdebugoutput="true" enablecfoutputonly="false"/><!--- 
	<cferror exception="ANY" type="request" template="error.cfm"> --->
	 
	<cffunction	name="OnApplicationStart" access="public" returntype="boolean"	output="false" hint="Fires when the application is first created.">
	 	<cfreturn true />
	</cffunction>
	 
	 
	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Fires at first part of page processing.">
		<cfargument name="TargetPage" type="string" required="true"/>
		<cflogin idletimeout="9000">
			<cfif isDefined("cflogin")>				
				<cftry>
					<!--- Check if the username and password fields are empty --->
					<cfif cflogin.name eq ''>
						<cfthrow message="UserName is a required field.">
					</cfif>
					<cfif cflogin.password eq ''>
						<cfthrow message="Password is a required field.">
					</cfif>
					
					<!--- Run the login query and then display result --->
					<cflock scope="Session" timeout="30" type="exclusive">
						<cfset session.user = createObject("component","objects.user").init('pronto')>
						<cfset session.app = createObject("component","objects.app").init('pronto')>
						<cfset qUserAccount = session.user.Authenticate(cflogin.name, cflogin.password)>								
					</cflock>
					<cfif qUserAccount.recordcount gt 0>
						<cfloginuser name="#cflogin.name#" password="#cflogin.password#" roles="#qUserAccount.role#">
					<cfelse>
						<cfthrow message="Your username and/or password are incorrect, please try and log in again.">
					</cfif>
					
					<cfcatch type="any">
						<cfinclude template="error_msg.cfm">
					</cfcatch>
				</cftry>
			<cfelse>
				<cfinclude template="Login.cfm">
				<cfif isdefined("session.user")>
					<cfset y = StructClear(session.user)>
				</cfif>
				<cflogout>
				<cfabort>
			</cfif>
			
		</cflogin>
			
	 	<cfreturn true />
	</cffunction>
	 
	 
	<cffunction name="OnApplicationEnd" access="public" returntype="void" output="false" hint="Fires when the application is terminated.">
		<cfargument name="ApplicationScope" type="struct" required="false" default="#StructNew()#"/>
		<cfreturn />
	</cffunction>
	 
	 
 
</cfcomponent>