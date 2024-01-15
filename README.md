# DataverseSQL

![image](https://github.com/DynamicSadFun/DataverseSQL/assets/86048404/b9ba5e24-04cb-4a9b-a4fc-02e2353f058c)

### Project Overview
DataverseSQL serves as a robust toolkit for developers and data analysts seeking to leverage SQL within the Microsoft Power Platform's Dataverse. It bridges the gap between complex data structures and actionable insights, providing a suite of queries for enhanced data interaction and analytics.

### Technology Stack
This repository utilizes SQL, primarily focusing on the Power Platform's Dataverse environment. It harnesses the advanced querying capabilities of Dataverse, ensuring optimal compatibility and performance and extensibility for a range of analytics needs.

### Pre-requisites
1) enable TDS endpoint in your env:
   
https://community.dynamics.com/blogs/post/?postid=dbb726b6-430e-464c-af22-424ed88bcc1a
https://learn.microsoft.com/en-us/power-apps/developer/data-platform/dataverse-sql-query 

2) install XRMToolBox:
https://github.com/MscrmTools/XrmToolBox/releases/download/v1.2023.12.68/XrmToolbox.zip
3) install SQL 4 CDS plugin:
https://www.xrmtoolbox.com/plugins/MarkMpn.SQL4CDS/
4) Add a connection to your environment.

### How to Use
1. **Selecting a Query**: Identify the query that matches your data requirement from the repository.
2. **Understanding the Query**: Review the documentation within the script to understand its functionality and intended use case.
3. **Executing the Query**: Implement the query within your Dataverse environment, ensuring you have the necessary permissions and it's within a controlled development or testing environment.

### Usage Scenarios
- **Data Cleaning**: Use provided scripts to identify and rectify data discrepancies.
- **Analytics Reporting**: Leverage queries to generate custom reports and dashboards.
- **Operational Insights**: Execute scripts to gain operational insights from transactional

**Please be aware that Dataverse SQL has a number of limitations.**

Not all T-SQL functions are supported in it. Read more here:

https://learn.microsoft.com/en-us/power-apps/developer/data-platform/how-dataverse-sql-differs-from-transact-sql?tabs=supported
