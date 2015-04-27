<cfcomponent displayname="App" hint="I am the system app object" output="false">
	<cfset variables.dsn = "">
	
	
	<cffunction name="init" output="false" access="public" returntype="App" hint="I create the app stored variables">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset setDsn(arguments.dsn)>
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="addProject" output="false" access="public" returntype="boolean" hint="I create a new project">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				insert into projects(projectname,clientid,billrate)
				values(<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.projectName#"/>,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.clientid#"/>,
						<cfqueryparam cfsqltype="cf_sql_float" value="#arguments.currForm.billrate#"/>)
				select @@identity as newId
			</cfquery>
			<cfquery name="set" datasource="#variables.dsn#">
				insert into userprojects(userid,projectid)
				values(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#setP.newId#"/>)
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="updateProject" output="false" access="public" returntype="boolean" hint="I update a project">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var set = "">
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="set" datasource="#variables.dsn#">
				update projects
				set projectname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.projectName#"/>,
					clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.clientid#"/>,
					billrate = <cfqueryparam cfsqltype="cf_sql_float" value="#arguments.currForm.billrate#"/>
				where projectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.p#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="deleteProject" output="false" access="public" returntype="boolean" hint="I delete a project">
		<cfargument name="projectid" type="numeric" required="true"/>
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from userprojects where projectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.projectid#"/>
				delete from projects where projectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.projectid#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getProjectForEdit" output="false" access="public" returntype="query" hint="I get the user projects and ship it back to the api">
		<cfargument name="projectid" type="numeric" required="false"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.projectname, a.clientid, a.projectid, a.billrate
			from projects a 
			where a.projectId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.projectid#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getClientForEdit" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfargument name="clientid" type="numeric" required="false"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select *
			from clients
			where clientId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientId#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getTypes" output="false" access="public" returntype="query" hint="I get types for drop downs.">
		<cfargument name="sType" type="string" required="false"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select *
			from listTypes
			where sType = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.sType#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getTaskForEdit" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfargument name="taskid" type="numeric" required="false"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select tasktext, startdate, duedate, hours, priority, projectid, isComplete, optionalDesc, taskid
			from tasks
			where taskid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.taskid#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="addClient" output="false" access="public" returntype="boolean" hint="I create a new project">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				insert into clients
				(
					clientname,
					address1,
					address2,
					city,
					state,
					zip
				)
				values
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.clientName#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.address1#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.address2#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.city#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.state#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.zip#"/>
				)
				select @@identity as newId
			</cfquery>
			<cfquery name="set" datasource="#variables.dsn#">
				insert into userclients(userid,clientid)
				values(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#setP.newId#"/>)
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="updateClient" output="false" access="public" returntype="boolean" hint="I update a project">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				update clients
				set clientname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.clientName#"/>,
					address1 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.address1#"/>,
					address2 = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.address2#"/>,
					city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.city#"/>,
					state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.state#"/>,
					zip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.zip#"/>
				where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.c#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="deleteClient" output="false" access="public" returntype="boolean" hint="I delete a client">
		<cfargument name="clientid" type="numeric" required="true"/>
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from clients where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientid#"/>
				delete from userclients where clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.clientid#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="addTask" output="false" access="public" returntype="boolean" hint="I create a new task">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				insert into tasks
				(
					tasktext,
					startdate,
					duedate,
					hours,
					priority,
					projectid,
					optionalDesc,
					isComplete
				)
				values
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.tasktext#"/>,
					<cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(arguments.currForm.startdate)#"/>,
					<cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(arguments.currForm.duedate)#"/>,
					<cfqueryparam cfsqltype="cf_sql_float" value="#arguments.currForm.hours#"/>,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.priority#"/>,
					<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.projectid#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.optionalDesc#"/>,
					<cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.currForm.isComplete#"/>
				)
				select @@identity as newId
			</cfquery>
			<cfquery name="set" datasource="#variables.dsn#">
				insert into usertasks(userid,taskid)
				values(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>,
						<cfqueryparam cfsqltype="cf_sql_integer" value="#setP.newId#"/>)
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="updateTask" output="false" access="public" returntype="boolean" hint="I update a task">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				update tasks
				set tasktext = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.tasktext#"/>,
					startdate = <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(arguments.currForm.startdate)#"/>,
					duedate = <cfqueryparam cfsqltype="cf_sql_date" value="#createODBCDate(arguments.currForm.duedate)#"/>,
					hours = <cfqueryparam cfsqltype="cf_sql_float" value="#arguments.currForm.hours#"/>,
					priority = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.priority#"/>,
					projectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.projectid#"/>,
					optionalDesc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.optionalDesc#"/>,
					iscomplete = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.currForm.iscomplete#"/>
				where taskid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.t#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="setComplete" output="false" access="public" returntype="boolean" hint="I update the task and set it as completed">
		<cfargument name="taskid" type="numeric" required="true"/>
		<cfargument name="setTo" type="boolean" required="true"/>
		<cfset set = "">
		<cftransaction isolation="serializable">
			<cfquery name="set" datasource="#variables.dsn#">
				update tasks
				set isComplete = <cfif arguments.setTo eq true>
									<cfqueryparam cfsqltype="cf_sql_bit" value="1"/>
								<cfelse>
									<cfqueryparam cfsqltype="cf_sql_bit" value="0"/>
								</cfif>
				where taskid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.taskid#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="deleteTask" output="false" access="public" returntype="boolean" hint="I delete a client">
		<cfargument name="taskid" type="numeric" required="true"/>
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from tasks where taskid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.taskid#"/>
				delete from usertasks where taskid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.taskid#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getUsers" output="false" access="public" returntype="query" hint="I delete a client">
		<cfset var get = "">
		<cftransaction isolation="serializable">
			<cfquery name="get" datasource="#variables.dsn#">
				select * 
				from users
			</cfquery>
		</cftransaction>
		<cfreturn get/>
	</cffunction>
	
	<cffunction name="addUser" output="false" access="public" returntype="boolean" hint="I create a new task">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				insert into users
				(
					firstname,
					lastname,
					username,
					password,
					email,
					role
				)
				values
				(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.firstname#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.lastname#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.username#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.password#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.email#"/>,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.role#"/>
				)
				select @@identity as newId
			</cfquery>
			<cfif ListLen(arguments.currForm.projectList)>
				<cfloop list="#arguments.currForm.projectList#" index="d">
					<cfquery name="set" datasource="#variables.dsn#">
						insert into userProjects(userid,projectid)
						values(<cfqueryparam cfsqltype="cf_sql_integer" value="#setP.newId#"/>,
								<cfqueryparam cfsqltype="cf_sql_integer" value="#d#"/>)
					</cfquery>
				</cfloop>
			</cfif>
			<cfif ListLen(arguments.currForm.clientList)>
				<cfloop list="#arguments.currForm.clientList#" index="s">
					<cfquery name="set" datasource="#variables.dsn#">
						insert into userClients(userid,clientid)
						values(<cfqueryparam cfsqltype="cf_sql_integer" value="#setP.newId#"/>,
								<cfqueryparam cfsqltype="cf_sql_integer" value="#s#"/>)
					</cfquery>
				</cfloop>
			</cfif>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="updateUser" output="false" access="public" returntype="boolean" hint="I update a task">
		<cfargument name="currForm" type="struct" required="true"/>
		<cfset var set = "">
		<cfset var setP = "">
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="setP" datasource="#variables.dsn#">
				update users
				set firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.firstname#"/>,
					lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.lastname#"/>,
					username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.username#"/>,
					password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.password#"/>,
					email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.currForm.email#"/>,
					role = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.role#"/>
				where userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.u#"/>
			</cfquery>
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from userProjects where userid = #arguments.currForm.u#
			</cfquery>
			<cfif ListLen(arguments.currForm.projectList)>
				<cfloop list="#arguments.currForm.projectList#" index="d">
					<cfquery name="set" datasource="#variables.dsn#">
						insert into userProjects(userid,projectid)
						values(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.u#"/>,
								<cfqueryparam cfsqltype="cf_sql_integer" value="#d#"/>)
					</cfquery>
				</cfloop>
			</cfif>
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from userClients where userid = #arguments.currForm.u#
			</cfquery>
			<cfif ListLen(arguments.currForm.clientList)>
				<cfloop list="#arguments.currForm.clientList#" index="s">
					<cfquery name="set" datasource="#variables.dsn#">
						insert into userClients(userid,clientid)
						values(<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.currForm.u#"/>,
								<cfqueryparam cfsqltype="cf_sql_integer" value="#s#"/>)
					</cfquery>
				</cfloop>
			</cfif>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getUserForEdit" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfargument name="userId" type="numeric" required="false"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select *
			from users
			where userId = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userId#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="deleteUser" output="false" access="public" returntype="boolean" hint="I delete a client">
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var delete = "">
		<cftransaction isolation="serializable">
			<cfquery name="delete" datasource="#variables.dsn#">
				delete from users where userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>
				delete from userProjects where userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>
				delete from userClients where userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>
			</cfquery>
		</cftransaction>
		<cfreturn true/>
	</cffunction>
	
	
	<cffunction name="getProjectsForUsers" output="false" access="public" returntype="query" hint="I get the user projects and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.projectname, a.projectid, a.billrate, a.clientid
			from projects a 
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getClientListForUsers" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.clientname, a.clientid
			from clients a 
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getProjectsByUserId" output="false" access="public" returntype="query" hint="I get the user projects and ship it back to the api">
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.projectname, a.projectid, d.clientname
			from projects a 
					inner join userProjects b on a.projectid = b.projectid
					inner join clients d on d.clientid = a.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getClientLisByUserId" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfargument name="userid" type="numeric" required="true"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.clientname, a.clientid
			from clients a 
					inner join userClients b on a.clientid=b.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.userid#"/>
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="formatText" output="false" access="public" returntype="string" hint="I clean up text and return it to you">
		<cfargument name="textToFormat" type="string" required="true"/>
		<cfset var h = ""/>
		<cfset h = swapCRtoBR(arguments.textToFormat)/>
		<cfreturn h/>
	</cffunction>
	
	<cffunction name="swapCRtoBR" output="false" access="public" returntype="string" hint="I swap CR with BR">
		<cfargument name="textToFormat" type="string" required="true"/>
		<cfset var setVar = ""/>
		<cfset setVar = Replace(arguments.textToFormat,chr(13),"<br />","ALL")/>
		<cfreturn setVar />
	</cffunction>
	
	<cffunction name="getDsn" output="false" access="public" returntype="any" hint="I get the dsn internal variable">
		<cfreturn #variables.dsn#/>
	</cffunction>
		
	<cffunction name="setDsn" output="false" access="public" returntype="any" hint="I set the dsn internal variable">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset variables.dsn = arguments.dsn>
		<cfreturn true/>
	</cffunction>
	
</cfcomponent>