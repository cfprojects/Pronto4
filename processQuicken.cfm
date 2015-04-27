<cfimport prefix="ui" taglib="layouts"/>
<ui:basic>
	<cftry>	
		<cfset thisPath = ExpandPath("*.*")>
		<cfset thisNewDir = "#GetDirectoryFromPath(thisPath)#\QuickenExports\"/>
		<cfset thisNewfile = "QuickenExport#dateFormat(now(),'mm_dd_yyyy')#.iif"/>
		<cfheader name="Content-Type" value="text/plain"> 
		<cfheader name="Content-Disposition" value="attachment; filename=#thisNewFile#">
		<cfif Len(form.invoiceMe)>
			
			<cfif NOT DirectoryExists(variables.thisNewDir)>
				<cfdirectory action="create" directory="#thisNewDir#">
			</cfif>
			<cfset invoiceItems = session.user.getUserTasksByList(form.invoiceMe)/>
			<cfset session.user.updateTaskAsInvoiced(form.invoiceMe)/>
			<cfsavecontent variable="h"><cfoutput>!TIMEACT#chr(9)#DATE#chr(9)#JOB#chr(9)#EMP#chr(9)#ITEM#chr(9)#PITEM#chr(9)#DURATION#chr(9)#PROJ#chr(9)#NOTE#chr(9)#BILLINGSTATUS#chr(13)##chr(10)#</cfoutput><cfoutput query="invoiceItems">TIMEACT#chr(9)##dateformat(startdate,"mm/dd/yyyy")##chr(9)##clientname##chr(9)##session.user.getFirstname()# #session.user.getLastname()##chr(9)##projectname##chr(9)##chr(9)##hours##chr(9)##chr(9)##tasktext##chr(9)#1#chr(13)##chr(10)#</cfoutput></cfsavecontent>
			<cffile action="write" file="#thisNewDir#\#thisNewfile#" output="#h#">
		<cfelse>
			<cfthrow message="You have to send something to be able to process it.">
		</cfif>
		
		<cfcatch type="any">
			<cfinclude template="error_msg.cfm">
		</cfcatch>
	</cftry>	
</ui:basic>