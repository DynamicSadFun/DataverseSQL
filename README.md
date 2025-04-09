# **DataverseSQL**

![image](https://github.com/DynamicSadFun/DataverseSQL/assets/86048404/b9ba5e24-04cb-4a9b-a4fc-02e2353f058c)

Welcome to the **DataverseSQL** repository! This collection showcases useful SQL queries for working with Microsoft Dataverse environments via the TDS (Tabular Data Stream) endpoint. Whether you're troubleshooting, analyzing metadata, or extracting complex relationships, this repository has you covered.

## **Overview**

Dataverse supports direct querying using SQL via the TDS endpoint. This repository provides tested and reusable SQL scripts to interact with Dataverse metadata, retrieve business data, and analyze your environment.
These queries:
- Enhance productivity by simplifying data analysis.
- Serve as templates for custom scripts tailored to your needs.
- Demonstrate advanced querying techniques for Dataverse environments.

## **Features**

### 🔍 **Comprehensive Queries**
This repository includes scripts for:
- Metadata analysis (tables, columns, relationships, etc.).
- Business entity insights (contacts, accounts, activities, etc.).
- Advanced relationships (hierarchies, lookups, 1:N and N:N relationships).
- Plugin, workflow, and process diagnostics.

### 🛠️ **Extensibility**
Each query is modular and easy to adapt for your specific use cases.

### 🚀 **Real-World Examples**
These scripts solve real-world Dataverse challenges, including:
- Identifying unused fields or custom entities.
- Tracking solution dependencies and customizations.
- Monitoring and optimizing system performance.

## **How to Use**
1. **Prerequisites**:
   - Access to the Dataverse environment.
   - Enable the TDS endpoint in your environment (admin access required):
     
      https://community.dynamics.com/blogs/post/?postid=dbb726b6-430e-464c-af22-424ed88bcc1a
     
      https://learn.microsoft.com/en-us/power-apps/developer/data-platform/dataverse-sql-query
     
   - SQL client can connect to the TDS endpoint (e.g., SQL Server Management Studio, Azure Data Studio).

2. **Connect to the Dataverse TDS Endpoint**:
   - Use your environment URL as the server name (e.g., `yourenvironment.crm.dynamics.com`).
   - Authenticate using Azure Active Directory credentials.

3. **Run the Queries**:
   - Copy the desired SQL query from this repository.
   - Paste it into your SQL client.
   - Execute the query and review the results.

**Important!**
Some queries, especially those containing the WITH construct, may not work in SSMS or other tools. 
This is why I strongly recommend that you use XrmToolBox and SQL4CDS. There all 100% of queries work properly: 
https://markcarrington.dev/sql-4-cds/

---

## **Contributing**

Contributions are welcome! If you have a useful SQL query for Dataverse, feel free to open a pull request or submit an issue.

---

## **Acknowledgements**

Special thanks to the Microsoft Dataverse community for providing tools, guidance, and inspiration for these queries.
