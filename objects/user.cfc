<cfcomponent displayname="User" output="false" hint="I am the user object.">
	<cfset variables.config = StructNew()>
	<cfset variables.config.userid = 0>
	<cfset variables.config.firstname = "">
	<cfset variables.config.lastname = "">
	<cfset variables.config.email = "">
	<cfset variables.config.role = "">
	<cfset variables.dsn = "">
	
	<cffunction name="init" output="false" access="public" returntype="User" hint="I create the app stored variables">
		<cfargument name="dsn" type="string" required="true"/>
		<cfset setDsn(arguments.dsn)>
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="Authenticate" output="false" access="public" returntype="query" hint="I authenticate the user upon login">
		<cfargument name="username" type="string" required="true"/>
		<cfargument name="password" type="string" required="true"/>
		<cfset var get = "">
		<cfset var update = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select *
			from users
			where 	username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#"/> 
					and password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#"/>
		</cfquery>
		
		<!--- If user checks out, update user object --->
		<cfif get.recordcount>
			<cfset setFirstName(get.firstname)>
			<cfset setLastName(get.lastname)>
			<cfset setEmail(get.email)>
			<cfset setRole(get.role)>
			<cfset setUserId(get.userid)>
			<cfquery name="update" datasource="#variables.dsn#">update users set lastvisit = #CreateODBCDate(Now())# where userid = #getUserId()#</cfquery>
		</cfif>
		<cfreturn get>
	</cffunction>
	
	<cffunction name="setfirstName" output="false" access="public" returntype="boolean" hint="I set the firstName internal variable">
		<cfargument name="varValue" type="string" required="true"/>
		<cfset variables.config.firstName = arguments.varValue>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getfirstName" output="false" access="public" returntype="any" hint="I get the firstName internal variable">
		<cfreturn #variables.config.firstName#/>
	</cffunction>

	<cffunction name="setlastName" output="false" access="public" returntype="boolean" hint="I set the lastName internal variable">
		<cfargument name="varValue" type="string" required="true"/>
		<cfset variables.config.lastName = arguments.varValue>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getlastName" output="false" access="public" returntype="any" hint="I get the lastName internal variable">
		<cfreturn #variables.config.lastName#/>
	</cffunction>

	<cffunction name="setEmail" output="false" access="public" returntype="boolean" hint="I set the Email internal variable">
		<cfargument name="varValue" type="string" required="true"/>
		<cfset variables.config.Email = arguments.varValue>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getEmail" output="false" access="public" returntype="any" hint="I get the Email internal variable">
		<cfreturn #variables.config.Email#/>
	</cffunction>

	<cffunction name="setRole" output="false" access="public" returntype="boolean" hint="I set the Role internal variable">
		<cfargument name="varValue" type="string" required="true"/>
		<cfset variables.config.Role = arguments.varValue>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getRole" output="false" access="public" returntype="any" hint="I get the Role internal variable">
		<cfreturn #variables.config.Role#/>
	</cffunction>

	<cffunction name="setUserId" output="false" access="public" returntype="boolean" hint="I set the userId internal variable">
		<cfargument name="varValue" type="string" required="true"/>
		<cfset variables.config.userId = arguments.varValue>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getUserId" output="false" access="public" returntype="any" hint="I get the userId internal variable">
		<cfreturn #variables.config.userId#/>
	</cffunction>
		
	<cffunction name="getUserProjects" output="false" access="public" returntype="query" hint="I get the user projects and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.projectname, a.projectid, c.clientname, a.billrate
			from projects a 
					inner join userProjects b on a.projectid = b.projectid
					inner join clients c on a.clientid = c.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/>
			order by a.projectname
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getClientList" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.clientname, a.clientid
			from clients a 
					inner join userClients b on a.clientid=b.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/>
			order by a.clientname
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getUserClients" output="false" access="public" returntype="query" hint="I get the user clients and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select *
			from clients a 
					inner join userClients b on a.clientid=b.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/>
			order by a.clientname
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getUserTasks" output="false" access="public" returntype="query" hint="I get the user tasks and ship it back to the api">
		<cfargument name="order" type="string" required="true"/>
		<cfargument name="keyword" type="string" required="true"/>
		<cfargument name="project" type="numeric" required="true"/>
		<cfargument name="client" type="numeric" required="true"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.*, c.sDesc as priorityname, d.projectname, d.billrate
			from tasks a 
					inner join userTasks b on a.taskid=b.taskid
					inner join listTypes c on a.priority=c.typeid
					inner join projects d on a.projectid = d.projectid
					inner join clients e on d.clientid = e.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/>
					<cfif arguments.keyword neq ''>
						 and  a.taskText like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"/>
						 or  a.optionalDesc like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.keyword#%"/>
					</cfif>
					<cfif arguments.project neq 0>
						 and  d.projectid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.project#"/>
					</cfif>
					<cfif arguments.client neq 0>
						 and  e.clientid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.client#"/>
					</cfif> and coalesce(a.isInvoiced,0) = 0
			order by 
			<cfswitch expression="#arguments.order#">
				<cfcase value="priorityASC">
					a.isComplete asc, a.priority asc
				</cfcase>
				<cfcase value="sdateASC">
					a.isComplete asc, a.startdate asc
				</cfcase>
				<cfcase value="ddateASC">
					a.isComplete asc, a.duedate asc
				</cfcase>
				<cfcase value="hoursASC">
					a.isComplete asc, a.hours asc
				</cfcase>
				<cfcase value="projectASC">
					a.isComplete asc, d.projectname asc
				</cfcase>
				<cfcase value="priorityDESC">
					a.isComplete asc, a.priority desc
				</cfcase>
				<cfcase value="sdateDESC">
					a.isComplete asc, a.startdate desc
				</cfcase>
				<cfcase value="ddateDESC">
					a.isComplete asc, a.duedate desc
				</cfcase>
				<cfcase value="hoursDESC">
					a.isComplete asc, a.hours desc
				</cfcase>
				<cfcase value="projectDESC">
					a.isComplete asc, d.projectname desc
				</cfcase>
			</cfswitch>	
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getUserCompletedTasks" output="false" access="public" returntype="query" hint="I get the user completed tasks and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.*, c.sDesc as priorityname, d.projectname, d.billrate
			from tasks a 
					inner join userTasks b on a.taskid=b.taskid
					inner join listTypes c on a.priority=c.typeid
					inner join projects d on a.projectid = d.projectid
					inner join clients e on d.clientid = e.clientid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/> and a.iscomplete = 1 and coalesce(a.isInvoiced,0) = 0
			order by a.duedate asc
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="getUserTasksByList" output="false" access="public" returntype="query" hint="I get the user invoiced tasks and ship it back to the api">
		<cfargument name="invoiceList" type="any" required="true"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select a.*, c.sDesc as priorityname, d.projectname, d.billrate, e.clientname
			from tasks a 
					inner join userTasks b on a.taskid=b.taskid
					inner join listTypes c on a.priority=c.typeid
					inner join projects d on a.projectid = d.projectid
					inner join clients e on d.clientid = e.clientid
			where a.taskid in (#arguments.invoiceList#)
		</cfquery>
		<cfreturn #get#/>
	</cffunction>
	
	<cffunction name="updateTaskAsInvoiced" output="false" access="public" returntype="boolean" hint="I invoice tasks">
		<cfargument name="invoiceList" type="any" required="true"/>
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			update tasks
			set isInvoiced = 1
			where taskid in (#arguments.invoiceList#)
		</cfquery>
		<cfreturn true/>
	</cffunction>
	
	<cffunction name="getUserTasksSum" output="false" access="public" returntype="numeric" hint="I get the user tasks and ship it back to the api">
		<cfset var get = "">
		<cfquery name="get" datasource="#variables.dsn#">
			select sum(hours) as sumOfHours
			from tasks a 
					inner join userTasks b on a.taskid=b.taskid
			where b.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#getUserId()#"/> and coalesce(a.isInvoiced,0) = 0
		</cfquery>
		<cfreturn #get.sumOfHours#/>
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